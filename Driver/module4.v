`default_nettype none
`timescale 1ns/1ps
module Driver #(parameter width = 8) (
    input wire [width-1:0] data_in,
    input wire data_en,
    output tri [width-1:0] data_out
);
    assign data_out = data_en ? data_in : 'bz;

endmodule

module DriverTB;
    localparam width = 8;
    reg [width-1:0] data_in;
    reg data_en;
    wire [width-1:0] data_out;

    Driver #(.width(width)) inst1(.data_in(data_in) , .data_en(data_en), .data_out(data_out));

    initial begin
        data_in = 123; data_en = 0; #10; 
        data_in = 123; data_en = 1; #10;
        data_in = 321; data_en = 0; #10;
        data_in = 132; data_en = 1; #10;
    end

endmodule
