module top_pipeline#(
    parameter WIDTH = 32 // Default width is 32 bits
) (
    input logic clk,                   // Clock signal
    input logic rst                   // Asynchronous reset signal
);
     logic enable;           // Enable signal for the PC
     logic [3:0] ALU_OP;
     logic reg_wr;
     logic instr;

    
    logic [WIDTH-1:0] pc_next;   //signals for program counter
    logic [WIDTH-1:0] pc_current;
     
    logic [31:0] Inst;
    logic [6:0] opcode;
    logic [2:0] funct3;
    logic [6:0] funct7;
    logic [4:0] rs1;
    logic [4:0] rs2;
    logic [4:0] rd;
    logic [31:0] immediate;
    
                // signals for register file // Register write enable signal
    logic [3:0]  raddr1;    // Address of the first register to read (rs1)
    logic [3:0]  raddr2;    // Address of the second register to read (rs2)
    logic [3:0]  waddr;     // Address of the register to write (rd)
    logic [31:0] wdata;     // Data to write into the register (write data)
    logic [31:0] rdata1;    // Data read from the first register
    logic [31:0] rdata2;
    
    logic [31:0] operand_a;  // ALU signals
    logic [31:0] operand_b;
    logic [3:0] opselect;
    
    logic [31:0] immediate_out;   //I- type
    logic select_b;
    logic [31:0] mux_b_output;

    logic rd_en;      //Load signals
    logic [1:0]wb_sel;
    logic [31:0] loaded_data; 
    logic [31:0] wdata2;    

    logic write_enable;     //for store type
    logic [31:0] alu_output;

    logic [1:0]br_type;
    logic br_taken;    //for branch
    logic sel_A;
    logic [31:0] mux_pc_output;
    logic [31:0] mux3_operand_a;
    
    logic [31:0] Inst_F;
    logic [31:0] PC_F;

    logic [31:0] PC_E;
    logic [31:0] ALU_E;
    logic [31:0] rdata2_E2M;
    logic [31:0] Inst_E2M;

    logic reg_wrMW;
    logic wr_enMW;
    logic rd_enMW;
    logic wb_selMW;

    logic forward_A;
    logic [31:0] forwarded_A_output;
    logic forward_B;
    logic [31:0] forwarded_B_output;



      
//Fetch Cycle
pc pc1(clk,rst,mux_pc_output,pc_current);
pc_adder pc_adder1(pc_current,pc_next);
mux mux_pc(pc_next,alu_output,br_taken,mux_pc_output);    
instr_mem instr_memory1(pc_current,Inst);
d_flipflop_32 PCF2D(pc_current,clk,rst,PC_F);
d_flipflop_32_sync InstF2D(Inst,clk,!(br_taken),Inst_F);   //br_taken is sent as a flusher here

//Decode and Execute Cycle

instruction_decoder instr_decoder1(Inst_F,opcode,funct3,funct7,rs1,rs2,rd,immediate);
register_file register_file1(clk,reg_wr,rs1,rs2,Inst_E2M[11:7],wdata2,rdata1,rdata2);
branch_cond branch_cond1(br_type,funct3,opcode,rdata1,rdata2,br_taken);
mux forward_mux1(rdata2,alu_output,1'b0,forwarded_B_output);  
mux mux1(forwarded_B_output,immediate_out,select_b,mux_b_output);    //selecting forwarded_B_output when select_b is 0
immediate_gen immediate1(Inst_F,immediate_out);
mux forward_mux3(rdata1,alu_output,1'b0,forwarded_A_output);  //select alu_output when forward_A is 1
mux mux3(forwarded_A_output,PC_F,sel_A,mux3_operand_a);  //selecting forwarded_A_output when sel_A is 0
ALU alu1(mux3_operand_a,mux_b_output,opselect,alu_output);
d_flipflop_32 PCE2M(PC_F,clk,rst,PC_E);
d_flipflop_32 ALUE2M(alu_output,clk,rst,ALU_E);
d_flipflop_32 WDE2M(rdata2,clk,rst,rdata2_E2M);
d_flipflop_32 InstE2M(Inst_F,clk,rst,Inst_E2M);



Data_mem data_mem(clk,alu_output[10:0],alu_output[10:0],rdata2,write_enable,rd_en,loaded_data);
//mux mux2(alu_output,loaded_data,wb_sel,wdata2);  //if wb_sel is 1, pick loaded data

mux3x1 mux(loaded_data,alu_output,pc_current,wb_sel,wdata2);
Controller controller1(Inst_F,opselect,reg_wr,select_b,rd_en,wb_sel,write_enable,br_type,sel_A);
d_flipflop controllerE2M_1(reg_wr,clk,rst,reg_wrMW);
d_flipflop controllerE2M_2(write_enable,clk,rst,wr_enMW);
d_flipflop controllerE2M_3(rd_en,clk,rst,rd_enMW);
d_flipflop controllerE2M_4(wb_sel_en,clk,rst,wb_selMW);

//forward_unit forwad_unit(reg_wrMW,br_taken)






   
   
   
   
   
   
  
  
  
  
    
    
    
    
endmodule
