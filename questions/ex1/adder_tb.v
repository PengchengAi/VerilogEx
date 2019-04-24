`timescale 1ns/1ps

module adder_tb;
  reg A, B, Cin;
  wire S, Cout;
  
  integer pass, final_res;
  
  function test_print;
    input S, Cout, S_e, Cout_e;
    reg pass;
    begin
      if(S == S_e && Cout == Cout_e)
       pass = 1;
      else
       pass = 0;
      if(pass)
        $display("S expected %d, got %d; Cout expected %d, got %d. Test passed.", S_e, S, Cout_e, Cout);
      else
        $display("S expected %d, got %d; Cout expected %d, got %d. Test failed.", S_e, S, Cout_e, Cout);
      test_print = pass;
    end
  endfunction
  
  // instantiate
  adder uut(A, B, Cin, S, Cout);

  // test
  initial
  begin
    pass = 1;
    final_res = 1;
    
    A = 1'b0; B = 1'b0; Cin = 1'b0;
    #10 pass = test_print(S, Cout, 1'b0, 1'b0);
    if(pass == 0) begin final_res = 0; $stop; end
    
    A = 1'b1; B = 1'b0; Cin = 1'b0;
    #10 pass = test_print(S, Cout, 1'b1, 1'b0);
    if(pass == 0) begin final_res = 0; $stop; end
    
    A = 1'b0; B = 1'b1; Cin = 1'b0;
    #10 pass = test_print(S, Cout, 1'b1, 1'b0);
    if(pass == 0) begin final_res = 0; $stop; end
    
    A = 1'b1; B = 1'b1; Cin = 1'b0;
    #10 pass = test_print(S, Cout, 1'b0, 1'b1);
    if(pass == 0) begin final_res = 0; $stop; end
    
    A = 1'b0; B = 1'b0; Cin = 1'b1;
    #10 pass = test_print(S, Cout, 1'b1, 1'b0);
    if(pass == 0) begin final_res = 0; $stop; end
    
    A = 1'b1; B = 1'b0; Cin = 1'b1;
    #10 pass = test_print(S, Cout, 1'b0, 1'b1);
    if(pass == 0) begin final_res = 0; $stop; end
    
    A = 1'b0; B = 1'b1; Cin = 1'b1;
    #10 pass = test_print(S, Cout, 1'b0, 1'b1);
    if(pass == 0) begin final_res = 0; $stop; end
    
    A = 1'b1; B = 1'b1; Cin = 1'b1;
    #10 pass = test_print(S, Cout, 1'b1, 1'b1);
    if(pass == 0) begin final_res = 0; $stop; end
    
    if(final_res == 1)
      $display("All tests passed.");
    else
      $display("Some tests failed. Please check your design.");
    $stop;
  
  end

endmodule