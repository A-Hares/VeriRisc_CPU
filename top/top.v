`default_nettype none
`timescale 1ns/1ps
`include "module3.v"
`include "module4.v"
`include "module5.v"
`include "module6.v"
`include "module7.v"
`include "module8.v"
`include "module9.v"

module TOP(
    input wire clk, rst,
    output wire halt);

    parameter DWIDTH = 8, AWIDTH = 5;

    // Define internal wires
    wire sel, rd, ld_ir, inc_pc, ld_ac, ld_pc, wr, data_e;
    wire zero;

    wire [DWIDTH-1:0] data, ac_out, alu_out;

    wire [2:0] opcode, phase;
    wire [AWIDTH-1:0] ir_addr, pc_addr, addr;

    Mux21 #(.width(AWIDTH)) address_mux(.in0(ir_addr), .in1(pc_addr), .sel(sel),.mux_out(addr));

    Memory #(.AWIDTH(AWIDTH), .DWIDTH(DWIDTH)) memory_inst(.addr(addr), .clk(clk), .wr(wr), .rd(rd), .data(data));

    counter #(.WIDTH(3)) counter_clk(.cnt_in(3'b000), .clk(clk), .rst(rst), .load(1'b0), .enab(~halt),.cnt_out(phase));

    counter #(.WIDTH(AWIDTH)) counter_pc(.cnt_in(ir_addr), .clk(clk), .rst(rst), .load(ld_pc), .enab(inc_pc),.cnt_out(pc_addr));

    Register #(.DataWidth(DWIDTH)) register_ir(.data_in(data), .clk(clk), .rst(rst), .load(ld_ir), .data_out({opcode, ir_addr}));

    Register #(.DataWidth(DWIDTH)) register_ac(.data_in(alu_out), .clk(clk), .rst(rst), .load(ld_ac), .data_out(ac_out));

    Driver #(.width(DWIDTH)) driver_inst(.data_in(alu_out), .data_en(data_e), .data_out(data));

    ALU #(.WIDTH(DWIDTH)) alu_inst(.in_a(ac_out), .in_b(data), .opcode(opcode), .alu_out(alu_out), .a_is_zero(zero));

    controller controller_inst(.opcode(opcode), .phase(phase), .zero(zero),
                                .sel(sel), .rd(rd), .ld_ir(ld_ir), .halt(halt), .inc_pc(inc_pc),
                                .ld_pc(ld_pc), .wr(wr), .data_e(data_e), .ld_ac(ld_ac));

endmodule