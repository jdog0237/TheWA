module alu_16bit (
    input  [15:0] A,
    input  [15:0] B,
    input         carry_in,
    input  [3:0]  sel,
    output reg [15:0] Y,
    output reg [15:0] Y2,
    output reg        carry_out
);

    reg [16:0] temp_add;
    reg [16:0] temp_sub;
    reg [31:0] temp_mul;

    always @(*) begin
        // default outputs
        Y = 16'b0000000000000000;
        Y2 = 16'b0000000000000000;
        carry_out = 1'b0;

        case (sel)

            // Logic operations
            4'b0000: Y = A & B;           // AND
            4'b0001: Y = ~(A & B);        // NAND
            4'b0010: Y = A | B;           // OR
            4'b0011: Y = ~(A | B);        // NOR
            4'b0100: Y = A ^ B;           // XOR
            4'b0101: Y = ~(A ^ B);        // XNOR
            4'b0110: Y = ~A;              // NOT A

            // Arithmetic Shifter
            // Y  = shifted A
            // Y2 = shifted B
            // Example: arithmetic right shift by 1
            4'b0111: begin
                Y  = {A[15], A[15:1]};    // arithmetic right shift A
                Y2 = {B[15], B[15:1]};    // arithmetic right shift B
            end

            // Addition: Y = lower 16 bits, carry_out = carry
            4'b1000: begin
                temp_add = A + B + carry_in;
                Y = temp_add[15:0];
                carry_out = temp_add[16];
            end

            // Subtraction: A - B - carry_in
            4'b1001: begin
                temp_sub = A - B - carry_in;
                Y = temp_sub[15:0];
                carry_out = temp_sub[16];  // borrow/carry indicator by implementation
            end

            // Multiplication: Y = low 16 bits, Y2 = high 16 bits
            4'b1010: begin
                temp_mul = A * B;
                Y  = temp_mul[15:0];
                Y2 = temp_mul[31:16];
            end

            // Division: Y = quotient, Y2 = remainder
            4'b1011: begin
                if (B != 16'b0000000000000000) begin
                    Y  = A / B;
                    Y2 = A % B;
                end
                else begin
                    Y  = 16'b0000000000000000;
                    Y2 = 16'b0000000000000000;
                end
            end

            // Arithmetic left shift by 1
            4'b1100: begin
                Y  = A <<< 1;
                Y2 = B <<< 1;
            end

            // Arithmetic right shift by 1
            4'b1101: begin
                Y  = A >>> 1;
                Y2 = B >>> 1;
            end

            default: begin
                Y = 16'b0000000000000000;
                Y2 = 16'b0000000000000000;
                carry_out = 1'b0;
            end

        endcase
    end

endmodule
