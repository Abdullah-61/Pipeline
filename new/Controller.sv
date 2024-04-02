`include "DEFS.svh"
module Controller(
                 input logic [31:0] Inst,
                 output logic [3:0] alu_op,
                 output logic reg_wr,
                 output logic select_b,
                 output logic rd_en,
                 output logic [1:0]wb_sel,
                 output logic write_enable,
                 output logic [1:0]br_type,
                 output logic sel_A);
    
    logic [2:0] funct3;
    logic [6:0] funct7; 
    
    
    assign funct3 = Inst[14:12];
    assign funct7 = Inst[31:25];
    type_opcode opcode;
    assign opcode = type_opcode'(Inst[6:0]);
always @(*)
begin    
case(opcode)
      // R-type opcode (for example, 0110011)
     op_r: begin
          reg_wr = 1'b1;
          select_b=1'b0;       // pick rdata2  
          rd_en= 1'b0;
          wb_sel=2'b01;
          write_enable=1'b0;  
          br_type=2'b00;
          sel_A=1'b0; 
            // R-type instructions write to register
            // Determine ALU operation based on funct3 and funct7
                
          case ({funct7, funct3})
                10'b0000000000: alu_op = alu_add  ; // ADD (0)
                10'b0100000000: alu_op = alu_sub  ; // SUB (1)
                10'b0000000001: alu_op = alu_sll  ; // SLL (2)
                10'b0000000010: alu_op = alu_slt  ; // SLT (3)
                10'b0000000011: alu_op = alu_sltu ; // SLTU (4)
                10'b0000000100: alu_op = alu_xor  ; // XOR (5)
                10'b0000000101: alu_op = alu_srl  ; // SRL (6)
                10'b0100000101: alu_op = alu_sra  ; // SRA (7)
                10'b0000000110: alu_op = alu_or   ; // OR (8)
                10'b0000000111: alu_op = alu_and  ; // AND (9)
                default: alu_op = alu_add; // Undefined operation (31)
               endcase
               end
        // I-type opcode (for example, 0010011)
       op_i: begin
        reg_wr = 1'b1; // I-type instructions write to register
        select_b=1'b1;  //pick immediate output         //select the immediate output from immediate generator
        rd_en= 1'b0;
        wb_sel=2'b01;
        write_enable=1'b0;
        br_type=2'b00;
        sel_A=1'b0;    
        // Determine ALU operation based on funct3 and funct7      
           case (funct3)
            3'b000: alu_op = alu_add ; // ADDI (0)
            3'b010: alu_op = alu_slt  ; // SLTI (3)
            3'b011: alu_op = alu_sltu; // SLTIU (4)
            3'b100: alu_op = alu_xor ; // XORI (5)
            3'b110: alu_op = alu_or  ; // ORI (8)
            3'b111: alu_op = alu_and ; // ANDI (9)
            3'b001: alu_op = alu_sll ; // SLLI (2)
            3'b101: alu_op = (funct7[5] == 1'b0) ? alu_srl : alu_sra; // SRLI (17) if funct7[5] is 0, SRAI (18) if 1
            default: alu_op = alu_add; // Undefined operation (31)

                     endcase
                     end
       // L-type opcode (for example, 0000011)
        op_l: begin
            reg_wr = 1'b1;
            select_b=1'b1;  //pick immediate output         //select the immediate output from immediate generator
            rd_en= 1'b1;
            wb_sel=2'b00;
            write_enable=1'b0;
            br_type=2'b00;
            sel_A=1'b0;
            // Determine ALU operation based on funct3
            case (funct3)
                3'b000: alu_op = alu_add; // LB (0)
                3'b001: alu_op = alu_add; // LH (0)
                3'b010: alu_op = alu_add; // LW (0)
                3'b100: alu_op = alu_add; // LBU (0)
                3'b101: alu_op = alu_add; // LHU (0)
                default: alu_op = alu_add; // Undefined operation (0)
            endcase
        end
        op_s: begin                     //SW Opcode
            reg_wr=1'b1;
            write_enable=1'b1;
            wb_sel=2'b00;
            rd_en=1'b0;
            select_b=1'b1;
            br_type=2'b00;
            sel_A=1'b0;  
           
            case(funct3)
                3'b010:alu_op=alu_add; //sw(0)
                default: alu_op = alu_add; // Undefined operation (0)

            endcase
            end
                     

              

        op_b: begin //Branch Opcode
            reg_wr=1'b1;
            write_enable=1'b0;
            wb_sel=2'b00;
            rd_en=1'b0;
            br_type=2'b01;
            sel_A=1'b1;
            select_b=1'b1;
            alu_op = alu_add; // Undefined operation (0)
            
            
            end
        op_ui: begin //LUI type Opcode
            reg_wr=1'b1;
            write_enable=1'b0;
            wb_sel=2'b01;
            rd_en=1'b0;
            br_type=2'b00;
            sel_A=1'bx;
            select_b=1'b1;
            alu_op = alu_add;

            //case(funct3)
                //  3'b010:alu_op=4'b0000; //sw(0)
            //alu_op = 4'b1111; // Undefined operation (0)
            ///endcase
            end
            op_a: begin  //AUIPC type Opcode
            reg_wr=1'b1;
            write_enable=1'b0;
            wb_sel=2'b01;
            rd_en=1'b0;
            br_type=2'b00;
            sel_A=1'b1;
            alu_op = alu_add;
            select_b=1'b1;
            end
            
            op_j: begin   //Jal type
            reg_wr=1'b1;
            write_enable=1'b0;
            wb_sel=2'b10;
            rd_en=1'b0;
            br_type=2'b10;
            sel_A=1'b1;
            alu_op = alu_add;
            select_b=1'b1;

            end

            op_jr: begin   //Jalr type
            reg_wr=1'b1;
            write_enable=1'b0;
            wb_sel=2'b10;
            rd_en=1'b0;
            br_type=2'b10;
            sel_A=1'b0;  // 0 because i am selecting rs1 ( PC=rs1+imm)
            alu_op = alu_add;
            select_b=1'b1;

            end


            //case(funct3)
                //  3'b010:alu_op=4'b0000; //sw(0)
            //alu_op = 4'b1111; // Undefined operation (0)
            //endcase
            
endcase
end
                
endmodule
