`timescale 1ns/1ps
/*
 * Archivo: control_unit.v
 * Autor: Proyecto uProcesadores
 * Fecha: 2026-05-23
 * Descripcion: Unidad de control microprogramada con contador de direccion.
 */

module control_unit (
    input wire clk,
    input wire reset,
    input wire c_flag,
    input wire z_flag,
    output reg [3:0] address,
    output wire [1:0] test,
    output wire [3:0] natt,
    output wire en_a,
    output wire en_b,
    output wire en_c,
    output wire [1:0] sel_mux,
    output wire [1:0] sel_alu,
    output wire fs,
    output wire [3:0] kval,
    output reg branch_taken
);

    wire [3:0] next_address;

    microstore rom (
        .address(address),
        .test(test),
        .natt(natt),
        .en_a(en_a),
        .en_b(en_b),
        .en_c(en_c),
        .sel_mux(sel_mux),
        .sel_alu(sel_alu),
        .fs(fs),
        .kval(kval)
    );

    always @(*) begin
        case (test)
            2'b00: branch_taken = 1'b0;
            2'b01: branch_taken = 1'b1;
            2'b10: branch_taken = c_flag;
            2'b11: branch_taken = z_flag;
            default: branch_taken = 1'b0;
        endcase
    end

    assign next_address = branch_taken ? natt : (address + 4'b0001);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            address <= 4'b0000;
        end else begin
            address <= next_address;
        end
    end

endmodule
