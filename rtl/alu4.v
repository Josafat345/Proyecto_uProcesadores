`timescale 1ns/1ps
/*
 * Archivo: alu4.v
 * Autor: Proyecto uProcesadores
 * Fecha: 2026-05-23
 * Descripcion: ALU de 4 bits con suma, resta, paso de Y y AND bit a bit.
 */

module alu4 (
    input wire [3:0] x,
    input wire [3:0] y,
    input wire [1:0] sel_alu,
    output reg [3:0] z,
    output reg cf,
    output wire zf
);

    reg [4:0] temp;

    always @(*) begin
        z = 4'b0000;
        cf = 1'b0;
        temp = 5'b00000;

        case (sel_alu)
            2'b00: begin
                temp = {1'b0, x} + {1'b0, y};
                z = temp[3:0];
                cf = temp[4];
            end

            2'b01: begin
                temp = {1'b0, x} + {1'b0, ~y} + 5'b00001;
                z = temp[3:0];
                cf = ~temp[4];
            end

            2'b10: begin
                z = y;
                cf = 1'b0;
            end

            2'b11: begin
                z = x & y;
                cf = 1'b0;
            end

            default: begin
                z = 4'b0000;
                cf = 1'b0;
            end
        endcase
    end

    assign zf = (z == 4'b0000);

endmodule
