`timescale 1ns/1ps
/*
 * Archivo: flag_registers.v
 * Autor: Josaf
 * Fecha: 2026-05-23
 * Descripcion: Registros de banderas C y Z con seleccion entre valor actual y guardado.
 */

module flag_registers (
    input wire clk,
    input wire reset,
    input wire fs,
    input wire cf_in,
    input wire zf_in,
    output wire c_flag,
    output wire z_flag
);

    reg c_flag_q;
    reg z_flag_q;

    assign c_flag = fs ? cf_in : c_flag_q;
    assign z_flag = fs ? zf_in : z_flag_q;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            c_flag_q <= 1'b0;
            z_flag_q <= 1'b0;
        end else begin
            c_flag_q <= c_flag;
            z_flag_q <= z_flag;
        end
    end

endmodule
