// ==============================================================
// RTL generated by Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC
// Version: 2015.1
// Copyright (C) 2015 Xilinx Inc. All rights reserved.
//
// ===========================================================


(* CORE_GENERATION_INFO="hls_mem_perf,hls_ip_2015_1,{HLS_INPUT_TYPE=cxx,HLS_INPUT_FLOAT=0,HLS_INPUT_FIXED=1,HLS_INPUT_PART=xc7vx485tffg1761-2,HLS_INPUT_CLOCK=10.000000,HLS_INPUT_ARCH=others,HLS_SYN_CLOCK=8.750000,HLS_SYN_LAT=-1,HLS_SYN_TPT=none,HLS_SYN_MEM=0,HLS_SYN_DSP=4,HLS_SYN_FF=548,HLS_SYN_LUT=633}" *)

module hls_mem_perf (
        ap_clk,
        ap_rst_n,
        ap_start,
        ap_done,
        ap_idle,
        ap_ready,
        mem0_V_req_din,
        mem0_V_req_full_n,
        mem0_V_req_write,
        mem0_V_rsp_empty_n,
        mem0_V_rsp_read,
        mem0_V_address,
        mem0_V_datain,
        mem0_V_dataout,
        mem0_V_size,
        inst_V_dout,
        inst_V_empty_n,
        inst_V_read,
        result_din,
        result_full_n,
        result_write
);

parameter    ap_const_logic_1 = 1'b1;
parameter    ap_const_logic_0 = 1'b0;
parameter    ap_ST_st1_fsm_0 = 4'b0000;
parameter    ap_ST_st2_fsm_1 = 4'b1;
parameter    ap_ST_st3_fsm_2 = 4'b10;
parameter    ap_ST_st4_fsm_3 = 4'b11;
parameter    ap_ST_st5_fsm_4 = 4'b100;
parameter    ap_ST_st6_fsm_5 = 4'b101;
parameter    ap_ST_st7_fsm_6 = 4'b110;
parameter    ap_ST_st8_fsm_7 = 4'b111;
parameter    ap_ST_st9_fsm_8 = 4'b1000;
parameter    ap_ST_st10_fsm_9 = 4'b1001;
parameter    ap_ST_st11_fsm_10 = 4'b1010;
parameter    ap_ST_st12_fsm_11 = 4'b1011;
parameter    ap_ST_st13_fsm_12 = 4'b1100;
parameter    ap_const_lv1_0 = 1'b0;
parameter    ap_const_lv32_0 = 32'b00000000000000000000000000000000;
parameter    ap_const_lv31_0 = 31'b0000000000000000000000000000000;
parameter    ap_const_lv32_1 = 32'b1;
parameter    ap_const_lv32_48 = 32'b1001000;
parameter    ap_const_lv32_67 = 32'b1100111;
parameter    ap_const_lv32_28 = 32'b101000;
parameter    ap_const_lv32_47 = 32'b1000111;
parameter    ap_const_lv32_8 = 32'b1000;
parameter    ap_const_lv32_27 = 32'b100111;
parameter    ap_const_lv8_0 = 8'b00000000;
parameter    ap_const_lv8_1 = 8'b1;
parameter    ap_const_lv8_2 = 8'b10;
parameter    ap_const_lv31_1 = 31'b1;
parameter    ap_const_lv32_3 = 32'b11;
parameter    ap_true = 1'b1;

input   ap_clk;
input   ap_rst_n;
input   ap_start;
output   ap_done;
output   ap_idle;
output   ap_ready;
output   mem0_V_req_din;
input   mem0_V_req_full_n;
output   mem0_V_req_write;
input   mem0_V_rsp_empty_n;
output   mem0_V_rsp_read;
output  [31:0] mem0_V_address;
input  [63:0] mem0_V_datain;
output  [63:0] mem0_V_dataout;
output  [31:0] mem0_V_size;
input  [103:0] inst_V_dout;
input   inst_V_empty_n;
output   inst_V_read;
output  [31:0] result_din;
input   result_full_n;
output   result_write;

