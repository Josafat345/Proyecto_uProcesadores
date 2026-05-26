`timescale 1ns/1ps
/*
 * Archivo: register4.v
 * Autor: Proyecto uProcesadores
 * Fecha: 2026-05-23
 * Descripcion: Registro sincronico de 4 bits con reset asincrono y enable.
 */

module register4 (
    input wire clk,
    input wire reset,
    input wire enable,
    input wire [3:0] d,
    output reg [3:0] q
);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 4'b0000;
        end else if (enable) begin
            q <= d;
        end
    end

endmodule
