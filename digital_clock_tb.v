`timescale 1ns/1ps
module digital_clock_tb;

    reg clk;
    reg rst;
    reg en;
  	wire [5:0] s;
    wire [5:0] m;
    wire [4:0] h;

    // Instantiate the digital clock module
    digital_clock dut (
        .clk(clk),
        .rst(rst),
        .en(en),
        .s(s),
        .m(m),
        .h(h)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10ns period -> 100MHz clock
    end

    // Stimulus
    initial begin
        // Initialize inputs
        rst = 1;
        en = 0;

        // Apply reset
        #10;
        rst = 0;

        // Enable the clock
        #20;
        en = 1;

        // Run simulation for a while
        #2000;
        // Disable the clock
        en = 0;
        $finish;
    end

    initial begin
        // Dump waveforms for GTKWave
        $dumpfile("digital_clock.vcd");
        $dumpvars(0, digital_clock_tb);
    end
  initial begin
    $monitor("%d : %d : %d", h, m, s);
  end

endmodule