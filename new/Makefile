hex: hexgen vsim


show: hexgen
	riscv64-unknown-elf-objdump --disassembler-color=on -S .mkhex/hell.o
hexgen:
	cd ./mkhex
	./mkhex/mkhex.sh

output:
	mkdir output
setup: output
	cd output
vlog: 
	iverilog -o hello -g2012 main_tb.sv top_pipeline.sv mux3x1.sv  ALU.sv Controller.sv instr_mem.sv instruction_decoder.sv pc_adder.sv pc.sv register_file.sv immediate_gen.sv mux.sv Data_mem.sv branch_cond.sv d_flipflop.sv d_flipflop_32.sv d_flipflop_32_sync.sv

vsim: vlog hexgen 
	vvp hello

gtk: 
	gtkwave waveform.vcd load_i.gtkw &
