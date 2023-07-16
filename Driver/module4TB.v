
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

module driver_test;

  localparam WIDTH=8;

  reg              data_en  ;
  reg  [WIDTH-1:0] data_in  ;
  wire [WIDTH-1:0] data_out ;

  Driver
  #(
    .width ( WIDTH )
   )
  driver_inst
   (
    .data_en  ( data_en  ),
    .data_in  ( data_in  ),
    .data_out ( data_out ) 
   );

  task expect;
    input [WIDTH-1:0] exp_out;
    if (data_out !== exp_out) begin
      $display("TEST FAILED");
      $display("At time %0d data_en=%b data_in=%b data_out=%b",
               $time, data_en, data_in, data_out);
      $display("data_out should be %b", exp_out);
      $finish;
    end
    else begin
      $display("At time %0d data_en=%b data_in=%b data_out=%b",
               $time, data_en, data_in, data_out);
    end
  endtask

  initial begin
    data_en=1'b0; data_in=8'hXX; #1 expect (8'hZZ);
    data_en=1'b1; data_in=8'h55; #1 expect (8'h55);
    data_en=1'b1; data_in=8'hAA; #1 expect (8'hAA);
    $display("TEST PASSED");
    $finish;
  end

endmodule
