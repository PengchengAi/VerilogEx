`timescale 1ns/1ns

module clk_div_tb;
  reg clk_in;
  reg rst_n;
  wire clk_out_1, clk_out_2;
  
  // instantiate
  clk_div uut(.rst_n(rst_n), .clk_in(clk_in), .clk_out_1(clk_out_1), .clk_out_2(clk_out_2));

  integer i;
  integer pass;
  integer div2, div4;
  
  always
  begin
    #10 clk_in = ~clk_in;
  end
  
  // test
  initial
  begin
    pass = 1;
    clk_in = 0;
    
    for(i = 0; i < 10; i = i + 1)
    begin
      div2 = 0;
      div4 = 0;
      rst_n = 1'b0;
      #100 rst_n = 1'b1;
      #(100+i*5)
      @(posedge clk_out_1)
        div2 = $time;
      @(posedge clk_out_1)
        div2 = $time - div2;
      @(posedge clk_out_2)
        div4 = $time;
      @(posedge clk_out_2)
        div4 = $time - div4;
      $display("input period 20, expected 40, 80, got %d, %d", div2, div4);
      if(div2 != 40 && div4 != 80)
      begin
        $display("test failed.");
        pass = 0;
        $stop;
      end
    end
    
    if(pass == 1)
      $display("All tests passed.");
    else
      $display("Some tests failed. Please check your design.");
    $stop;
  
  end
  
  initial
  begin
    #50000 $display("Simulation timeout.");
    $stop;
  end

endmodule