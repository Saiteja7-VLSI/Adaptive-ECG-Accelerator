`timescale 1ns / 1ps

module moving_average_axis #
(
parameter DATA_WIDTH = 32,
parameter WINDOW = 4
)
(input  wire aclk,
input  wire aresetn,
input  wire [DATA_WIDTH-1:0] s_axis_tdata,
input  wire s_axis_tvalid,
output wire s_axis_tready,
input  wire s_axis_tlast,

output reg  [DATA_WIDTH-1:0] m_axis_tdata,
output reg m_axis_tvalid,
input  wire m_axis_tready,
output reg m_axis_tlast);

reg signed [DATA_WIDTH-1:0] buffer [0:WINDOW-1];
reg signed [DATA_WIDTH-1:0] sum;
integer i;

assign s_axis_tready = m_axis_tready;

always @(posedge aclk) begin
      if (!aresetn) begin
            m_axis_tvalid <= 0;
            m_axis_tdata  <= 0;
            m_axis_tlast  <= 0;
        end
        else begin
            if (s_axis_tvalid && m_axis_tready) begin

                sum = 0;

                for (i = WINDOW-1; i > 0; i = i - 1)
                    buffer[i] <= buffer[i-1];

                buffer[0] <= s_axis_tdata;

                for (i = 0; i < WINDOW; i = i + 1)
                    sum = sum + buffer[i];

                m_axis_tdata <= sum / WINDOW;
                m_axis_tvalid <= 1;
                m_axis_tlast  <= s_axis_tlast;
            end
        end
    end

endmodule
