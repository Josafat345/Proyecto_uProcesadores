`timescale 1ns/1ps
/*
 * Archivo: datapath.v
 * Autor: Josaf
 * Fecha: 2026-05-23
 * Descripcion: Trayectoria de datos de 4 bits con registros, MUX, ALU y banderas.
 */

module datapath (
    input wire clk,
    input wire reset,
    input wire [3:0] sw,
    input wire [3:0] kval,
    input wire en_a,
    input wire en_b,
    input wire en_c,
    input wire [1:0] sel_mux,
    input wire [1:0] sel_alu,
    input wire fs,
    output wire [3:0] reg_a,
    output wire [3:0] reg_b,
    output wire [3:0] reg_c,
    output wire [3:0] alu_z,
    output wire cf,
    output wire zf,
    output wire c_flag,
    output wire z_flag
);

    wire [3:0] y_bus;

    mux4 mux_y (
        .sel(sel_mux),
        .a_reg(reg_a),
        .b_reg(reg_b),
        .kval(kval),
        .sw(sw),
        .y(y_bus)
    );

    alu4 alu (
        .x(reg_c),
        .y(y_bus),
        .sel_alu(sel_alu),
        .z(alu_z),
        .cf(cf),
        .zf(zf)
    );

    register4 reg_a_inst (
        .clk(clk),
        .reset(reset),
        .enable(en_a),
        .d(alu_z),
        .q(reg_a)
    );

    register4 reg_b_inst (
        .clk(clk),
        .reset(reset),
        .enable(en_b),
        .d(alu_z),
        .q(reg_b)
    );

    register4 reg_c_inst (
        .clk(clk),
        .reset(reset),
        .enable(en_c),
        .d(alu_z),
        .q(reg_c)
    );

    flag_registers flags (
        .clk(clk),
        .reset(reset),
        .fs(fs),
        .cf_in(cf),
        .zf_in(zf),
        .c_flag(c_flag),
        .z_flag(z_flag)
    );

endmodule
