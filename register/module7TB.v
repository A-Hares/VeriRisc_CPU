`include "module7.v"
module register_test;

  localparam WIDTH=8;

  reg  clk  ;
  reg  rst  ;
  reg  load ;
  reg  [WIDTH-1:0] data_in;
  wire [WIDTH-1:0] data_out;

  Register
  #(
    .DataWidth ( WIDTH )
   )
  register_inst
   ( 
    .clk      ( clk      ),
    .rst      ( rst      ),
    .load     ( load     ),
    .data_in  ( data_in  ),
    .data_out ( data_out ) 
   );

  task expect;
    input [WIDTH-1:0] exp_out;
    if (data_out !== exp_out) begin
      $display("TEST FAILED");
      $display("At time %0d rst=%b load=%b data_in=%b data_out=%b",
                $time, rst, load, data_in, data_out);
      $display("data_out should be %b", exp_out);
      $finish;
    end
   else begin
      $display("At time %0d rst=%b load=%b data_in=%b data_out=%b",
                $time, rst, load, data_in, data_out);
   end
  endtask

  initial repeat (5) begin #5 clk=1; #5 clk=0; end

  initial @(negedge clk) begin
    rst=0; load=1; data_in=8'h55; @(negedge clk) expect (8'h55);
    rst=0; load=1; data_in=8'hAA; @(negedge clk) expect (8'hAA);
    rst=0; load=1; data_in=8'hFF; @(negedge clk) expect (8'hFF);
    rst=1; load=1; data_in=8'hFF; @(negedge clk) expect (8'h00);
    $display("TEST PASSED");
    $finish;
  end

endmodule
