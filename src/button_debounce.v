`timescale 1ns/1ps

module button_debounce (
    input  wire clk,        // system clock (100 MHz on ZedBoard)
    input  wire btn_raw,    // raw mechanical button input
    output wire btn_pulse   // one-clock clean pulse
);

    // ------------------------------------------------------------
    // 1. Synchronizer (2 flip-flops)
    // ------------------------------------------------------------
    reg btn_sync_0;
    reg btn_sync_1;

    always @(posedge clk) begin
        btn_sync_0 <= btn_raw;
        btn_sync_1 <= btn_sync_0;
    end

    // ------------------------------------------------------------
    // 2. Debounce counter
    // ------------------------------------------------------------
    localparam MAX_COUNT = 20'd1_000_000;  // ~10 ms @ 100 MHz

    reg [19:0] count;
    reg        btn_db;

    always @(posedge clk) begin
        if (btn_sync_1) begin
            if (count < MAX_COUNT)
                count <= count + 1;
        end else begin
            count <= 0;
        end

        if (count == MAX_COUNT)
            btn_db <= 1'b1;
        else
            btn_db <= 1'b0;
    end

    // ------------------------------------------------------------
    // 3. Edge detection (level → pulse)
    // ------------------------------------------------------------
    reg btn_db_d;

    always @(posedge clk) begin
        btn_db_d <= btn_db;
    end

    assign btn_pulse = btn_db & ~btn_db_d;

endmodule
