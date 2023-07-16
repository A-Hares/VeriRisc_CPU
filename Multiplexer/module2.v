module Mux21(
    input [width-1:0] in0, in1,
    input sel,
    output [width-1:0] mux_out
);
    parameter width = 5;
    assign mux_out = sel ? in1 : in0;
endmodule

module muxTB;
    parameter widthnew = 3;
    reg [widthnew-1:0] in0, in1;
    reg sel;
    wire [widthnew-1:0] mux_out;

    Mux21 #(widthnew) inst1(.in0(in0), .in1(in1), .sel(sel), .mux_out(mux_out));

    initial begin
        $dumpfile("m3.vcd");
        $dumpvars;
        in0 = 0; in1 = 0; sel = 0;
        #10;
        in0 = 3'b001; in1 = 0; sel = 0;
        #10;
        in0 = 3'b001; in1 = 0; sel = 1;
        #10;
        $finish;
    end

endmodule
