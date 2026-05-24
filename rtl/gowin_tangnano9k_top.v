`timescale 1ns/1ps
/*
 * Archivo: gowin_tangnano9k_top.v
 * Autor: Josafat Vasquez
 * Fecha: 2026-05-24
 * Descripcion: Envoltorio para implementar el proyecto en la Tang Nano 9K.
 */

module gowin_tangnano9k_top (
    input wire sys_clk,
    input wire sys_rst_n,
    input wire [3:0] sw,
    output wire [3:0] led
);

    reg [23:0] clk_div;
    wire [3:0] addx_unused;
    wire [3:0] leds_internal;
    wire [3:0] reg_a_unused;
    wire [3:0] reg_b_unused;
    wire z_flag_unused;
    wire c_flag_unused;
    wire branch_unused;
    wire core_clk;

    always @(posedge sys_clk or negedge sys_rst_n) begin
        if (!sys_rst_n)
            clk_div <= 24'd0;
        else
            clk_div <= clk_div + 24'd1;
    end

    assign core_clk = clk_div[23];

    proyecto_microcodificado_top core (
        .Clock(core_clk),
        .Reset(~sys_rst_n),
        .SW(sw),
        .ADDx(addx_unused),
        .LEDS(leds_internal),
        .REG_A_DBG(reg_a_unused),
        .REG_B_DBG(reg_b_unused),
        .Z_FLAG_DBG(z_flag_unused),
        .C_FLAG_DBG(c_flag_unused),
        .BRANCH_DBG(branch_unused)
    );

    // Los LEDs onboard de la Tang Nano 9K son activos en bajo.
    assign led = ~leds_internal;

endmodule
