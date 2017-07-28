module shift_reg(clk, rst_n, preset_n, D, Sin, Q, Sout);
  input clk, rst_n, preset_n;
  input [3:0] D;
  input Sin;
  output reg [3:0] Q;
  output reg Sout;
  
  always @(posedge clk or negedge rst_n)
  begin
  // -------- insert your code here ------------
    if(!rst_n)
    begin
      Q <= 4'b0;
      Sout <= 1'b0;
    end
    else
    begin
      if(!preset_n)
      begin
        Q <= D;
        Sout <= Sout;
      end
      else
        {Sout, Q} <= {Q, Sin};
    end
  // -------------------------------------------
  end


endmodule