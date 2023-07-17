`default_nettype none
`timescale 1ns/1ps

module Register #(parameter DataWidth = 8) (
    input wire [DataWidth-1:0] data_in,
    input wire load,
    input wire clk,
    input wire rst,
    output reg [DataWidth-1:0] data_out
);
    
    always @(posedge clk) begin
        if (rst)
            data_out <= 0;
        else
            if (load)
                data_out <= data_in;
    end
endmodule