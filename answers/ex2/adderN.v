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
  adder a2(.A(A[1]), .B(B[1]), .Cin(Cout_1), .S(S[1]), .Cout(Cout_2));
  adder a3(.A(A[2]), .B(B[2]), .Cin(Cout_2), .S(S[2]), .Cout(Cout_3));
  adder a4(.A(A[3]), .B(B[3]), .Cin(Cout_3), .S(S[3]), .Cout(Cout_4));
  // -------------------------------------------
  
  // output
  assign Cout = Cout_4;

endmodule