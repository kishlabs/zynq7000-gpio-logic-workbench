module top (
    input  wire        clk,        // 100 MHz clock (ZedBoard)
    input  wire [4:0]  btn,        // Push buttons
    input  wire [7:0]  sw,         // Slide switches
    output wire [7:0]  led         // LEDs
);

    // ------------------------------------------------------------
    // LED state register
    // ------------------------------------------------------------
    reg [7:0] led_reg;
    assign led = led_reg;

    // ------------------------------------------------------------
    // Debounced button pulses
    // ------------------------------------------------------------
    wire btn_reset_pulse;   // BTND
    wire btn_load_pulse;    // BTNU
    wire btn_left_pulse;    // BTNL
    wire btn_right_pulse;   // BTNR
    wire btn_invert_pulse;  // BTNC

    // ------------------------------------------------------------
    // Button debounce instances (MATCHING XDC)
    // ------------------------------------------------------------

    // BTNC -> invert
    button_debounce u_btn_invert (
        .clk(clk),
        .btn_raw(btn[0]),
        .btn_pulse(btn_invert_pulse)
    );

    // BTNU -> load
    button_debounce u_btn_load (
        .clk(clk),
        .btn_raw(btn[1]),
        .btn_pulse(btn_load_pulse)
    );

    // BTND -> reset
    button_debounce u_btn_reset (
        .clk(clk),
        .btn_raw(btn[2]),
        .btn_pulse(btn_reset_pulse)
    );

    // BTNL -> shift left
    button_debounce u_btn_left (
        .clk(clk),
        .btn_raw(btn[3]),
        .btn_pulse(btn_left_pulse)
    );

    // BTNR -> shift right
    button_debounce u_btn_right (
        .clk(clk),
        .btn_raw(btn[4]),
        .btn_pulse(btn_right_pulse)
    );

    // ------------------------------------------------------------
    // LED control logic (priority based)
    // ------------------------------------------------------------
    always @(posedge clk) begin
        if (btn_reset_pulse) begin
            led_reg <= 8'b00000000;
        end
        else if (btn_load_pulse) begin
            led_reg <= sw;
        end
        else if (btn_left_pulse) begin
            led_reg <= led_reg << 1;
        end
        else if (btn_right_pulse) begin
            led_reg <= led_reg >> 1;
        end
        else if (btn_invert_pulse) begin
            led_reg <= ~led_reg;
        end
    end

endmodule
