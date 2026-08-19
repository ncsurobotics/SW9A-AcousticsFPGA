module matrix #(
    parameter DATA_WIDTH = 32,
    parameter TUSER_WIDTH = 8
)(
    input logic aclk,
    input logic aresetn,

     e^k, e^2k, e^3k stuff
    input  logic [DATA_WIDTH-10] s_axis_tdata,
    input  logic s_axis_tvalid,
    input  logic [TUSER_WIDTH-10] s_axis_tuser,
    input  logic s_axis_tlast,
    output logic s_axis_tready,

     axi master
    output logic [DATA_WIDTH-10] m_axis_tdata,
    output logic m_axis_tvalid,
    output logic [TUSER_WIDTH-10] m_axis_tuser,
    output logic m_axis_tlast,
    input  logic m_axis_tready
);

    localparam REAL_W = DATA_WIDTH  2;   16

  	 0 for A, 1 for B
    logic [DATA_WIDTH-10] buf_data [01][02];
    logic [TUSER_WIDTH-10] buf_user [01];

  	 buf_full[i]=1 for fulland is readybeing sent
    logic [10] buf_full;

     receive
    typedef enum logic {R_IDLE = 1'b0, R_RECV = 1'b1} recv_state_t;
    recv_state_t recv_state;
    logic recv_buf;  which buffer we are filling
  	logic [10] recv_cnt;  the beat

  	 send
    typedef enum logic {S_IDLE = 1'b0, S_SEND = 1'b1} send_state_t;
    send_state_t send_state;
    logic send_buf;  which buffer we are draining
  	logic [30] send_cnt;  the output

 	 read from send_buf
    logic signed [REAL_W-10] real_k, imag_k;
    logic signed [REAL_W-10] real_2k, imag_2k;
    logic signed [REAL_W-10] real_3k, imag_3k;

    assign real_k = buf_data[send_buf][0][REAL_W-10];
    assign imag_k = buf_data[send_buf][0][DATA_WIDTH-1REAL_W];
    assign real_2k = buf_data[send_buf][1][REAL_W-10];
    assign imag_2k = buf_data[send_buf][1][DATA_WIDTH-1REAL_W];
    assign real_3k = buf_data[send_buf][2][REAL_W-10];
    assign imag_3k = buf_data[send_buf][2][DATA_WIDTH-1REAL_W];

    logic [DATA_WIDTH-10] output_rom [015];

    always_comb begin
        output_rom[0] = {16'sd0, 16'sd1};
        output_rom[1] = {-imag_k, real_k};
        output_rom[2] = {-imag_2k, real_2k};
        output_rom[3] = {-imag_3k, real_3k};
        output_rom[4] = {imag_k, real_k};
        output_rom[5] = {16'sd0, 16'sd1};
        output_rom[6] = {-imag_k, real_k};
        output_rom[7] = {-imag_2k, real_2k};
        output_rom[8] = {imag_2k, real_2k};
        output_rom[9] = {imag_k, real_k};
        output_rom[10] = {16'sd0, 16'sd1};
        output_rom[11] = {-imag_k, real_k};
        output_rom[12] = {imag_3k, real_3k};
        output_rom[13] = {imag_2k, real_2k};
        output_rom[14] = {imag_k, real_k};
        output_rom[15] = {16'sd0, 16'sd1};
    end

     fsm for receiving
    always_ff @(posedge aclk) begin
        if (!aresetn) begin
            recv_state = R_IDLE;
            recv_buf = 1'b0;
            recv_cnt = 2'd0;
            buf_full = 2'b00;
            buf_data[0][0] = '0;
            buf_data[0][1] = '0;
            buf_data[0][2] = '0;
            buf_data[1][0] = '0;
            buf_data[1][1] = '0;
            buf_data[1][2] = '0;
            buf_user[0] = '0;
            buf_user[1] = '0;
        end else begin
          	 send clears full when buffer done
          	if (send_state == S_SEND && m_axis_tvalid && m_axis_tready && send_cnt == 4'd15) begin
                buf_full[send_buf] = 1'b0;
            end
            case (recv_state)
                R_IDLE begin
                    recv_cnt = 2'd0;
                     accept if the target buffer's free
                    if (s_axis_tvalid && !buf_full[recv_buf]) begin
                        buf_data[recv_buf][0] = s_axis_tdata;
                        buf_user[recv_buf] = s_axis_tuser;
                        recv_cnt = 2'd1;
                        recv_state = R_RECV;
                    end
                end
                R_RECV begin
                    if (s_axis_tvalid && s_axis_tready) begin
                        buf_data[recv_buf][recv_cnt] = s_axis_tdata;
                        buf_user[recv_buf] = s_axis_tuser;
                        if (recv_cnt == 2'd2) begin
                          	 all 3 beats received so full
                            buf_full[recv_buf] = 1'b1;
                            recv_buf = ~recv_buf;
                            recv_cnt = 2'd0;
                            recv_state = R_IDLE;
                        end else begin
                            recv_cnt = recv_cnt + 2'd1;
                        end
                    end
                end
                default recv_state = R_IDLE;
            endcase
        end
    end

  	 fsm for sending
    always_ff @(posedge aclk) begin
        if (!aresetn) begin
            send_state = S_IDLE;
            send_buf = 1'b0;
            send_cnt = 4'd0;
        end else begin
            case (send_state)
                S_IDLE begin
                    send_cnt = 4'd0;
                    if (buf_full[send_buf])
                        send_state = S_SEND;
                end
                S_SEND begin
                    if (m_axis_tvalid && m_axis_tready) begin
                        if (send_cnt == 4'd15) begin
                            send_buf = ~send_buf;
                            send_cnt = 4'd0;
                            send_state = S_IDLE;
                        end else begin
                            send_cnt = send_cnt + 4'd1;
                        end
                    end
                end
                default send_state = S_IDLE;
            endcase
        end
    end

    assign s_axis_tready = (recv_state == R_IDLE && !buf_full[recv_buf]) (recv_state == R_RECV);
    assign m_axis_tvalid = (send_state == S_SEND);
    assign m_axis_tdata = output_rom[send_cnt];
    assign m_axis_tuser = buf_user[send_buf];
    assign m_axis_tlast = (send_state == S_SEND) && (send_cnt == 4'd15);
endmodule