reg ap_done;
reg ap_idle;
reg ap_ready;
reg mem0_V_req_din;
reg mem0_V_req_write;
reg mem0_V_rsp_read;
reg[31:0] mem0_V_address;
reg inst_V_read;
reg[31:0] result_din;
reg result_write;
reg    ap_rst_n_inv;
reg   [3:0] ap_CS_fsm = 4'b0000;
reg  signed [31:0] bound_reg_361;
reg  signed [31:0] stride_reg_366;
reg   [31:0] iterations_reg_373;
wire   [0:0] tmp_1_fu_188_p2;
reg   [0:0] tmp_1_reg_379;
wire   [0:0] tmp_3_fu_194_p2;
reg   [0:0] tmp_3_reg_383;
wire   [0:0] tmp_6_fu_200_p2;
reg   [0:0] tmp_6_reg_387;
wire  signed [31:0] grp_fu_150_p2;
reg  signed [31:0] tmp_5_reg_391;
wire   [30:0] iter_2_fu_215_p2;
reg   [30:0] iter_2_reg_399;
wire   [0:0] tmp_s_fu_210_p2;
wire   [0:0] tmp_4_fu_254_p2;
reg    ap_sig_bdd_95;
wire   [31:0] addr_3_fu_242_p3;
reg   [31:0] addr_3_reg_410;
wire   [30:0] iter_1_fu_259_p2;
reg   [30:0] iter_1_reg_418;
wire  signed [32:0] agg_result_V_i_fu_279_p2;
reg  signed [32:0] agg_result_V_i_reg_423;
wire   [31:0] addr_1_fu_295_p3;
reg   [31:0] addr_1_reg_428;
reg   [63:0] value_V_reg_433;
wire   [31:0] error_0_s_fu_338_p3;
reg  signed [31:0] tmp_2_reg_443;
reg   [31:0] addr_assign_1_reg_90;
reg   [31:0] error_reg_102;
reg   [30:0] iter1_reg_115;
reg   [31:0] addr_assign_reg_126;
reg   [30:0] iter_reg_138;
wire  signed [63:0] tmp_8_fu_221_p1;
wire  signed [63:0] tmp_7_fu_346_p1;
wire  signed [31:0] grp_fu_150_p0;
wire  signed [31:0] grp_fu_150_p1;
wire   [7:0] command_V_fu_184_p1;
wire   [31:0] iter1_cast_fu_206_p1;
wire  signed [31:0] addr_2_fu_232_p2;
wire   [0:0] tmp_11_fu_237_p2;
wire   [31:0] iter_cast_fu_250_p1;
wire   [31:0] tmp_fu_269_p2;
wire  signed [32:0] p_1_i_cast_fu_275_p1;
wire  signed [32:0] tmp_7_cast_fu_265_p1;
wire  signed [31:0] addr_fu_285_p2;
wire   [0:0] tmp_9_fu_290_p2;
wire   [31:0] tmp_12_fu_307_p2;
wire  signed [32:0] p_1_i3_cast_fu_313_p1;
wire  signed [32:0] tmp_8_cast_fu_303_p1;
wire  signed [32:0] agg_result_V_i4_fu_317_p2;
wire  signed [63:0] agg_result_V_i4_cast_fu_323_p1;
wire   [0:0] tmp_10_fu_327_p2;
wire   [31:0] error_1_fu_332_p2;
wire    grp_fu_150_ce;
reg   [3:0] ap_NS_fsm;
reg    ap_sig_bdd_88;
reg    ap_sig_bdd_93;
reg    ap_sig_bdd_98;


hls_mem_perf_mul_32s_32s_32_3 #(
    .ID( 1 ),
    .NUM_STAGE( 3 ),
    .din0_WIDTH( 32 ),
    .din1_WIDTH( 32 ),
    .dout_WIDTH( 32 ))
hls_mem_perf_mul_32s_32s_32_3_U1(
    .clk( ap_clk ),
    .reset( ap_rst_n_inv ),
    .din0( grp_fu_150_p0 ),
    .din1( grp_fu_150_p1 ),
    .ce( grp_fu_150_ce ),
    .dout( grp_fu_150_p2 )
);



