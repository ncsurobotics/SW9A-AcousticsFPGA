module SIPO #( //Serial in Parallel out shift register
	parameter INPUT_WIDTH = 1,
	parameter OUTPUT_WIDTH = 10
	)(
    input clk,
    input [INPUT_WIDTH  - 1 : 0] data_in, //serial in
    input reset_b, //async active low
    input data_logging, //enable
    output wire[OUTPUT_WIDTH - 1:0] data_out   //parallel out
);

    reg [OUTPUT_WIDTH - 1:0]  data_buffer;

    always@(posedge clk or negedge reset_b)
    begin
        if(!reset_b) data_buffer = 0;
        
        else
            if(data_logging) 
            begin
                data_buffer = data_buffer << 1;
                data_buffer[0] = data_in;
            end        
            else data_buffer = data_buffer; 
    end

    assign data_out = data_buffer;

endmodule

