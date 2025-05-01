import assembler
import pips

# The instruction decorator tells the assembler to create a new syntax rule for add instructions.
# The "#" spots indicate operands, which are passed in as parameters to the function below.
# The second parameter indicates the number of instructions this rule will create (1 in this case)
@assembler.instruction('add #, #, #', 1)
def add_instr(dest, operand1, operand2):
  return pips.rformat(opcode='add', r0=dest, r1=operand1, r2=operand2)

# Encode an addi instruction
@assembler.instruction('addi #, #, #', 1)
def addi_instr(dest, op1, immediate):
  return pips.iformat(opcode='add', r0=dest, r1=op1, imm=immediate)
  
# Encode the li pseudoinstruction using an addition to zero
@assembler.instruction('li #, #', 1)
def li_instr(dest, immediate):
  return addi_instr(dest, '$zero', immediate)

# Encode the sub instruction
@assembler.instruction('sub #, #, #', 1)
def sub_instr(dest, operand1, operand2):
  return pips.rformat(opcode='sub', r0=dest, r1=operand1, r2=operand2)

# Encode the subi instruction
@assembler.instruction('subi #, #, #', 1)
def subi_instr(dest, op1, immediate):
  return pips.iformat(opcode='sub', r0=dest, r1=op1, imm=immediate)

# Encode the and instruction
@assembler.instruction('and #, #, #', 1)
def and_instr(dest, operand1, operand2):
  return pips.rformat(opcode='and', r0=dest, r1=operand1, r2=operand2)

# Encode the andi instruction
@assembler.instruction('andi #, #, #', 1)
def andi_instr(dest, op1, immediate):
  return pips.iformat(opcode='and', r0=dest, r1=op1, imm=immediate)

# Encode the or instruction
@assembler.instruction('or #, #, #', 1)
def or_instr(dest, operand1, operand2):
  return pips.rformat(opcode='or', r0=dest, r1=operand1, r2=operand2)

# Encode the ori instruction
@assembler.instruction('ori #, #, #', 1)
def ori_instr(dest, op1, immediate):
  return pips.iformat(opcode='or', r0=dest, r1=op1, imm=immediate)

# Encode the nand instruction
@assembler.instruction('nand #, #, #', 1)
def nand_instr(dest, operand1, operand2):
  return pips.rformat(opcode='nand', r0=dest, r1=operand1, r2=operand2)

# Encode the andi instruction
@assembler.instruction('nandi #, #, #', 1)
def nandi_instr(dest, op1, immediate):
  return pips.iformat(opcode='nand', r0=dest, r1=op1, imm=immediate)

# Encode the nor instruction
@assembler.instruction('nor #, #, #', 1)
def nor_instr(dest, operand1, operand2):
  return pips.rformat(opcode='nor', r0=dest, r1=operand1, r2=operand2)

# Encode the nori instruction
@assembler.instruction('nori #, #, #', 1)
def nori_instr(dest, op1, immediate):
  return pips.iformat(opcode='nor', r0=dest, r1=op1, imm=immediate)

# Encode the xor instruction
@assembler.instruction('xor #, #, #', 1)
def xor_instr(dest, operand1, operand2):
  return pips.rformat(opcode='xor', r0=dest, r1=operand1, r2=operand2)

# Encode the xori instruction
@assembler.instruction('xori #, #, #', 1)
def xori_instr(dest, op1, immediate):
  return pips.iformat(opcode='xor', r0=dest, r1=op1, imm=immediate)

# Encode the slt instruction
@assembler.instruction('slt #, #, #', 1)
def slt_instr(dest, operand1, operand2):
  return pips.rformat(opcode='slt', r0=dest, r1=operand1, r2=operand2)

# Encode the slti instruction
@assembler.instruction('slti #, #, #', 1)
def slti_instr(dest, op1, immediate):
  return pips.iformat(opcode='slt', r0=dest, r1=op1, imm=immediate)

# Encode the sltu instruction
@assembler.instruction('sltu #, #, #', 1)
def sltu_instr(dest, operand1, operand2):
  return pips.rformat(opcode='sltu', r0=dest, r1=operand1, r2=operand2)

