`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.07.2026 17:08:53
// Design Name
module digital_door_lock(input clk,rst,load,open,input[3:0] password_in,output reg unlock,output reg wrong_password,

output reg alarm,output reg lock_system);

reg [3:0] stored_password;
reg [1:0]wrong_count;
reg [31:0]timer;
parameter TIMER_COUNT=30;

// comparator
wire match;
assign match =(password_in == stored_password);
// password register
always@(posedge clk or posedge rst)
begin
if(rst)
stored_password <= 4'b0000;
else if(load && !lock_system)
stored_password <= password_in;
end
//controller
always@(posedge clk or posedge rst)
begin
if(rst)
begin
unlock <= 1'b0;
wrong_password <=1'b0;
alarm <= 1'b0;
lock_system <=1'b0;
wrong_count <=2'b00;
timer <= 32'd0;
end

else if(lock_system)
begin
unlock <= 1'b0;
wrong_password <= 1'b0;

if(timer < TIMER_COUNT)
timer <= timer + 1;
else
begin
timer <= 32'd0;
lock_system <= 1'b0;
alarm <= 1'b0;
wrong_count <= 2'b00;
wrong_password <= 1'b0;
end
end
else if(open)
begin
if(match)
begin
unlock <= 1'b1;
wrong_password <= 1'b0;
wrong_count <= 2'b00;
alarm <= 1'b0;
timer <= 32'd0;
end
else 
begin
unlock <=1'b0;
wrong_password <= 1'b1;
if(wrong_count==2'b10)
begin
wrong_count <= 2'b11;
alarm <= 1'b1;
lock_system <= 1'b1;
timer <=32'd0;
end
else
wrong_count <= wrong_count + 2'b01;
end
end
else begin
unlock <= 1'b0;
end
end 

endmodule
