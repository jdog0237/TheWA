module tb;

reg  [3:0] A, B, sel;
reg        carry_in;
wire [3:0] Y, Y2;
wire       carry_out;

alu_4bit uut (A, B, carry_in, sel, Y, Y2, carry_out);

initial begin
    $dumpfile("wave.vcd");
    $dumpvars(0, tb);

    $display("time\tA\tB\tcarry_in\tsel\tY\tY2\tcarry_out");
    $monitor("%0t\t%h\t%h\t%b\t%h\t%h\t%h\t%b",
             $time, A, B, carry_in, sel, Y, Y2, carry_out);

    // LOGIC OPERATIONS

    A = 4'b1100; B = 4'b1010; carry_in = 1'b0;

    sel = 4'b0000; #10; // AND   : C & A = 8
    sel = 4'b0001; #10; // NAND  : ~(C & A) = 7
    sel = 4'b0010; #10; // OR    : C | A = E
    sel = 4'b0011; #10; // NOR   : ~(C | A) = 1
    sel = 4'b0100; #10; // XOR   : C ^ A = 6
    sel = 4'b0101; #10; // XNOR  : ~(C ^ A) = 9
    sel = 4'b0110; #10; // NOT A : ~C = 3

    // SHIFT OPERATIONS

    A = 4'b1101; B = 4'b1001; carry_in = 1'b0;

    sel = 4'b0111; #10; // arithmetic right shift
    sel = 4'b1100; #10; // arithmetic left shift
    sel = 4'b1101; #10; // arithmetic right shift

    // ARITHMETIC OPERATIONS

    // ADD without carry_in
    A = 4'b0101; B = 4'b0011; carry_in = 1'b0;
    sel = 4'b1000; #10; // 5 + 3 = 8

    // ADD with carry_in
    A = 4'b1110; B = 4'b0011; carry_in = 1'b1;
    sel = 4'b1000; #10; // 14 + 3 + 1 = 18 -> Y=2, carry_out=1

    // SUB without carry_in
    A = 4'b1001; B = 4'b0011; carry_in = 1'b0;
    sel = 4'b1001; #10; // 9 - 3 = 6

    // SUB with carry_in
    A = 4'b1001; B = 4'b0011; carry_in = 1'b1;
    sel = 4'b1001; #10; // 9 - 3 - 1 = 5

    // MULTIPLICATION
    A = 4'b0101; B = 4'b0011; carry_in = 1'b0;
    sel = 4'b1010; #10; // 5 * 3 = 15 -> Y=F, Y2=0

    A = 4'b1100; B = 4'b1010; carry_in = 1'b0;
    sel = 4'b1010; #10; // 12 * 10 = 120 -> Y=8, Y2=7

    // DIVISION
    A = 4'b1110; B = 4'b0011; carry_in = 1'b0;
    sel = 4'b1011; #10; // 14 / 3 = 4 remainder 2

    A = 4'b1001; B = 4'b0010; carry_in = 1'b0;
    sel = 4'b1011; #10; // 9 / 2 = 4 remainder 1

    // DIVISION BY ZERO
    A = 4'b1110; B = 4'b0000; carry_in = 1'b0;
    sel = 4'b1011; #10; // safe case -> Y=0, Y2=0

    $finish;
end

endmodule
