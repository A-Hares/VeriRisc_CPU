`default_nettype none
`timescale 1ns/1ps

module controller(
    input wire [2:0] opcode, phase,
    input wire zero,
    output wire sel, rd, ld_ir, halt, inc_pc, ld_ac, ld_pc, wr, data_e
);
    reg [8:0] controlsig;
    assign {sel, rd, ld_ir, halt, inc_pc, ld_ac, ld_pc, wr, data_e} = controlsig;
    reg HALT, ALUOP, JMP, STO, SKZnZero;

    always @(*) begin
        HALT = 0;
        ALUOP = 0;
        STO = 0;
        JMP = 0;
        SKZnZero = 0;
        case(opcode)
            3'b000: begin HALT = 1; end
            3'b001: if (zero) SKZnZero = 1;
            3'b010,3'b011,3'b100,3'b101 : begin ALUOP = 1; end
            3'b110: STO = 1;
            3'b111: JMP = 1;
        endcase
    end
    always @(*) begin
        case(phase)
            3'b000 : controlsig = 9'b1000_0000_0;   // INST_addr
            3'b001 : controlsig = 9'b1100_0000_0;   // INST_fetch
            3'b010 : controlsig = 9'b1110_0000_0;   // INST_LOAD
            3'b011 : controlsig = 9'b1110_0000_0;   // IDLE
            3'b100 : controlsig = {3'b000, HALT, 5'b10000};   // OP_ADDR
            3'b101 : controlsig = {1'b0, ALUOP, 7'b0000_000};   // OP_FETCH
            3'b110 : controlsig = {1'b0, ALUOP, 2'b00, SKZnZero, 1'b0, JMP, 1'b0, STO};   // ALU_OP
            3'b111 : controlsig = {1'b0, ALUOP, 3'b000, ALUOP, JMP, STO, STO};   // STORE          
        endcase
    end

endmodule