/// the current state (ap_CS_fsm) of the state machine. ///
always @ (posedge ap_clk)
begin : ap_ret_ap_CS_fsm
    if (ap_rst_n_inv == 1'b1) begin
        ap_CS_fsm <= ap_ST_st1_fsm_0;
    end else begin
        ap_CS_fsm <= ap_NS_fsm;
    end
end

/// assign process. ///
always @(posedge ap_clk)
begin
    if ((ap_ST_st5_fsm_4 == ap_CS_fsm)) begin
        addr_assign_1_reg_90 <= ap_const_lv32_0;
    end else if ((ap_ST_st9_fsm_8 == ap_CS_fsm)) begin
        addr_assign_1_reg_90 <= addr_3_reg_410;
    end
end

/// assign process. ///
always @(posedge ap_clk)
begin
    if ((ap_ST_st12_fsm_11 == ap_CS_fsm)) begin
        addr_assign_reg_126 <= ap_const_lv32_0;
    end else if (((ap_ST_st13_fsm_12 == ap_CS_fsm) & ~(mem0_V_req_full_n == ap_const_logic_0))) begin
        addr_assign_reg_126 <= addr_1_reg_428;
    end
end

/// assign process. ///
always @(posedge ap_clk)
begin
    if ((ap_ST_st5_fsm_4 == ap_CS_fsm)) begin
        error_reg_102 <= ap_const_lv32_0;
    end else if ((ap_ST_st9_fsm_8 == ap_CS_fsm)) begin
        error_reg_102 <= error_0_s_fu_338_p3;
    end
end

/// assign process. ///
always @(posedge ap_clk)
begin
    if ((ap_ST_st5_fsm_4 == ap_CS_fsm)) begin
        iter1_reg_115 <= ap_const_lv31_0;
    end else if ((ap_ST_st9_fsm_8 == ap_CS_fsm)) begin
        iter1_reg_115 <= iter_2_reg_399;
    end
end

/// assign process. ///
always @(posedge ap_clk)
begin
    if ((ap_ST_st12_fsm_11 == ap_CS_fsm)) begin
        iter_reg_138 <= ap_const_lv31_0;
    end else if (((ap_ST_st13_fsm_12 == ap_CS_fsm) & ~(mem0_V_req_full_n == ap_const_logic_0))) begin
        iter_reg_138 <= iter_1_reg_418;
    end
end

/// assign process. ///
always @(posedge ap_clk)
begin
    if (((ap_ST_st6_fsm_5 == ap_CS_fsm) & ~(tmp_1_reg_379 == ap_const_lv1_0) & ~ap_sig_bdd_95 & ~(ap_const_lv1_0 == tmp_4_fu_254_p2))) begin
        addr_1_reg_428 <= addr_1_fu_295_p3;
        agg_result_V_i_reg_423 <= agg_result_V_i_fu_279_p2;
    end
end

/// assign process. ///
always @(posedge ap_clk)
begin
    if (((ap_ST_st6_fsm_5 == ap_CS_fsm) & (tmp_1_reg_379 == ap_const_lv1_0) & ~(tmp_3_reg_383 == ap_const_lv1_0) & ~ap_sig_bdd_95 & ~(ap_const_lv1_0 == tmp_s_fu_210_p2))) begin
        addr_3_reg_410 <= addr_3_fu_242_p3;
    end
end

/// assign process. ///
always @(posedge ap_clk)
begin
    if (((ap_ST_st2_fsm_1 == ap_CS_fsm) & ~(inst_V_empty_n == ap_const_logic_0))) begin
        bound_reg_361 <= {{inst_V_dout[ap_const_lv32_67 : ap_const_lv32_48]}};
        iterations_reg_373 <= {{inst_V_dout[ap_const_lv32_27 : ap_const_lv32_8]}};
        stride_reg_366 <= {{inst_V_dout[ap_const_lv32_47 : ap_const_lv32_28]}};
        tmp_1_reg_379 <= tmp_1_fu_188_p2;
    end
end

/// assign process. ///
always @(posedge ap_clk)
begin
    if (((ap_ST_st6_fsm_5 == ap_CS_fsm) & ~(tmp_1_reg_379 == ap_const_lv1_0) & ~ap_sig_bdd_95)) begin
        iter_1_reg_418 <= iter_1_fu_259_p2;
    end
end

/// assign process. ///
always @(posedge ap_clk)
begin
    if (((ap_ST_st6_fsm_5 == ap_CS_fsm) & (tmp_1_reg_379 == ap_const_lv1_0) & ~(tmp_3_reg_383 == ap_const_lv1_0) & ~ap_sig_bdd_95)) begin
        iter_2_reg_399 <= iter_2_fu_215_p2;
    end
end

/// assign process. ///
always @(posedge ap_clk)
begin
    if ((ap_ST_st12_fsm_11 == ap_CS_fsm)) begin
        tmp_2_reg_443 <= grp_fu_150_p2;
    end
end

/// assign process. ///
always @(posedge ap_clk)
begin
    if (((ap_ST_st2_fsm_1 == ap_CS_fsm) & ~(inst_V_empty_n == ap_const_logic_0) & (tmp_1_fu_188_p2 == ap_const_lv1_0))) begin
        tmp_3_reg_383 <= tmp_3_fu_194_p2;
    end
end

/// assign process. ///
always @(posedge ap_clk)
begin
    if ((ap_ST_st5_fsm_4 == ap_CS_fsm)) begin
        tmp_5_reg_391 <= grp_fu_150_p2;
    end
end

/// assign process. ///
always @(posedge ap_clk)
begin
    if (((ap_ST_st2_fsm_1 == ap_CS_fsm) & ~(inst_V_empty_n == ap_const_logic_0) & (tmp_1_fu_188_p2 == ap_const_lv1_0) & (tmp_3_fu_194_p2 == ap_const_lv1_0))) begin
        tmp_6_reg_387 <= tmp_6_fu_200_p2;
    end
end

/// assign process. ///
always @(posedge ap_clk)
begin
    if (((ap_ST_st8_fsm_7 == ap_CS_fsm) & ~(mem0_V_rsp_empty_n == ap_const_logic_0))) begin
        value_V_reg_433 <= mem0_V_datain;
    end
end

/// ap_done assign process. ///
always @ (ap_CS_fsm or inst_V_empty_n or tmp_1_fu_188_p2 or tmp_3_fu_194_p2 or tmp_6_fu_200_p2)
begin
    if (((ap_ST_st2_fsm_1 == ap_CS_fsm) & ~(inst_V_empty_n == ap_const_logic_0) & (tmp_1_fu_188_p2 == ap_const_lv1_0) & (tmp_3_fu_194_p2 == ap_const_lv1_0) & ~(ap_const_lv1_0 == tmp_6_fu_200_p2))) begin
        ap_done = ap_const_logic_1;
    end else begin
        ap_done = ap_const_logic_0;
    end
end

/// ap_idle assign process. ///
always @ (ap_start or ap_CS_fsm)
begin
    if ((~(ap_const_logic_1 == ap_start) & (ap_ST_st1_fsm_0 == ap_CS_fsm))) begin
        ap_idle = ap_const_logic_1;
    end else begin
        ap_idle = ap_const_logic_0;
    end
end

/// ap_ready assign process. ///
always @ (ap_CS_fsm or inst_V_empty_n or tmp_1_fu_188_p2 or tmp_3_fu_194_p2 or tmp_6_fu_200_p2)
begin
    if (((ap_ST_st2_fsm_1 == ap_CS_fsm) & ~(inst_V_empty_n == ap_const_logic_0) & (tmp_1_fu_188_p2 == ap_const_lv1_0) & (tmp_3_fu_194_p2 == ap_const_lv1_0) & ~(ap_const_lv1_0 == tmp_6_fu_200_p2))) begin
        ap_ready = ap_const_logic_1;
    end else begin
        ap_ready = ap_const_logic_0;
    end
end

/// inst_V_read assign process. ///
always @ (ap_CS_fsm or inst_V_empty_n)
begin
    if (((ap_ST_st2_fsm_1 == ap_CS_fsm) & ~(inst_V_empty_n == ap_const_logic_0))) begin
        inst_V_read = ap_const_logic_1;
    end else begin
        inst_V_read = ap_const_logic_0;
    end
end

/// mem0_V_address assign process. ///
always @ (ap_CS_fsm or mem0_V_req_full_n or tmp_1_reg_379 or tmp_3_reg_383 or tmp_s_fu_210_p2 or ap_sig_bdd_95 or tmp_8_fu_221_p1 or tmp_7_fu_346_p1)
begin
    if (((ap_ST_st13_fsm_12 == ap_CS_fsm) & ~(mem0_V_req_full_n == ap_const_logic_0))) begin
        mem0_V_address = tmp_7_fu_346_p1;
    end else if (((ap_ST_st6_fsm_5 == ap_CS_fsm) & (tmp_1_reg_379 == ap_const_lv1_0) & ~(tmp_3_reg_383 == ap_const_lv1_0) & ~ap_sig_bdd_95 & ~(ap_const_lv1_0 == tmp_s_fu_210_p2))) begin
        mem0_V_address = tmp_8_fu_221_p1;
    end else begin
        mem0_V_address = 'bx;
    end
end

/// mem0_V_req_din assign process. ///
always @ (ap_CS_fsm or mem0_V_req_full_n or tmp_1_reg_379 or tmp_3_reg_383 or tmp_s_fu_210_p2 or ap_sig_bdd_95)
begin
    if (((ap_ST_st13_fsm_12 == ap_CS_fsm) & ~(mem0_V_req_full_n == ap_const_logic_0))) begin
        mem0_V_req_din = ap_const_logic_1;
    end else if (((ap_ST_st6_fsm_5 == ap_CS_fsm) & (tmp_1_reg_379 == ap_const_lv1_0) & ~(tmp_3_reg_383 == ap_const_lv1_0) & ~ap_sig_bdd_95 & ~(ap_const_lv1_0 == tmp_s_fu_210_p2))) begin
        mem0_V_req_din = ap_const_logic_0;
    end else begin
        mem0_V_req_din = ap_const_logic_0;
    end
end

/// mem0_V_req_write assign process. ///
always @ (ap_CS_fsm or mem0_V_req_full_n or tmp_1_reg_379 or tmp_3_reg_383 or tmp_s_fu_210_p2 or ap_sig_bdd_95)
begin
    if ((((ap_ST_st6_fsm_5 == ap_CS_fsm) & (tmp_1_reg_379 == ap_const_lv1_0) & ~(tmp_3_reg_383 == ap_const_lv1_0) & ~ap_sig_bdd_95 & ~(ap_const_lv1_0 == tmp_s_fu_210_p2)) | ((ap_ST_st13_fsm_12 == ap_CS_fsm) & ~(mem0_V_req_full_n == ap_const_logic_0)))) begin
        mem0_V_req_write = ap_const_logic_1;
    end else begin
        mem0_V_req_write = ap_const_logic_0;
    end
end

/// mem0_V_rsp_read assign process. ///
always @ (ap_CS_fsm or mem0_V_rsp_empty_n)
begin
    if (((ap_ST_st8_fsm_7 == ap_CS_fsm) & ~(mem0_V_rsp_empty_n == ap_const_logic_0))) begin
        mem0_V_rsp_read = ap_const_logic_1;
    end else begin
        mem0_V_rsp_read = ap_const_logic_0;
    end
end

/// result_din assign process. ///
always @ (error_reg_102 or ap_sig_bdd_88 or ap_sig_bdd_93 or ap_sig_bdd_98)
begin
    if (ap_sig_bdd_98) begin
        if (ap_sig_bdd_93) begin
            result_din = ap_const_lv32_0;
        end else if (ap_sig_bdd_88) begin
            result_din = error_reg_102;
        end else begin
            result_din = 'bx;
        end
    end else begin
        result_din = 'bx;
    end
end

/// result_write assign process. ///
always @ (ap_CS_fsm or tmp_1_reg_379 or tmp_3_reg_383 or tmp_s_fu_210_p2 or tmp_4_fu_254_p2 or ap_sig_bdd_95)
begin
    if ((((ap_ST_st6_fsm_5 == ap_CS_fsm) & (tmp_1_reg_379 == ap_const_lv1_0) & ~(tmp_3_reg_383 == ap_const_lv1_0) & (ap_const_lv1_0 == tmp_s_fu_210_p2) & ~ap_sig_bdd_95) | ((ap_ST_st6_fsm_5 == ap_CS_fsm) & ~(tmp_1_reg_379 == ap_const_lv1_0) & (ap_const_lv1_0 == tmp_4_fu_254_p2) & ~ap_sig_bdd_95))) begin
        result_write = ap_const_logic_1;
    end else begin
        result_write = ap_const_logic_0;
    end
end
/// the next state (ap_NS_fsm) of the state machine. ///
always @ (ap_start or ap_CS_fsm or mem0_V_req_full_n or mem0_V_rsp_empty_n or inst_V_empty_n or tmp_1_fu_188_p2 or tmp_1_reg_379 or tmp_3_fu_194_p2 or tmp_3_reg_383 or tmp_6_fu_200_p2 or tmp_6_reg_387 or tmp_s_fu_210_p2 or tmp_4_fu_254_p2 or ap_sig_bdd_95)
begin
    case (ap_CS_fsm)
        ap_ST_st1_fsm_0 :
        begin
            if (~(ap_start == ap_const_logic_0)) begin
                ap_NS_fsm = ap_ST_st2_fsm_1;
            end else begin
                ap_NS_fsm = ap_ST_st1_fsm_0;
            end
        end
        ap_ST_st2_fsm_1 :
        begin
            if ((~(inst_V_empty_n == ap_const_logic_0) & (tmp_1_fu_188_p2 == ap_const_lv1_0) & (tmp_3_fu_194_p2 == ap_const_lv1_0) & ~(ap_const_lv1_0 == tmp_6_fu_200_p2))) begin
                ap_NS_fsm = ap_ST_st1_fsm_0;
            end else if ((~(inst_V_empty_n == ap_const_logic_0) & (tmp_1_fu_188_p2 == ap_const_lv1_0) & (tmp_3_fu_194_p2 == ap_const_lv1_0) & (ap_const_lv1_0 == tmp_6_fu_200_p2))) begin
                ap_NS_fsm = ap_ST_st6_fsm_5;
            end else if ((~(inst_V_empty_n == ap_const_logic_0) & (tmp_1_fu_188_p2 == ap_const_lv1_0) & ~(tmp_3_fu_194_p2 == ap_const_lv1_0))) begin
                ap_NS_fsm = ap_ST_st3_fsm_2;
            end else if ((~(inst_V_empty_n == ap_const_logic_0) & ~(tmp_1_fu_188_p2 == ap_const_lv1_0))) begin
                ap_NS_fsm = ap_ST_st10_fsm_9;
            end else begin
                ap_NS_fsm = ap_ST_st2_fsm_1;
            end
        end
        ap_ST_st3_fsm_2 :
        begin
            ap_NS_fsm = ap_ST_st4_fsm_3;
        end
        ap_ST_st4_fsm_3 :
        begin
            ap_NS_fsm = ap_ST_st5_fsm_4;
        end
        ap_ST_st5_fsm_4 :
        begin
            ap_NS_fsm = ap_ST_st6_fsm_5;
        end
        ap_ST_st6_fsm_5 :
        begin
            if ((~ap_sig_bdd_95 & (((tmp_1_reg_379 == ap_const_lv1_0) & ~(tmp_3_reg_383 == ap_const_lv1_0) & (ap_const_lv1_0 == tmp_s_fu_210_p2)) | (~(tmp_1_reg_379 == ap_const_lv1_0) & (ap_const_lv1_0 == tmp_4_fu_254_p2)) | ((tmp_1_reg_379 == ap_const_lv1_0) & (tmp_3_reg_383 == ap_const_lv1_0) & (ap_const_lv1_0 == tmp_6_reg_387))))) begin
                ap_NS_fsm = ap_ST_st2_fsm_1;
            end else if ((~(tmp_1_reg_379 == ap_const_lv1_0) & ~ap_sig_bdd_95 & ~(ap_const_lv1_0 == tmp_4_fu_254_p2))) begin
                ap_NS_fsm = ap_ST_st13_fsm_12;
            end else if (((tmp_1_reg_379 == ap_const_lv1_0) & ~(tmp_3_reg_383 == ap_const_lv1_0) & ~ap_sig_bdd_95 & ~(ap_const_lv1_0 == tmp_s_fu_210_p2))) begin
                ap_NS_fsm = ap_ST_st7_fsm_6;
            end else begin
                ap_NS_fsm = ap_ST_st6_fsm_5;
            end
        end
        ap_ST_st7_fsm_6 :
        begin
            ap_NS_fsm = ap_ST_st8_fsm_7;
        end
        ap_ST_st8_fsm_7 :
        begin
            if (~(mem0_V_rsp_empty_n == ap_const_logic_0)) begin
                ap_NS_fsm = ap_ST_st9_fsm_8;
            end else begin
                ap_NS_fsm = ap_ST_st8_fsm_7;
            end
        end
        ap_ST_st9_fsm_8 :
        begin
            ap_NS_fsm = ap_ST_st6_fsm_5;
        end
        ap_ST_st10_fsm_9 :
        begin
            ap_NS_fsm = ap_ST_st11_fsm_10;
        end
        ap_ST_st11_fsm_10 :
        begin
            ap_NS_fsm = ap_ST_st12_fsm_11;
        end
        ap_ST_st12_fsm_11 :
        begin
            ap_NS_fsm = ap_ST_st6_fsm_5;
        end
        ap_ST_st13_fsm_12 :
        begin
            if (~(mem0_V_req_full_n == ap_const_logic_0)) begin
                ap_NS_fsm = ap_ST_st6_fsm_5;
            end else begin
                ap_NS_fsm = ap_ST_st13_fsm_12;
            end
        end
        default :
        begin
            ap_NS_fsm = 'bx;
        end
    endcase
end

assign addr_1_fu_295_p3 = ((tmp_9_fu_290_p2[0:0]===1'b1)? addr_fu_285_p2: ap_const_lv32_0);
assign addr_2_fu_232_p2 = ($signed(addr_assign_1_reg_90) + $signed(stride_reg_366));
assign addr_3_fu_242_p3 = ((tmp_11_fu_237_p2[0:0]===1'b1)? addr_2_fu_232_p2: ap_const_lv32_0);
assign addr_fu_285_p2 = ($signed(addr_assign_reg_126) + $signed(stride_reg_366));
assign agg_result_V_i4_cast_fu_323_p1 = agg_result_V_i4_fu_317_p2;
assign agg_result_V_i4_fu_317_p2 = ($signed(p_1_i3_cast_fu_313_p1) + $signed(tmp_8_cast_fu_303_p1));
assign agg_result_V_i_fu_279_p2 = ($signed(p_1_i_cast_fu_275_p1) + $signed(tmp_7_cast_fu_265_p1));

/// ap_rst_n_inv assign process. ///
always @ (ap_rst_n)
begin
    ap_rst_n_inv = ~ap_rst_n;
end

/// ap_sig_bdd_88 assign process. ///
always @ (tmp_1_reg_379 or tmp_3_reg_383 or tmp_s_fu_210_p2)
begin
    ap_sig_bdd_88 = ((tmp_1_reg_379 == ap_const_lv1_0) & ~(tmp_3_reg_383 == ap_const_lv1_0) & (ap_const_lv1_0 == tmp_s_fu_210_p2));
end

/// ap_sig_bdd_93 assign process. ///
always @ (tmp_1_reg_379 or tmp_4_fu_254_p2)
begin
    ap_sig_bdd_93 = (~(tmp_1_reg_379 == ap_const_lv1_0) & (ap_const_lv1_0 == tmp_4_fu_254_p2));
end

/// ap_sig_bdd_95 assign process. ///
always @ (result_full_n or tmp_1_reg_379 or tmp_3_reg_383 or tmp_s_fu_210_p2 or tmp_4_fu_254_p2)
begin
    ap_sig_bdd_95 = (((result_full_n == ap_const_logic_0) & (tmp_1_reg_379 == ap_const_lv1_0) & ~(tmp_3_reg_383 == ap_const_lv1_0) & (ap_const_lv1_0 == tmp_s_fu_210_p2)) | ((result_full_n == ap_const_logic_0) & ~(tmp_1_reg_379 == ap_const_lv1_0) & (ap_const_lv1_0 == tmp_4_fu_254_p2)));
end

/// ap_sig_bdd_98 assign process. ///
always @ (ap_CS_fsm or ap_sig_bdd_95)
begin
    ap_sig_bdd_98 = ((ap_ST_st6_fsm_5 == ap_CS_fsm) & ~ap_sig_bdd_95);
end
assign command_V_fu_184_p1 = inst_V_dout[7:0];
assign error_0_s_fu_338_p3 = ((tmp_10_fu_327_p2[0:0]===1'b1)? error_reg_102: error_1_fu_332_p2);
assign error_1_fu_332_p2 = (ap_const_lv32_1 + error_reg_102);
assign grp_fu_150_ce = ap_const_logic_1;
assign grp_fu_150_p0 = stride_reg_366;
assign grp_fu_150_p1 = bound_reg_361;
assign iter1_cast_fu_206_p1 = iter1_reg_115;
assign iter_1_fu_259_p2 = (iter_reg_138 + ap_const_lv31_1);
assign iter_2_fu_215_p2 = (iter1_reg_115 + ap_const_lv31_1);
assign iter_cast_fu_250_p1 = iter_reg_138;
assign mem0_V_dataout = $signed(agg_result_V_i_reg_423);
assign mem0_V_size = ap_const_lv32_1;
assign p_1_i3_cast_fu_313_p1 = $signed(tmp_12_fu_307_p2);
assign p_1_i_cast_fu_275_p1 = $signed(tmp_fu_269_p2);
assign tmp_10_fu_327_p2 = (value_V_reg_433 == agg_result_V_i4_cast_fu_323_p1? 1'b1: 1'b0);
assign tmp_11_fu_237_p2 = ($signed(addr_2_fu_232_p2) < $signed(tmp_5_reg_391)? 1'b1: 1'b0);
assign tmp_12_fu_307_p2 = addr_assign_1_reg_90 << ap_const_lv32_3;
assign tmp_1_fu_188_p2 = (command_V_fu_184_p1 == ap_const_lv8_0? 1'b1: 1'b0);
assign tmp_3_fu_194_p2 = (command_V_fu_184_p1 == ap_const_lv8_1? 1'b1: 1'b0);
assign tmp_4_fu_254_p2 = ($signed(iter_cast_fu_250_p1) < $signed(iterations_reg_373)? 1'b1: 1'b0);
assign tmp_6_fu_200_p2 = (command_V_fu_184_p1 == ap_const_lv8_2? 1'b1: 1'b0);
assign tmp_7_cast_fu_265_p1 = $signed(addr_assign_reg_126);
assign tmp_7_fu_346_p1 = $signed(addr_assign_reg_126);
assign tmp_8_cast_fu_303_p1 = $signed(addr_assign_1_reg_90);
assign tmp_8_fu_221_p1 = $signed(addr_assign_1_reg_90);
assign tmp_9_fu_290_p2 = ($signed(addr_fu_285_p2) < $signed(tmp_2_reg_443)? 1'b1: 1'b0);
assign tmp_fu_269_p2 = addr_assign_reg_126 << ap_const_lv32_3;
assign tmp_s_fu_210_p2 = ($signed(iter1_cast_fu_206_p1) < $signed(iterations_reg_373)? 1'b1: 1'b0);


endmodule //hls_mem_perf

