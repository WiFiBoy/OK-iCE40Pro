/*
 *   blink.v -- top level of blink example
 */

module blink (
    input  clk12,
    output led_r
);
    reg [23:0] counter;

    always @(posedge clk12) begin
        counter <= counter + 1;
    end

    assign led_r = counter[23];

endmodule