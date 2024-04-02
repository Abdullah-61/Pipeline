cd ./mkhex	
    vim hell.s
	riscv64-unknown-elf-as hell.s -o hell.o -march=rv32i -mabi=ilp32
	riscv64-unknown-elf-objdump -S hell.o > hell.hex
	riscv64-unknown-elf-objdump -S hell.o -M numeric
    awk '{if ($2 ~ /^[0-9a-f]+$/) print $2}' hell.hex > ../inst.mem
