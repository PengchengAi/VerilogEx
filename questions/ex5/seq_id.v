module seq_id(clk, rst_n, X, S);
  input clk, rst_n;
  input X;
  output S;

  parameter init = 6'b000001,
            A    = 6'b000010,
            B    = 6'b000100,
            C    = 6'b001000,
            D    = 6'b010000,
            E    = 6'b100000;
            
  reg [5:0] current_state, next_state;
  
  // first segment
  always @(posedge clk or negedge rst_n)
  begin
    if(!rst_n)
      current_state <= 0;
    else
      current_state <= next_state;
  end
  
  // second segment
  always @(rst_n, current_state, X)
  begin
    if(!rst_n)
      next_state <= init;
    else
      case(current_state)
        init: if(X) next_state <= A; else next_state <= init;
        // -------- insert your code here ------------

        
        
        
        
        // -------------------------------------------
        default: next_state <= init;
      endcase
  end
  
  // third segment
  // -------- insert your code here ------------

  // -------------------------------------------


endmodule
