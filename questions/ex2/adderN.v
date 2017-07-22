module adderN(A, B, Cin, S, Cout);
  input [3:0] A, B;
  input Cin;
  output [3:0] S;
  output Cout;
  
  // internal variables
  wire Cout_1, Cout_2, Cout_3, Cout_4;
  
  // instantiate a module
  adder a1(.A(A[0]), .B(B[0]), .Cin(Cin), .S(S[0]), .Cout(Cout_1));
  // -------- insert your code here ------------



  // -------------------------------------------
  
  // output
  assign Cout = Cout_4;

endmodule