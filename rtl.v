//==============================================================
// DAY 3 : 2-to-4 DECODER WITH ENABLE
// File    : day3_design.v
// Language: Verilog-2001
//==============================================================


//==============================================================
// 1. NOT GATE
//==============================================================
module not_gate (
    input A,
    output Y
);

    assign Y = ~A;

endmodule


//==============================================================
// 2. AND GATE
//==============================================================
module and_gate (
    input A,
    input B,
    output Y
);

    assign Y = A & B;

endmodule


//==============================================================
// 3. 2-INPUT AND GATE USING BASIC AND GATE
//==============================================================
// This module is included for hierarchy clarity.
// It performs the same logical operation as and_gate.
//
// For a decoder, multiple signals need to be ANDed together.
//==============================================================

module decoder_and3 (
    input A,
    input B,
    input C,
    output Y
);

    wire W;

    and_gate A1 (
        .A(A),
        .B(B),
        .Y(W)
    );

    and_gate A2 (
        .A(W),
        .B(C),
        .Y(Y)
    );

endmodule


//==============================================================
// 4. 2-to-4 DECODER WITHOUT ENABLE
//
// Inputs:
// A, B
//
// Outputs:
// Y0, Y1, Y2, Y3
//
// Truth:
//
// A B | Y0 Y1 Y2 Y3
// -------------------
// 0 0 |  1  0  0  0
// 0 1 |  0  1  0  0
// 1 0 |  0  0  1  0
// 1 1 |  0  0  0  1
//==============================================================
module decoder_2to4 (
    input A,
    input B,
    output Y0,
    output Y1,
    output Y2,
    output Y3
);

    wire A_not;
    wire B_not;

    // Generate complements
    not_gate N1 (
        .A(A),
        .Y(A_not)
    );

    not_gate N2 (
        .A(B),
        .Y(B_not)
    );


    // Y0 = A'B'
    and_gate AND0 (
        .A(A_not),
        .B(B_not),
        .Y(Y0)
    );


    // Y1 = A'B
    and_gate AND1 (
        .A(A_not),
        .B(B),
        .Y(Y1)
    );


    // Y2 = AB'
    and_gate AND2 (
        .A(A),
        .B(B_not),
        .Y(Y2)
    );


    // Y3 = AB
    and_gate AND3 (
        .A(A),
        .B(B),
        .Y(Y3)
    );

endmodule


//==============================================================
// 5. ENABLE LOGIC
//
// Enable = 0 -> output disabled
// Enable = 1 -> decoder outputs enabled
//
// Y_enabled = Y_decoder AND EN
//==============================================================
module enable_logic (
    input Y_in,
    input EN,
    output Y_out
);

    and_gate AND_EN (
        .A(Y_in),
        .B(EN),
        .Y(Y_out)
    );

endmodule


//==============================================================
// 6. 2-to-4 DECODER WITH ENABLE
//
// Equations:
//
// Y0 = EN.A'.B'
// Y1 = EN.A'.B
// Y2 = EN.A.B'
// Y3 = EN.A.B
//==============================================================
module decoder_2to4_enable (
    input A,
    input B,
    input EN,
    output Y0,
    output Y1,
    output Y2,
    output Y3
);

    wire D0;
    wire D1;
    wire D2;
    wire D3;

    // Decoder without enable
    decoder_2to4 DECODER (
        .A(A),
        .B(B),
        .Y0(D0),
        .Y1(D1),
        .Y2(D2),
        .Y3(D3)
    );


    // Enable each output
    enable_logic E0 (
        .Y_in(D0),
        .EN(EN),
        .Y_out(Y0)
    );

    enable_logic E1 (
        .Y_in(D1),
        .EN(EN),
        .Y_out(Y1)
    );

    enable_logic E2 (
        .Y_in(D2),
        .EN(EN),
        .Y_out(Y2)
    );

    enable_logic E3 (
        .Y_in(D3),
        .EN(EN),
        .Y_out(Y3)
    );

endmodule


//==============================================================
// 7. BEHAVIORAL RTL VERSION
//
// This is the compact RTL representation.
//
// Used for comparison with the gate-level implementation.
//==============================================================
module decoder_2to4_rtl (
    input A,
    input B,
    input EN,
    output reg Y0,
    output reg Y1,
    output reg Y2,
    output reg Y3
);

    always @(*) begin

        // Default outputs
        Y0 = 1'b0;
        Y1 = 1'b0;
        Y2 = 1'b0;
        Y3 = 1'b0;

        if (EN) begin

            case ({A,B})

                2'b00:
                    Y0 = 1'b1;

                2'b01:
                    Y1 = 1'b1;

                2'b10:
                    Y2 = 1'b1;

                2'b11:
                    Y3 = 1'b1;

                default: begin
                    Y0 = 1'b0;
                    Y1 = 1'b0;
                    Y2 = 1'b0;
                    Y3 = 1'b0;
                end

            endcase

        end

    end

endmodule


//==============================================================
// 8. TOP MODULE
//
// Complete Day 3 design.
//
// This module exposes the final interface.
//==============================================================
module decoder_2to4_top (
    input A,
    input B,
    input EN,
    output Y0,
    output Y1,
    output Y2,
    output Y3
);

    decoder_2to4_enable DECODER_TOP (
        .A(A),
        .B(B),
        .EN(EN),
        .Y0(Y0),
        .Y1(Y1),
        .Y2(Y2),
        .Y3(Y3)
    );

endmodule
