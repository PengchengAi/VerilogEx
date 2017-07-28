`timescale 1ns/1ns

module ram(clk, rst_n, we_n, wr_addr, wr_data, rd_addr_0, rd_data_0, rd_addr_1, rd_data_1);
  parameter width = 4;
  parameter addr_width = 5;
  parameter depth = 32;
  parameter filename = "default.txt";

  input clk, rst_n, we_n;
  input [addr_width-1:0] wr_addr, rd_addr_0, rd_addr_1;
  input [width-1:0] wr_data;
  output [width-1:0] rd_data_0, rd_data_1;
  
  // define memory
  reg [width-1:0] mem[depth-1:0];
  
  // attention: ensure i to satisfy ending condition
  reg [addr_width:0] i;
  
  assign rd_data_0 = ((we_n == 1'b0) && (wr_addr == rd_addr_0)) ? wr_data : mem[rd_addr_0];
  
  assign rd_data_1 = ((we_n == 1'b0) && (wr_addr == rd_addr_1)) ? wr_data : mem[rd_addr_1];

  always @( posedge clk or negedge rst_n )
  begin
    if (!rst_n)
    begin
      for( i = 0 ; i < depth ; i = i + 1 )
        mem[i] <= {width{1'b0}};
    end
    else
    begin
      if(!we_n)
        mem[wr_addr] <= wr_data;
    end
  end

  // used for simulation
  initial
  begin
    #1000 $readmemb(filename, mem);
  end

endmodule