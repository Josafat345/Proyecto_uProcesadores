# Proyecto - Trayectoria de Datos Microcodificada

Este proyecto implementa en Verilog una trayectoria de datos microcodificada de 4 bits, separada por modulos y preparada para simularse en ModelSim.

## Estructura

- `rtl/register4.v`: registro de 4 bits con reset asincrono y enable.
- `rtl/mux4.v`: multiplexor de entrada `Y` para la ALU.
- `rtl/alu4.v`: ALU de 4 bits.
- `rtl/flag_registers.v`: banderas `C-flag` y `Z-flag`.
- `rtl/datapath.v`: trayectoria de datos completa.
- `rtl/microstore.v`: ROM de microcodigo.
- `rtl/control_unit.v`: contador de direccion y logica de bifurcacion.
- `rtl/proyecto_microcodificado_top.v`: modulo superior.
- `tb/tb_proyecto_microcodificado.v`: testbench.
- `sim/modelsim.do`: script para compilar y simular en ModelSim.

## Simulacion en ModelSim

Desde ModelSim, entrar a la carpeta `sim` y ejecutar:

```tcl
do modelsim.do
```

El testbench imprime una tabla de eventos con:

```text
Tiempo, Ciclo, Reset, SW, Direccion, REG-A, REG-B, REG-C, Z-flag, C-flag, Branch
```

El testbench inicia con `SW = 0` para demostrar el retardo de bifurcacion y luego cambia a `SW = 4`.

## Microcodigo implementado

```text
0000 Start: C <- $F
0001 GetSW: A,B <- SW
0010        B,C <- C - A, if Z-flag* goto Start
0011        C <- A
0100 Top:   C <- C + 1
0101        C - B, if C-flag goto Top
0110        goto Start
```
