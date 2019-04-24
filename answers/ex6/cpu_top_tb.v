`timescale 1ns/1ns

module cpu_top_tb;
  reg clk, rst_n_cpu, rst_n_mem;
  reg [4:0] cnt;
  wire flag;
  reg [4:0] rd_addr;
  wire [3:0] rd_data;
  
  // instantiate
  cpu_top uut(.clk(clk), .rst_n_cpu(rst_n_cpu), .rst_n_mem(rst_n_mem), .cnt(cnt), .flag(flag), 
              .rd_addr(rd_addr), .rd_data(rd_data));
  
  integer pass;
  integer i;
  integer stopwatch;
  reg [3:0] mem_res[31:0];
  reg [3:0] mem_chk[31:0];
  
  always
  begin
    #10 clk = ~clk;
  end
  
  // test
  initial
  begin
    pass = 1;
    clk = 0;
    rst_n_cpu = 0;
    rst_n_mem = 0;
    rd_addr = 5'b0;
    cnt = 8;
    $readmemb("answers/ex6/databin_result.txt", mem_chk);
    
    #200
    rst_n_mem = 1;

    
    #1000
    rst_n_cpu = 1;
    stopwatch = $time;
    
    @(posedge flag)
    stopwatch = $time - stopwatch;
    
    $display("After %d ns, operation finished.", stopwatch);
    
    for(i=0; i<24; i=i+1)
    begin
      rd_addr = i;
      #20 mem_res[i] = rd_data;
    end
    
    for(i=0; i<24; i=i+1)
    begin
      if(mem_res[i] == mem_chk[i])
      begin
        $display("At address %4b, expected %b, got %b, test passed.", i, mem_chk[i], mem_res[i]);
      end
      else
      begin
        $display("At address %4b, expected %b, got %b, test failed.", i, mem_chk[i], mem_res[i]);
        pass = 0;
        $stop;
      end
    end
    
    if(pass == 1)
      $display("All tests passed.");
    else
      $display("Some tests failed. Please check your design.");
    $stop;
    
  end
  
  initial
  begin
    #1000000 $display("Simulation timeout.");
    $stop;
  end


endmodule
