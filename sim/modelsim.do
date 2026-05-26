# El script calcula la ruta del proyecto a partir de su propia ubicacion.
set SCRIPT_PATH [file normalize [info script]]
if {$SCRIPT_PATH eq ""} {
    set SCRIPT_DIR [file normalize [pwd]]
} else {
    set SCRIPT_DIR [file dirname $SCRIPT_PATH]
}
set PROJECT_DIR [file normalize [file join $SCRIPT_DIR ..]]
set RTL_DIR [file join $PROJECT_DIR rtl]
set TB_DIR [file join $PROJECT_DIR tb]
set WORK_DIR [file join $PROJECT_DIR sim work]

puts "SCRIPT_DIR  = $SCRIPT_DIR"
puts "PROJECT_DIR = $PROJECT_DIR"
puts "RTL_DIR     = $RTL_DIR"
puts "TB_DIR      = $TB_DIR"
puts "WORK_DIR    = $WORK_DIR"

if {![file exists [file join $RTL_DIR register4.v]]} {
    error "No encuentro los archivos RTL. Ejecuta este script desde la carpeta sim del proyecto o usando su ruta completa."
}

if {![file exists $WORK_DIR]} {
    file mkdir $WORK_DIR
}

cd $WORK_DIR

catch {transcript file [file join $WORK_DIR modelsim_transcript.log]}
catch {transcript on}

catch {quit -sim}

if {[file exists work]} {
    catch {vdel -lib work -all}
}

vlib work
vmap work work

vlog [file join $RTL_DIR register4.v]
vlog [file join $RTL_DIR mux4.v]
vlog [file join $RTL_DIR alu4.v]
vlog [file join $RTL_DIR flag_registers.v]
vlog [file join $RTL_DIR datapath.v]
vlog [file join $RTL_DIR microstore.v]
vlog [file join $RTL_DIR control_unit.v]
vlog [file join $RTL_DIR proyecto_microcodificado_top.v]
vlog [file join $TB_DIR tb_proyecto_microcodificado.v]

vsim work.tb_proyecto_microcodificado

catch {delete wave *}

add wave -divider "Entradas"
add wave -label "Clock" -radix binary sim:/tb_proyecto_microcodificado/Clock
add wave -label "Reset" -radix binary sim:/tb_proyecto_microcodificado/Reset
add wave -label "SW[3:0]" -radix hexadecimal sim:/tb_proyecto_microcodificado/SW

add wave -divider "Salidas principales"
add wave -label "ADDx direccion" -radix binary sim:/tb_proyecto_microcodificado/ADDx
add wave -label "LEDS / Reg C" -radix hexadecimal sim:/tb_proyecto_microcodificado/LEDS

add wave -divider "Registros del datapath"
add wave -label "Reg A" -radix hexadecimal sim:/tb_proyecto_microcodificado/REG_A_DBG
add wave -label "Reg B" -radix hexadecimal sim:/tb_proyecto_microcodificado/REG_B_DBG
add wave -label "Reg C" -radix hexadecimal sim:/tb_proyecto_microcodificado/LEDS

add wave -divider "Banderas"
add wave -label "Z flag" -radix binary sim:/tb_proyecto_microcodificado/Z_FLAG_DBG
add wave -label "C flag" -radix binary sim:/tb_proyecto_microcodificado/C_FLAG_DBG
add wave -label "Branch tomado" -radix binary sim:/tb_proyecto_microcodificado/BRANCH_DBG

add wave -divider "Control microcodificado"
add wave -label "TEST" -radix binary sim:/tb_proyecto_microcodificado/dut/test
add wave -label "NATT" -radix binary sim:/tb_proyecto_microcodificado/dut/natt
add wave -label "En A" -radix binary sim:/tb_proyecto_microcodificado/dut/en_a
add wave -label "En B" -radix binary sim:/tb_proyecto_microcodificado/dut/en_b
add wave -label "En C" -radix binary sim:/tb_proyecto_microcodificado/dut/en_c
add wave -label "Sel MUX" -radix binary sim:/tb_proyecto_microcodificado/dut/sel_mux
add wave -label "Sel ALU" -radix binary sim:/tb_proyecto_microcodificado/dut/sel_alu
add wave -label "FS flags" -radix binary sim:/tb_proyecto_microcodificado/dut/fs
add wave -label "KVAL" -radix hexadecimal sim:/tb_proyecto_microcodificado/dut/kval
add wave -label "ALU Z" -radix hexadecimal sim:/tb_proyecto_microcodificado/dut/alu_z
add wave -label "ALU CF" -radix binary sim:/tb_proyecto_microcodificado/dut/cf
add wave -label "ALU ZF" -radix binary sim:/tb_proyecto_microcodificado/dut/zf

configure wave -namecolwidth 220
configure wave -valuecolwidth 80
configure wave -justifyvalue left
configure wave -signalnamewidth 1

run -all
