module cpu_top(clk, rst_n_cpu, rst_n_mem, cnt, flag, rd_addr, rd_data);
  input clk, rst_n_cpu, rst_n_mem;
  input [4:0] cnt;
  output flag;
  input [4:0] rd_addr;
  output [3:0] rd_data;
  
  wire we_n;
  wire [4:0] wr_addr_d, rd_addr_d;
  wire [2:0] rd_addr_c;
  wire [3:0] wr_data_d, rd_data_d, rd_data_c;
  
  ram #(.addr_width(5), .depth(32), .filename("answers/ex6/databin.txt")) 
  data_ram
  (.clk(clk), 
   .rst_n(rst_n_mem), 
   .we_n(we_n), 
   .wr_addr(wr_addr_d), 
   .wr_data(wr_data_d), 
   .rd_addr_0(rd_addr_d), 
   .rd_data_0(rd_data_d), 
   .rd_addr_1(rd_addr), 
   .rd_data_1(rd_data));
  
  ram #(.addr_width(3), .depth(8), .filename("answers/ex6/progbin.txt")) 
  prog_ram
  (.clk(clk),
   .rst_n(rst_n_mem), 
   .we_n(1'b1),
   .wr_addr(3'b0), 
   .wr_data(4'b0), 
   .rd_addr_0(rd_addr_c), 
   .rd_data_0(rd_data_c), 
   .rd_addr_1(3'b0), 
   .rd_data_1());

  cpu #(.addr_width_d(5), .addr_width_c(3))
  core
  (.clk(clk), 
  .rst_n(rst_n_cpu), 
  .we_n(we_n), 
  .wr_addr_d(wr_addr_d), 
  .wr_data_d(wr_data_d), 
  .rd_addr_d(rd_addr_d), 
  .rd_data_d(rd_data_d),
  .rd_addr_c(rd_addr_c), 
  .rd_data_c(rd_data_c), 
  .cnt(cnt), 
  .flag(flag));

endmodule