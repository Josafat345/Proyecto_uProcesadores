`timescale 1ns/1ps
/*
 * Archivo: mux4.v
 * Autor: Proyecto uProcesadores
 * Fecha: 2026-05-23
 * Descripcion: Multiplexor de 4 entradas para seleccionar la entrada Y de la ALU.
 */

module mux4 (
    input wire [1:0] sel,
    input wire [3:0] a_reg,
    input wire [3:0] b_reg,
    input wire [3:0] kval,
    input wire [3:0] sw,
    output reg [3:0] y
);

    always @(*) begin
        case (sel)
            2'b00: y = a_reg;
            2'b01: y = b_reg;
            2'b10: y = kval;
            2'b11: y = sw;
            default: y = 4'b0000;
        endcase
    end

endmodule
