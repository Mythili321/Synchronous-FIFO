`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/07/2025 01:10:10 PM
// Design Name: 
// Module Name: FIFO
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module FIFO #(
 parameter width=8,
 parameter depth=16
 )(
input clk,reset,
input [width-1:0] datain,
input write_en, read_en,
output reg [width-1:0] dataout,
output full,empty,output [4:0] countout);
reg [width-1:0] fifo [0:depth-1];
reg [$clog2(depth)-1:0] w_ptr,r_ptr;
reg [4:0] count;
always @ (posedge clk or negedge reset)  
begin
if (!reset)
begin 
w_ptr<=0;
r_ptr<=0;
count<=0;
dataout<=0;
end
else begin
if (write_en && !full) begin
fifo[w_ptr]<=datain;
w_ptr<=(w_ptr+1)%depth;
count<=count+1;
end
if (read_en && !empty) begin
dataout<=fifo[r_ptr];
r_ptr<=(r_ptr+1)%depth;
count<=count-1;
end
end 
end 
assign full=(count==depth);
assign empty=(count==0);
assign countout=count;
endmodule



