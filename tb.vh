module tb;

reg [3:0] A, B, sel;
reg carry_in;
wire [3:0] Y, Y2;
wire carry_out;

alu_4bit uut (A, B, carry_in, sel, Y, Y2, carry_out);

initial begin
    $dumpfile("wave.vcd");
    $dumpvars(0, tb);

    A = 4'b1100; B = 4'b1010; carry_in = 0;

    sel = 4'b0000; #10; // AND
    sel = 4'b0010; #10; // OR
    sel = 4'b1000; #10; // ADD
    sel = 4'b1010; #10; // MUL

    $finish;
end

endmodule
