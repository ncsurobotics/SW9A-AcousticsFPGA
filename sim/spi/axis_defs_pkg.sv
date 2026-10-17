`timescale 1ns/1ps

package axis_defs_pkg;
  localparam MAX_DATA_W = 128;
  localparam MAX_USER_W = 8;
  // localparam MAX_ID_W = 4;

  typedef bit [AXIS_MAX_DATA_W-1:0] axis_data_t;
  typedef bit [AXIS_MAX_USER_W-1:0] axis_user_t;
endpackage
