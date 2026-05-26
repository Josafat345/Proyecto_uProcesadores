`timescale 1ns/1ps
/*
 * Archivo: tb_proyecto_microcodificado.v
 * Autor: Proyecto uProcesadores
 * Fecha: 2026-05-23
 * Descripcion: Testbench para ModelSim del proyecto microcodificado.
 */

module tb_proyecto_microcodificado;

    reg Clock;
    reg Reset;
    reg [3:0] SW;

    wire [3:0] ADDx;
    wire [3:0] LEDS;
    wire [3:0] REG_A_DBG;
    wire [3:0] REG_B_DBG;
    wire Z_FLAG_DBG;
    wire C_FLAG_DBG;
    wire BRANCH_DBG;

    integer cycle;

    proyecto_microcodificado_top dut (
        .Clock(Clock),
        .Reset(Reset),
        .SW(SW),
        .ADDx(ADDx),
        .LEDS(LEDS),
        .REG_A_DBG(REG_A_DBG),
        .REG_B_DBG(REG_B_DBG),
        .Z_FLAG_DBG(Z_FLAG_DBG),
        .C_FLAG_DBG(C_FLAG_DBG),
        .BRANCH_DBG(BRANCH_DBG)
    );

    initial begin
        Clock = 1'b0;
        forever #5 Clock = ~Clock;
    end

    initial begin
        cycle = 0;
        Reset = 1'b1;
        SW = 4'h0;

        $dumpfile("proyecto_microcodificado.vcd");
        $dumpvars(0, tb_proyecto_microcodificado);

        $display("Tiempo  Ciclo Reset SW   Direccion REG-A REG-B REG-C Z-flag C-flag Branch");
        $display("------  ----- ----- ---- --------- ----- ----- ----- ------ ------ ------");

        #17 Reset = 1'b0;

        // Primero SW=0 para demostrar que se toma el salto con Z-flag guardada.
        #41 SW = 4'h4;

        // Luego SW=4 para permitir que el programa pase al contador interno.
        #260 $finish;
    end

    always @(posedge Clock) begin
        #1;
        $display("%6t  %5d   %1b   %04b    %04b    %04b  %04b  %04b    %1b      %1b      %1b",
                 $time, cycle, Reset, SW, ADDx, REG_A_DBG, REG_B_DBG, LEDS,
                 Z_FLAG_DBG, C_FLAG_DBG, BRANCH_DBG);
        cycle = cycle + 1;
    end

endmodule
