`default_nettype none
`timescale 1ns/1ps
module Driver #(parameter width = 8) (
    input wire [width-1:0] data_in,
    input wire data_en,
    output tri [width-1:0] data_out
);
    assign data_out = data_en ? data_in : 'bz;

endmodule
