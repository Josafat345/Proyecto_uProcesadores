`timescale 1ns/1ps
/*
 * Archivo: microstore.v
 * Autor: Josafat Vasquez
 * Fecha: 2026-05-23
 * Descripcion: ROM de microcodigo para el programa de demostracion.
 */

module microstore (
    input wire [3:0] address,
    output reg [1:0] test,
    output reg [3:0] natt,
    output reg en_a,
    output reg en_b,
    output reg en_c,
    output reg [1:0] sel_mux,
    output reg [1:0] sel_alu,
    output reg fs,
    output reg [3:0] kval
);

    always @(*) begin
        test = 2'b00;
        natt = 4'b0000;
        en_a = 1'b0;
        en_b = 1'b0;
        en_c = 1'b0;
        sel_mux = 2'b00;
        sel_alu = 2'b00;
        fs = 1'b0;
        kval = 4'b0000;

        case (address)
            4'b0000: begin
                // Start: C <- $F
                test = 2'b00;
                en_c = 1'b1;
                sel_mux = 2'b10;
                sel_alu = 2'b10;
                kval = 4'b1111;
            end

            4'b0001: begin
                // GetSW: A,B <- SW
                // FS=1 guarda si SW fue cero para usarlo en la siguiente instruccion.
                test = 2'b00;
                en_a = 1'b1;
                en_b = 1'b1;
                sel_mux = 2'b11;
                sel_alu = 2'b10;
                fs = 1'b1;
            end

            4'b0010: begin
                // B,C <- C - A, if Z-flag* goto Start
                // FS=0 usa la bandera Z guardada por la instruccion anterior.
                test = 2'b11;
                natt = 4'b0000;
                en_b = 1'b1;
                en_c = 1'b1;
                sel_mux = 2'b00;
                sel_alu = 2'b01;
                fs = 1'b0;
            end

            4'b0011: begin
                // C <- A
                test = 2'b00;
                en_c = 1'b1;
                sel_mux = 2'b00;
                sel_alu = 2'b10;
            end

            4'b0100: begin
                // Top: C <- C + 1
                test = 2'b00;
                en_c = 1'b1;
                sel_mux = 2'b10;
                sel_alu = 2'b00;
                kval = 4'b0001;
            end

            4'b0101: begin
                // C - B, if C-flag goto Top
                test = 2'b10;
                natt = 4'b0100;
                sel_mux = 2'b01;
                sel_alu = 2'b01;
                fs = 1'b1;
            end

            4'b0110: begin
                // goto Start
                test = 2'b01;
                natt = 4'b0000;
            end

            default: begin
                // Direcciones no usadas regresan al inicio.
                test = 2'b01;
                natt = 4'b0000;
            end
        endcase
    end

endmodule
