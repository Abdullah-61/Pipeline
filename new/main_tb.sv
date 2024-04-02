`timescale 1ns / 1ps

module main_tb;

    // Testbench signals
    logic clk, reset;

    // Instantiate the main processor module
    top_pipeline dut (
        .clk(clk),
        .rst(reset)
    );

    // Clock generation
    always #5 clk = ~clk; // Generate a clock with a period of 10ns

    // Test sequence
    initial begin
        // Initialize signals
        clk = 0;
        reset = 0; // Assert reset

        // Apply reset for some time
        #15 reset = 1; // Deassert reset after 20ns

        // Wait for some time and then start tests
        #100; // Wait 100ns for the global reset to propagate

        // Here you would put your test instructions, potentially by directly
        // writing into the instruction memory of the 'main' module if it's accessible.
        // Example:
        // dut.inst_mem.memory_array[0] = 32'h...; // Some R-type instruction

        // Alternatively, if the InstructionMemory module loads from a file, you could
        // use $readmemh or $readmemb in the InstructionMemory module to load the
        // instructions from a file.

        // You could also drive other inputs to your processor if needed and monitor outputs.

        // Finish the simulation after some time
        #1000; // Run simulation for 1000ns
        $finish;
    end

    // Monitor the processor's state
   // initial begin
     //   $monitor("Time: %t, PC: %h, Instruction: %h, alu_operand_b: %h,Read_Address: %h,Data_in: %h ,  write_data: %h, x4: %h, write_address: %h ...", $time, dut.pc_current, dut.instruction, dut.alu_operand_b , dut.data_mem.write_address , dut.data_mem.data_in, dut.reg_file.write_data,dut.reg_file.registers[4], dut.reg_file.write_address);
        // Add more signals to monitor based on your requirements
    //end

    // You can also add assertions or checks here to automatically verify that the
    // processor's outputs are as expected for given inputs.
    initial
          begin
              $dumpfile("waveform.vcd");
              $dumpvars(0,main_tb);
          end

endmodule
