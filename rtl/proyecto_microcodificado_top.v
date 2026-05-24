`timescale 1ns/1ps
/*
 * Archivo: proyecto_microcodificado_top.v
 * Autor: Josaf
 * Fecha: 2026-05-23
 * Descripcion: Modulo superior del proyecto de trayectoria de datos microcodificada.
 */

module proyecto_microcodificado_top (
    input wire Clock,
    input wire Reset,
    input wire [3:0] SW,
    output wire [3:0] ADDx,
    output wire [3:0] LEDS,
    output wire [3:0] REG_A_DBG,
    output wire [3:0] REG_B_DBG,
    output wire Z_FLAG_DBG,
    output wire C_FLAG_DBG,
    output wire BRANCH_DBG
);

    wire [1:0] test;
    wire [3:0] natt;
    wire en_a;
    wire en_b;
    wire en_c;
    wire [1:0] sel_mux;
    wire [1:0] sel_alu;
    wire fs;
    wire [3:0] kval;
    wire [3:0] alu_z;
    wire cf;
    wire zf;

    control_unit control (
        .clk(Clock),
        .reset(Reset),
        .c_flag(C_FLAG_DBG),
        .z_flag(Z_FLAG_DBG),
        .address(ADDx),
        .test(test),
        .natt(natt),
        .en_a(en_a),
        .en_b(en_b),
        .en_c(en_c),
        .sel_mux(sel_mux),
        .sel_alu(sel_alu),
        .fs(fs),
        .kval(kval),
        .branch_taken(BRANCH_DBG)
    );

    datapath path (
        .clk(Clock),
        .reset(Reset),
        .sw(SW),
        .kval(kval),
        .en_a(en_a),
        .en_b(en_b),
        .en_c(en_c),
        .sel_mux(sel_mux),
        .sel_alu(sel_alu),
        .fs(fs),
        .reg_a(REG_A_DBG),
        .reg_b(REG_B_DBG),
        .reg_c(LEDS),
        .alu_z(alu_z),
        .cf(cf),
        .zf(zf),
        .c_flag(C_FLAG_DBG),
        .z_flag(Z_FLAG_DBG)
    );

endmodule
