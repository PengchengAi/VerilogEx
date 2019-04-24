`timescale 1ns/1ps

module adderN_tb;
  reg [4:0] A, B;
  reg [1:0] Cin;
  wire [3:0] S;
  wire Cout;
  
  function test_print;
    input [3:0] S;
    input Cout;
    input [3:0] S_e;
    input Cout_e;
    reg pass;
    begin
      if(S == S_e && Cout == Cout_e)
       pass = 1;
      else
       pass = 0;
      if(pass)
        $display("S expected %b, got %b; Cout expected %b, got %b. Test passed.", S_e, S, Cout_e, Cout);
      else
        $display("S expected %b, got %b; Cout expected %b, got %b. Test failed.", S_e, S, Cout_e, Cout);
      test_print = pass;
    end
  endfunction
  
  // instantiate
  adderN uut(A[3:0], B[3:0], Cin[0], S, Cout);
    
  wire [3:0] S_e;
  wire Cout_e;
  integer pass, final_res;
  
  assign {Cout_e, S_e} = A + B + Cin;
  
  // test
  initial
  begin
    pass = 1;
    final_res = 1;

    for(A = 5'b0; A < 5'b10000; A = A + 1'b1)
      for(B = 5'b0; B < 5'b10000; B = B + 1'b1)
        for(Cin = 2'b0; Cin < 2'b10; Cin = Cin + 1'b1)
        begin
          #10 pass = test_print(S, Cout, S_e, Cout_e);
          if(pass == 0) begin final_res = 0; $stop; end
        end
    
    if(final_res == 1)
      $display("All tests passed.");
    else
      $display("Some tests failed. Please check your design.");
    $stop;

  end
  
endmodule