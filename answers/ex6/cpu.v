module cpu(clk, rst_n, we_n, wr_addr_d, wr_data_d, rd_addr_d, rd_data_d,
           rd_addr_c, rd_data_c, cnt, flag);
  parameter addr_width_d = 5;
  parameter addr_width_c = 3;
  
  // each instruction has 4 steps
  parameter FETCH = 4'b0001,
            OPER  = 4'b0010,
            WRITE = 4'b0100,
            END   = 4'b1000;
            
  // there are 4 opcodes
  parameter ADD   = 4'b0001,
            MINUS = 4'b0010,
            AND   = 4'b0100,
            OR    = 4'b1000;
  
  input clk, rst_n;
  output reg we_n;
  output reg [addr_width_d-1:0] wr_addr_d, rd_addr_d;
  output reg [3:0] wr_data_d;
  input [3:0] rd_data_d;
  output reg [addr_width_c-1:0] rd_addr_c;
  input [3:0] rd_data_c;
  input [4:0] cnt;
  output flag;
  
  reg [3:0] current_state, next_state;
  
  reg [4:0] counter;
  reg [2:0] step_counter;
  wire step_flag;
  
  // -------- Please try to complete the code ------------
  
  // I want to get the Nth instruction, so I need a counter.
  always @(posedge clk or negedge rst_n)
  begin
    if(!rst_n)
    begin
      counter <= 5'b0;
    end
    else
    begin
      if(current_state == END && counter != cnt)
        counter <= counter + 1'b1;
      else
        counter <= counter;
    end
  end
  
  // Flag indicates the end of execution. (How to set the flag?)
  // -------- insert your code here ------------
  assign flag = (rst_n && counter == cnt);
  // -------------------------------------------
  
  // For each step of each instruction, I want to run fixed steps, so I use a counter.
  always @(posedge clk or negedge rst_n)
  begin
    if(!rst_n)
      step_counter <= 3'b0;
    else
    begin
      if(current_state == END)
        step_counter <= 3'b0;
      else
        step_counter <= step_counter + 1'b1;
    end
  end
  
  assign step_flag = (step_counter == 3'b111);
  
  // I want to use a state machine to divide the instruction into 4 steps.
  //------------------- state machine begins -------------------------//
  always @(posedge clk or negedge rst_n)
  begin
    if(!rst_n)
      current_state <= FETCH;
    else
      current_state <= next_state;
  end
  
  always @(*)
  begin
    if(!rst_n)
      next_state <= FETCH;
    else
    begin
      case(current_state)
      // -------- insert your code here ------------
        FETCH: if(step_flag) next_state <= OPER; else next_state <= FETCH;
        OPER: if(step_flag) next_state <= WRITE; else next_state <= OPER;
        WRITE: if(step_flag) next_state <= END; else next_state <= WRITE;
        END: next_state <= FETCH;
        default: next_state <= FETCH;
      // -------------------------------------------
      endcase
    end
  end
  
  reg [3:0] oper1, oper2, result;
  reg [3:0] opcode;
  
  // I want to fetch the operands.
  always @(posedge clk or negedge rst_n)
  begin
    if(!rst_n)
    begin
      oper1 <= 4'b0;
      oper2 <= 4'b0;
      rd_addr_d <= {addr_width_d{1'b0}};
    end
    else
    begin
      if(current_state == FETCH)
      begin
      // -------- insert your code here ------------
      // hint: You can use step_counter to assist your operation.
        if(step_counter == 3'b0)
          rd_addr_d <= 3 * counter;
        else if(step_counter == 3'b001)
          oper1 <= rd_data_d;
        else if(step_counter == 3'b010)
          rd_addr_d <= 3 * counter + 1;
        else if(step_counter == 3'b011)
          oper2 <= rd_data_d;
      // --------------------------------------------
      end
      else
      begin
        oper1 <= oper1;
        oper2 <= oper1;
        rd_addr_d <= {addr_width_d{1'b0}};
      end
    end
  end
  
  // I want to fetch the opcode.
  always @(posedge clk or negedge rst_n)
  begin
    if(!rst_n)
    begin
      opcode <= 4'b0;
      rd_addr_c <= {addr_width_c{1'b0}};
    end
    else
    begin
      if(current_state == FETCH)
      begin
      // -------- insert your code here ------------
      // hint: You can use step_counter to assist your operation.
        if(step_counter == 3'b0)
          rd_addr_c <= counter;
        else if(step_counter == 3'b001)
          opcode <= rd_data_c;
      // --------------------------------------------
      end
      else
      begin
        opcode <= opcode;
        rd_addr_c <= {addr_width_c{1'b0}};
      end
    end
  end
  
  // I want to execute the opcode
  always @(posedge clk or negedge rst_n)
  begin
    if(!rst_n)
    begin
      result <= 4'b0;
    end
    else
    begin
    // -------- insert your code here ------------
      if(current_state == OPER && step_counter == 3'b0)
        case(opcode)
          ADD: result <= oper1 + oper2;
          MINUS: result <= oper1 - oper2;
          AND: result <= oper1 & oper2;
          OR: result <= oper1 | oper2;
          default: result <= 4'b0000;
        endcase
      else
        result <= result;
    // --------------------------------------------
    end
  end
  
  // I want to write the result back to RAM
  always @(posedge clk or negedge rst_n)
  begin
    if(!rst_n)
    begin
      wr_data_d <= 4'b0000;
      wr_addr_d <= {addr_width_d{1'b0}};
      we_n <= 1'b1;
    end
    else
    begin
    // -------- insert your code here ------------
      if(current_state == WRITE && step_counter == 3'b0)
      begin
        wr_data_d <= result;
        wr_addr_d <= 3 * counter + 2;
        we_n <= 1'b0;
      end
      else
        we_n <= 1'b1;
    // -------------------------------------------
    end
  end
  //------------------- state machine ends ---------------------------//
  
endmodule