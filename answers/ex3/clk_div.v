module clk_div(rst_n, clk_in, clk_out_1, clk_out_2);
  input rst_n, clk_in;
  output reg clk_out_1, clk_out_2;
  
  // divided by 2
  always @(posedge clk_in or negedge rst_n)
  begin
    if(!rst_n)
      clk_out_1 <= 1'b0;
    else
      clk_out_1 <= ~clk_out_1;
  end
  
  // divided by 4
  // -------- insert your code here ------------
  reg cnt;
  always @(posedge clk_in or negedge rst_n)
  begin
    if(!rst_n)
    begin
      cnt <= 1'b0;
      clk_out_2 <= 1'b0;
    end
    else
    begin
      cnt <= ~cnt;
      if(cnt) clk_out_2 <= ~clk_out_2;
    end
  end
  // -------------------------------------------

endmodule