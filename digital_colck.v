module digital_clock (
    input clk,
    input rst,
    input en,
  	output reg [5:0] s,         // seconds
    output reg [5:0] m,         // minutes
    output reg [4:0] h          // hours
);

    reg [5:0] seconds_count;        // 6 bits for seconds (0-59)
    reg [5:0] minutes_count;       // 6 bits for minutes (0-59)
    reg [4:0] hours_count;          // 5 bits for hours (0-23)

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            seconds_count <= 6'b000000;
            minutes_count <= 6'b000000;
            hours_count   <= 5'b00000;
        end else if (en) begin
            if (seconds_count == 59) begin
                seconds_count <= 6'b000000;
                if (minutes_count == 59) begin
                    minutes_count <= 6'b000000;
                    if (hours_count == 23) begin
                        hours_count <= 5'b00000;
                    end else begin
                        hours_count <= hours_count + 1;
                    end
                end else begin
                    minutes_count <= minutes_count + 1;
                end
            end else begin
                seconds_count <= seconds_count + 1;
            end
        end
    end

    assign s = seconds_count;
    assign m = minutes_count;
    assign h = hours_count;

endmodule