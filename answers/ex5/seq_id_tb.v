module seq_id_tb;
  reg clk, rst_n;
  reg X;
  wire S;
  
  function test_print;
    input S, S_e;
    reg pass;
    begin
      if(S == S_e)
       pass = 1;
      else
       pass = 0;
      if(pass)
        $display("S expected %d, got %d. Test passed.", S_e, S);
      else
        $display("S expected %d, got %d. Test failed.", S_e, S);
      test_print = pass;
    end
   
  endfunction

  // instantiate
  seq_id uut(.clk(clk), .rst_n(rst_n), .X(X), .S(S));
  
  always
  begin
    #10 clk = ~clk;
  end
  
  reg [0:31] seque;
  reg [0:4] group;
  reg S_e;
  integer i;
  integer pass, final_res;
  
  //test
  initial
  begin
    pass = 1;
    final_res = 1;
    rst_n = 0;
    clk = 0;
    X = 0;
    group = 5'b00000;
    seque = 32'b01010110101001011011001011101101;
    
    #100 rst_n = 1;
    
    for(i=0; i<32; i=i+1)
    begin
      X = seque[0];
      group = {group[1:4], X}; 
    
      #20 
      if(group == 5'b10110)
        S_e = 1'b1;
      else
        S_e = 1'b0;
      pass = test_print(S, S_e);
      if(pass == 0) begin final_res = 0; $stop; end
      
      seque = seque << 1;   
    end
    
    if(final_res == 1)
      $display("All tests passed.");
    else
      $display("Some tests failed. Please check your design.");
    $stop;
  
  end




endmodule