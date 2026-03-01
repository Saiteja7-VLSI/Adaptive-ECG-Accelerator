`timescale 1ns / 1ps

module fir_filter_axis #
(parameter DATA_WIDTH = 32,
parameter TAP_NUM = 5
)
(input  wire aclk,
input  wire aresetn,

    // AXI Stream Slave
input  wire [DATA_WIDTH-1:0] s_axis_tdata,
input  wire  s_axis_tvalid,
output wire s_axis_tready,
input  wire s_axis_tlast,

    // AXI Stream Master
output reg  [DATA_WIDTH-1:0] m_axis_tdata,
output reg  m_axis_tvalid,
input  wire m_axis_tready,
output reg m_axis_tlast);

    // FIR coefficients
    reg signed [DATA_WIDTH-1:0] coeffs [0:TAP_NUM-1];
    initial begin
        coeffs[0] = 1;
        coeffs[1] = 2;
        coeffs[2] = 3;
        coeffs[3] = 2;
        coeffs[4] = 1;
    end

    // Shift register
    reg signed [DATA_WIDTH-1:0] shift_reg [0:TAP_NUM-1];
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
                
                // Shift
                for (i = TAP_NUM-1; i > 0; i = i - 1)
                    shift_reg[i] <= shift_reg[i-1];

                shift_reg[0] <= s_axis_tdata;

                // FIR computation
                m_axis_tdata <= 
                    shift_reg[0]*coeffs[0] +
                    shift_reg[1]*coeffs[1] +
                    shift_reg[2]*coeffs[2] +
                    shift_reg[3]*coeffs[3] +
                    shift_reg[4]*coeffs[4];

                m_axis_tvalid <= 1;
                m_axis_tlast  <= s_axis_tlast;
            end
        end
    end

endmodule