# Encode the sltiu instruction
@assembler.instruction('sltiu #, #, #', 1)
def sltiu_instr(dest, op1, immediate):
  return pips.iformat(opcode='sltu', r0=dest, r1=op1, imm=immediate)

# Encode the nop pseudoinstruction using an addition to zero
@assembler.instruction('nop', 1)
def nop_instr():
  return add_instr('$s0', '$zero', '$s0')

# Encode the jump instruction
@assembler.instruction('j #', 1)
def j_instr(jumpAddress):
  return pips.iformat(opcode='j', r0='$zero', r1='$zero', imm=jumpAddress)

# Encode the jal instruction
@assembler.instruction('jal #', 1)
def jal_instr(jumpAddress):
  return pips.iformat(opcode='j', r0='$ra', r1='$zero', imm=jumpAddress, link=True)

# Encode the jr instruction
@assembler.instruction('jr #', 1)
def jr_instr(jumpAddressReg):
  return pips.rformat(opcode='j', r0='$zero', r1='$zero', r2=jumpAddressReg)

# Encode the beq instruction
@assembler.instruction('beq #, #, #', 1)
def beq_instr(op1, op2, branchAddress):
  return pips.iformat(opcode='beq', r0=op1, r1=op2, imm=branchAddress)

# Encode the bne instruction
@assembler.instruction('bne #, #, #', 1)
def bne_instr(op1, op2, branchAddress):
  return pips.iformat(opcode='bne', r0=op1, r1=op2, imm=branchAddress)

# Encode the 'load byte' instruction
@assembler.instruction('lb #, #(#)', 1)
def lb_instr(loadReg, addressOffset, memAddressReg):
  return pips.iformat(opcode='lb', r0=loadReg, r1=memAddressReg, imm=addressOffset)

# Encode the 'store byte' instruction
@assembler.instruction('sb #, #(#)', 1)
def sb_instr(regStoreToMem, addressOffset, memAddressReg):
  return pips.iformat(opcode='sb', r0=regStoreToMem, r1=memAddressReg, imm=addressOffset)

# Encode the 'load word' instruction
@assembler.instruction('lw #, #(#)', 1)
def lw_instr(loadReg, addressOffset, memAddressReg):
  return pips.iformat(opcode='lw', r0=loadReg, r1=memAddressReg, imm=addressOffset)

# Encode the 'store word' instruction
@assembler.instruction('sw #, #(#)', 1)
def sw_instr(regStoreToMem, addressOffset, memAddressReg):
  return pips.iformat(opcode='sw', r0=regStoreToMem, r1=memAddressReg, imm=addressOffset)  

# Encode the 'shift left logical' instruction
@assembler.instruction('sll #, #, #', 1)
def sll_instr(dest, op1, immediate):
  return pips.rformat(opcode='add', r0=dest, r1='$zero', r2=op1, shift_type=pips.SHIFT_LEFT, shift_amt=immediate)

# Encode the 'shift right logical' instruction
@assembler.instruction('srl #, #, #', 1)
def srl_instr(dest, op1, immediate):
  return pips.rformat(opcode='add', r0=dest, r1='$zero', r2=op1, shift_type=pips.SHIFT_RIGHT_LOGICAL, shift_amt=immediate)

# Encode the 'shift right logical' instruction
@assembler.instruction('sra #, #, #', 1)
def sra_instr(dest, op1, immediate):
  return pips.rformat(opcode='add', r0=dest, r1='$zero', r2=op1, shift_type=pips.SHIFT_RIGHT_ARITHMETIC, shift_amt=immediate)

# Encode the not pseudoinstrution
@assembler.instruction('not #, #', 1)
def not_instr(dest, src):
  return nand_instr(dest, src, src)

@assembler.instruction('push #', 2) # <- notice the 2 here. This tells the assembler that we will emit two instructions for this rule
def push_instr(reg):
  return addi_instr('$sp', '$sp', '-2') + sw_instr(reg, '0', '$sp')

@assembler.instruction('pop #', 2) # <- notice the 2 here. This tells the assembler that we will emit two instructions for this rule
def pop_instr(reg):
  return lw_instr(reg, '0', '$sp') + addi_instr('$sp', '$sp', '2')