`default_nettype none
`timescale 1ns/1ps

module ALU #(
    parameter WIDTH = 8
) (
    input wire [WIDTH-1:0] in_a, in_b,
    input wire [2:0] opcode,
    output reg [WIDTH-1:0] alu_out,
    output wire a_is_zero
);
    always @(*) begin
        case (opcode)
            3'b000: alu_out = in_a;
            3'b001: alu_out = in_a;
            3'b010: alu_out = in_a + in_b;
            3'b011: alu_out = in_a & in_b;
            3'b100: alu_out = in_a ^ in_b;
            3'b101: alu_out = in_b;
            3'b110: alu_out = in_a;
            3'b111: alu_out = in_a;
            default: begin
                alu_out = 'bx;
            end
        endcase
    end
    assign a_is_zero = ~(|in_a);

    
endmodule
