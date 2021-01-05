/*
 *   clock.v -- top level of clock example
 */

module blink (
    input  clk12,
    output p1
);
    assign p1 = clk12;

endmodule