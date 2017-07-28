module shift_reg_tb;
  reg clk, rst_n, preset_n;
  reg [3:0] D;
  reg Sin;
  wire [3:0] Q;
  wire Sout;
  
  function test_print;
    input [3:0] Q;
    input Sout;
    input [3:0] Q_e;
    input Sout_e;
    reg pass;
    begin
      if(Q == Q_e && Sout == Sout_e)
       pass = 1;
      else
       pass = 0;
      if(pass)
        $display("S expected %b, got %b; Cout expected %b, got %b. Test passed.", Q_e, Q, Sout_e, Sout);
      else
        $display("S expected %b, got %b; Cout expected %b, got %b. Test failed.", Q_e, Q, Sout_e, Sout);
      test_print = pass;
    end
  
  endfunction
  
  // instantiate
  shift_reg uut(.clk(clk), .rst_n(rst_n), .preset_n(preset_n), 
                .D(D), .Sin(Sin), .Q(Q), .Sout(Sout));
                
  
  integer pass;
  
  always
  begin
    #10 clk = ~clk;
  end
  
  // test 
  initial
  begin
    pass = 1;
    clk = 1;
    rst_n = 0;
    preset_n = 1;
    Sin = 1'b1;
    D = 4'b1010;
    
    #5 pass = test_print(Q, Sout, 4'b0, 1'b0);
    if(pass == 0) $stop;
    
    rst_n = 1;
    preset_n = 0;
    
    #5 pass = test_print(Q, Sout, 4'b0, 1'b0);
    if(pass == 0) $stop;
    
    #20 pass = test_print(Q, Sout, 4'b1010, 1'b0);
    if(pass == 0) $stop;
    
    preset_n = 1;
    
    #20 pass = test_print(Q, Sout, 4'b0101, 1'b1);
    if(pass == 0) $stop;
    
    #20 pass = test_print(Q, Sout, 4'b1011, 1'b0);
    if(pass == 0) $stop;
    
    #20 pass = test_print(Q, Sout, 4'b0111, 1'b1);
    if(pass == 0) $stop;
    
    #20 pass = test_print(Q, Sout, 4'b1111, 1'b0);
    if(pass == 0) $stop;
    
    #20 pass = test_print(Q, Sout, 4'b1111, 1'b1);
    if(pass == 0) $stop;
    
    if(pass == 1)
      $display("All tests passed.");
    else
      $display("Some tests failed. Please check your design.");
    $stop;
  
  end
  
endmodule
  