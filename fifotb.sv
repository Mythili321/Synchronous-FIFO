`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/07/2025 03:01:11 PM
// Design Name: 
// Module Name: fifotb
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


module fifotb;
parameter width=8;
parameter depth=16;
reg clk,reset,write_en,read_en;
reg [7:0] datain;
wire [7:0] dataout;
wire full,empty;
wire [4:0] countout;
int i;

FIFO #(.width(width), .depth(depth)) dut(.clk(clk), .reset(reset), .write_en(write_en), .read_en(read_en), .datain(datain), .dataout(dataout), .full(full), .empty(empty), .countout(countout));

initial begin
clk=0;
forever #5 clk=~clk;
end
initial begin
reset=0; write_en=0; read_en=0;
#10 reset=1;
write_operation();
read_operation();
full_condition();
empty_condition();
single_element();
multiple_writes();
multiple_read();
simultaneous_operation();
wrap_around();
reset_operation();
underflow();
overflow();
#500;
$finish;
end

task write_operation();
begin
datain=8'd32;
write_en=1; #10 write_en=0;
if (empty) 
$display("Error:fifo shouldnot be empty");
end
endtask

task read_operation();
begin
read_en=1;
#10 read_en=0;
if (dataout!==8'd32) 
$display("Error:data mismatch");
end
endtask

task full_condition();
begin
repeat(depth) begin
datain=$random;
write_en=1;
#10 write_en=0;
end
end
endtask

task empty_condition();
while(!empty)
begin
read_en=1;
#10 read_en=0;
end
endtask

task single_element();
begin
datain=8'd22;
write_en=1;
#10 write_en=0;
read_en=1;
#10 read_en=0;
end
endtask

task multiple_writes();
begin
for (i=0;i<depth;i++)
begin
datain=i; 
write_en=1;
#10 write_en=0;
end
end
endtask

task multiple_read();
begin
for (i=0;i<depth;i++)
begin
read_en=1;
#10 read_en=0;
if (dataout!==i)
$display("Error:data mismatch");
end
end
endtask

task wrap_around();
begin
for (i=0;i<depth;i++)
begin
write_en=1;
#10 write_en=0;
end 
for(i=0;i<2;i++)
begin 
read_en=1;
#10 read_en=0;
end 
datain=8'd21;
write_en=1;
#10 write_en=0;
read_en=1;
#10 read_en=0;
if (dataout!==8'd21)
$display("Error:data mismatch");
end
endtask 

task simultaneous_operation();
begin
datain=8'd31;
write_en=1;
read_en=1;
#10 write_en=0;
#10 read_en=0;
end
endtask 

task reset_operation();
begin
datain=8'd44;
write_en=1;
#10 write_en=0;
reset=0;
#10 reset=1;
if(!empty)
$display("error:Fifo not empty after reset");
end
endtask  

task overflow();
begin
for(i=0;i<depth+2;i++)
begin
datain=$random;
write_en=1;
#10 write_en=0;
end 
if (countout>depth)
$display("overflow occurred");
end  
endtask

task underflow();
begin 
read_en=1;
#10 read_en=0;
if(dataout!=={width{1'bx}})
$display("invalid");
end
endtask

endmodule
