`default_nettype none
`timescale 1ns/1ps
module Memory #(parameter AWIDTH = 5, parameter DWIDTH = 8) (
    input wire [AWIDTH-1:0] addr,
    input wire clk, wr, rd, 
    inout wire [DWIDTH-1:0] data
);
    parameter D_num = 2**AWIDTH;
    reg [DWIDTH-1:0] D_mem [0:D_num-1] ;

    always @(posedge clk) begin
        if(wr) 
            D_mem[addr] = data;
    end
    assign data = rd ? D_mem[addr] : 'bz;

endmodule