# TheWA
Computer Architecture Project 

How to run what is currently in github

Compile:
iverilog -o alu_4bit.out alu_4bit.v alu_4bit_tb.v

Run:
vvp alu_4bit.out

Open waveform
gtkwave alu_4bit.vcd


