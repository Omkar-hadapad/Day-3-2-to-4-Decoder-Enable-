//==============================================================
// DAY 3 : COMPLETE VERIFICATION
// File : day3_tb.v
//==============================================================

module day3_tb;


    //==========================================================
    // BASIC GATE SIGNALS
    //==========================================================

    reg A;
    reg B;

    wire NOT_A;
    wire AND_Y;


    not_gate NOT1 (
        .A(A),
        .Y(NOT_A)
    );

    and_gate AND1 (
        .A(A),
        .B(B),
        .Y(AND_Y)
    );


    //==========================================================
    // DECODER WITHOUT ENABLE
    //==========================================================

    wire D0;
    wire D1;
    wire D2;
    wire D3;

    decoder_2to4 DECODER1 (
        .A(A),
        .B(B),
        .Y0(D0),
        .Y1(D1),
        .Y2(D2),
        .Y3(D3)
    );


    //==========================================================
    // ENABLE LOGIC
    //==========================================================

    reg EN;

    wire ENABLE_Y;

    enable_logic ENABLE1 (
        .Y_in(D0),
        .EN(EN),
        .Y_out(ENABLE_Y)
    );


    //==========================================================
    // DECODER WITH ENABLE
    //==========================================================

    wire E0;
    wire E1;
    wire E2;
    wire E3;

    decoder_2to4_enable DECODER_ENABLE (
        .A(A),
        .B(B),
        .EN(EN),
        .Y0(E0),
        .Y1(E1),
        .Y2(E2),
        .Y3(E3)
    );


    //==========================================================
    // RTL DECODER
    //==========================================================

    wire R0;
    wire R1;
    wire R2;
    wire R3;

    decoder_2to4_rtl DECODER_RTL (
        .A(A),
        .B(B),
        .EN(EN),
        .Y0(R0),
        .Y1(R1),
        .Y2(R2),
        .Y3(R3)
    );


    //==========================================================
    // TOP MODULE
    //==========================================================

    wire T0;
    wire T1;
    wire T2;
    wire T3;

    decoder_2to4_top TOP (
        .A(A),
        .B(B),
        .EN(EN),
        .Y0(T0),
        .Y1(T1),
        .Y2(T2),
        .Y3(T3)
    );


    //==========================================================
    // VERIFICATION
    //==========================================================

    initial begin

        $display("=================================================");
        $display("       DAY 3 : 2-to-4 DECODER VERIFICATION");
        $display("=================================================");


        //======================================================
        // 1. BASIC GATES
        //======================================================

        $display("");
        $display("---- 1. BASIC GATE VERIFICATION ----");


        A = 0;
        B = 0;
        #10;

        if (NOT_A == 1 && AND_Y == 0)
            $display("GATE TEST 00 : PASS");
        else
            $display("GATE TEST 00 : FAIL");


        A = 0;
        B = 1;
        #10;

        if (NOT_A == 1 && AND_Y == 0)
            $display("GATE TEST 01 : PASS");
        else
            $display("GATE TEST 01 : FAIL");


        A = 1;
        B = 0;
        #10;

        if (NOT_A == 0 && AND_Y == 0)
            $display("GATE TEST 10 : PASS");
        else
            $display("GATE TEST 10 : FAIL");


        A = 1;
        B = 1;
        #10;

        if (NOT_A == 0 && AND_Y == 1)
            $display("GATE TEST 11 : PASS");
        else
            $display("GATE TEST 11 : FAIL");


        //======================================================
        // 2. DECODER WITHOUT ENABLE
        //======================================================

        $display("");
        $display("---- 2. 2-to-4 DECODER ----");


        // A B = 00 -> Y0
        A = 0;
        B = 0;
        #10;

        if (D0 == 1 &&
            D1 == 0 &&
            D2 == 0 &&
            D3 == 0)
            $display("DECODER 00 : PASS");
        else
            $display("DECODER 00 : FAIL");


        // A B = 01 -> Y1
        A = 0;
        B = 1;
        #10;

        if (D0 == 0 &&
            D1 == 1 &&
            D2 == 0 &&
            D3 == 0)
            $display("DECODER 01 : PASS");
        else
            $display("DECODER 01 : FAIL");


        // A B = 10 -> Y2
        A = 1;
        B = 0;
        #10;

        if (D0 == 0 &&
            D1 == 0 &&
            D2 == 1 &&
            D3 == 0)
            $display("DECODER 10 : PASS");
        else
            $display("DECODER 10 : FAIL");


        // A B = 11 -> Y3
        A = 1;
        B = 1;
        #10;

        if (D0 == 0 &&
            D1 == 0 &&
            D2 == 0 &&
            D3 == 1)
            $display("DECODER 11 : PASS");
        else
            $display("DECODER 11 : FAIL");


        //======================================================
        // 3. ENABLE LOGIC
        //======================================================

        $display("");
        $display("---- 3. ENABLE VERIFICATION ----");


        // EN = 0
        // All outputs must be disabled.

        EN = 0;
        A = 0;
        B = 0;
        #10;

        if (ENABLE_Y == 0)
            $display("ENABLE OFF : PASS");
        else
            $display("ENABLE OFF : FAIL");


        // EN = 1
        // D0 is selected for AB=00.

        EN = 1;
        A = 0;
        B = 0;
        #10;

        if (ENABLE_Y == 1)
            $display("ENABLE ON : PASS");
        else
            $display("ENABLE ON : FAIL");


        //======================================================
        // 4. DECODER WITH ENABLE
        //======================================================

        $display("");
        $display("---- 4. DECODER WITH ENABLE ----");


        // EN = 0
        EN = 0;
        A = 0;
        B = 0;
        #10;

        if (E0 == 0 &&
            E1 == 0 &&
            E2 == 0 &&
            E3 == 0)
            $display("ENABLE DECODER OFF : PASS");
        else
            $display("ENABLE DECODER OFF : FAIL");


        // EN = 1, AB = 00
        EN = 1;
        A = 0;
        B = 0;
        #10;

        if (E0 == 1 &&
            E1 == 0 &&
            E2 == 0 &&
            E3 == 0)
            $display("ENABLE DECODER 00 : PASS");
        else
            $display("ENABLE DECODER 00 : FAIL");


        // EN = 1, AB = 01
        A = 0;
        B = 1;
        #10;

        if (E0 == 0 &&
            E1 == 1 &&
            E2 == 0 &&
            E3 == 0)
            $display("ENABLE DECODER 01 : PASS");
        else
            $display("ENABLE DECODER 01 : FAIL");


        // EN = 1, AB = 10
        A = 1;
        B = 0;
        #10;

        if (E0 == 0 &&
            E1 == 0 &&
            E2 == 1 &&
            E3 == 0)
            $display("ENABLE DECODER 10 : PASS");
        else
            $display("ENABLE DECODER 10 : FAIL");


        // EN = 1, AB = 11
        A = 1;
        B = 1;
        #10;

        if (E0 == 0 &&
            E1 == 0 &&
            E2 == 0 &&
            E3 == 1)
            $display("ENABLE DECODER 11 : PASS");
        else
            $display("ENABLE DECODER 11 : FAIL");


        //======================================================
        // 5. GATE-LEVEL VS RTL DECODER
        //======================================================

        $display("");
        $display("---- 5. GATE-LEVEL VS RTL ----");


        A = 0;
        B = 0;
        EN = 1;
        #10;

        if (E0 == R0 &&
            E1 == R1 &&
            E2 == R2 &&
            E3 == R3)
            $display("RTL/GATE 00 : PASS");
        else
            $display("RTL/GATE 00 : FAIL");


        A = 0;
        B = 1;
        #10;

        if (E0 == R0 &&
            E1 == R1 &&
            E2 == R2 &&
            E3 == R3)
            $display("RTL/GATE 01 : PASS");
        else
            $display("RTL/GATE 01 : FAIL");


        A = 1;
        B = 0;
        #10;

        if (E0 == R0 &&
            E1 == R1 &&
            E2 == R2 &&
            E3 == R3)
            $display("RTL/GATE 10 : PASS");
        else
            $display("RTL/GATE 10 : FAIL");


        A = 1;
        B = 1;
        #10;

        if (E0 == R0 &&
            E1 == R1 &&
            E2 == R2 &&
            E3 == R3)
            $display("RTL/GATE 11 : PASS");
        else
            $display("RTL/GATE 11 : FAIL");


        //======================================================
        // 6. TOP MODULE VERIFICATION
        //======================================================

        $display("");
        $display("---- 6. TOP MODULE VERIFICATION ----");


        A = 0;
        B = 0;
        EN = 1;
        #10;

        if (T0 == 1 &&
            T1 == 0 &&
            T2 == 0 &&
            T3 == 0)
            $display("TOP 00 : PASS");
        else
            $display("TOP 00 : FAIL");


        A = 0;
        B = 1;
        EN = 1;
        #10;

        if (T0 == 0 &&
            T1 == 1 &&
            T2 == 0 &&
            T3 == 0)
            $display("TOP 01 : PASS");
        else
            $display("TOP 01 : FAIL");


        A = 1;
        B = 0;
        EN = 1;
        #10;

        if (T0 == 0 &&
            T1 == 0 &&
            T2 == 1 &&
            T3 == 0)
            $display("TOP 10 : PASS");
        else
            $display("TOP 10 : FAIL");


        A = 1;
        B = 1;
        EN = 1;
        #10;

        if (T0 == 0 &&
            T1 == 0 &&
            T2 == 0 &&
            T3 == 1)
            $display("TOP 11 : PASS");
        else
            $display("TOP 11 : FAIL");


        // Enable OFF
        EN = 0;
        A = 1;
        B = 1;
        #10;

        if (T0 == 0 &&
            T1 == 0 &&
            T2 == 0 &&
            T3 == 0)
            $display("TOP ENABLE OFF : PASS");
        else
            $display("TOP ENABLE OFF : FAIL");


        //======================================================
        // FINISH
        //======================================================

        $display("");
        $display("=================================================");
        $display("       DAY 3 VERIFICATION COMPLETED");
        $display("=================================================");

        $finish;

    end

endmodule
