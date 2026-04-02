// ADD
        A = 4'b1110; B = 4'b0011; carry_in = 1'b1; sel = 4'b1000; #10;

        // SUB
        A = 4'b1001; B = 4'b0011; carry_in = 1'b0; sel = 4'b1001; #10;

        // MUL
        A = 4'b0101; B = 4'b0011; sel = 4'b1010; #10;

        // DIV
        A = 4'b1110; B = 4'b0011; sel = 4'b1011; #10;

        // DIV by zero
        A = 4'b1110; B = 4'b0000; sel = 4'b1011; #10;

        // Arithmetic left shift
        A = 4'b0101; B = 4'b1010; sel = 4'b1100; #10;

        // Arithmetic right shift
        A = 4'b1101; B = 4'b1000; sel = 4'b1101; #10;

        $finish;
    end

endmodule