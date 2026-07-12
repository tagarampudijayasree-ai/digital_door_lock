`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.07.2026 18:39:03
// Design Name: 
// Module Name: digital_door_lock_tb
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


module digital_door_lock_tb();
    reg clk,rst,load,open;
    reg [3:0] password_in;
    wire unlock;
    wire wrong_password;
    wire alarm;
    wire lock_system;
    digital_door_lock uut(.clk(clk),.rst(rst),.load(load),.open(open),.password_in(password_in),.unlock(unlock),.wrong_password(wrong_password),.alarm(alarm),.lock_system(lock_system));
    initial begin
    clk=0;
    forever #5 clk=~clk;
    end
    initial begin
    rst=1; load=0; open=0; password_in=4'b0000;
    #20; rst=0;
    #10; load=1;
    password_in= 4'b1010;
    #10; open=0;
    // wrong password attempts 
    #20; open=1;
    password_in = 4'b1111;
    #10; open=0;
        #20; open=1;
    password_in = 4'b1100;
    #10; open=0;    #20; open=1;
    password_in = 4'b0011;
    #10; open=0;
    //correct password after unlock
        #20; open=1;
    password_in = 4'b1010;
    #10; open=0;
    #50;
    $finish;
    end
endmodule
