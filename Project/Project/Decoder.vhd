library IEEE;
USE ieee.numeric_std.ALL;
use IEEE.STD_LOGIC_1164.ALL;

-- ====
-- Decoder
-- Decode from the current instruction to STAGE to the
-- Individual control signals need to drive the datapath.
-- ====

entity Decoder_Block is
    Port ( 
		instr : in  STD_LOGIC_VECTOR (31 downto 0); -- Instruction

		STAGE : in STD_LOGIC_VECTOR(8 downto 0); -- Currennt stage flags
		OPCODE : out STD_LOGIC_VECTOR(5 downto 0); -- Opcode from instruction

		RA : out  STD_LOGIC_VECTOR (4 downto 0); -- Index of working register A
		RB : out  STD_LOGIC_VECTOR (4 downto 0); -- Index of working register B
		WA : out  STD_LOGIC_VECTOR (4 downto 0); -- Index of register to be written to.

		MA : out  STD_LOGIC_VECTOR (15 downto 0); -- Memory address from instruction.
		IMM : out  STD_LOGIC_VECTOR (15 downto 0); -- Intermediate value form instruction

		AL : out  STD_LOGIC_VECTOR (3 downto 0); -- Control code of the ALU
		SH : out  STD_LOGIC_VECTOR (3 downto 0); -- Amount ot shift by

		WEN : out  STD_LOGIC; -- Write enable for the registers
		OEN : out  STD_LOGIC --  Write enable for the memory
	);

end Decoder_Block;

architecture Behavioral of Decoder_Block is
	signal OPCODE_int : STD_LOGIC_VECTOR(5 downto 0);

	signal IMM_internal : STD_LOGIC_VECTOR(15 downto 0);
	
	signal InstrInternal1 : std_logic_vector(IMM_internal'range) := (others => '0');
	signal InstrInternal2 : std_logic_vector(IMM_internal'range) := (others => '0');
begin

	-- grab the opcode part of the instruction
	OPCODE_int <= instr(31 downto 26);

	-- map internal signal to output
	OPCODE <= OPCODE_int;
	 
	-- RA and WA are always in the same place
	-- so they can be assigned with no logic
	RA <= instr(9 downto 5);
	WA <= instr(4 downto 0);
	
	-- RB moves so it needs 
	RB <=
		instr(20 downto 16) when OPCODE_int(5 downto 4) = "00" else
		instr(4 downto 0);
	
	-- The IMM/Offset is the most variable of the data that is encoded into the 
	-- Instructions. it also changes it size. SO it has the most complicated decode
	-- Logic
	InstrInternal1 <= std_logic_vector(resize(signed(instr(19 downto 10)), 16));
	InstrInternal2 <= std_logic_vector(resize(signed(instr(24 downto 16)), 16));

	IMM_internal <= 
		InstrInternal1 when OPCODE_int(5 downto 4) = "10" and  OPCODE_int(1 downto 0) = "11" else
		InstrInternal2 when OPCODE_int(5 downto 4) = "11" else
		instr(25 downto 10); 
	
	-- Map internal signals to the ouputs
	IMM <= IMM_internal;
	MA <= IMM_internal;

	-- The instruction coding given to cannot be directly mapped to the 
	AL <=
	    "1010" when STAGE(1) = '1' else -- calc branch
		"1010" when STAGE(8) = '1' else -- calc branch
		"0100" when OPCODE_int(5 downto 3) = "010" and OPCODE_int(1 downto 0) = "01" else -- A & B
		"0101" when OPCODE_int(5 downto 3) = "010" and OPCODE_int(1 downto 0) = "10" else -- A || B
		"0110" when OPCODE_int(5 downto 3) = "010" and OPCODE_int(1 downto 0) = "11" else -- A xor B
		"0111" when OPCODE_int(5 downto 3) = "010" and OPCODE_int(1 downto 0) = "00" else -- not A
		"1000" when OPCODE_int(5 downto 4) = "00" and  OPCODE_int(3) = '1' and  OPCODE_int(4) = '0' else -- A + 1
		"1001" when OPCODE_int(5 downto 4) = "00" and  OPCODE_int(3) = '1' and  OPCODE_int(4) = '0' else -- A - 1
		"1010" when OPCODE_int(5 downto 4) = "00" and OPCODE_int(2) = '1' and OPCODE_int(0) = '0' else -- A + B
		"1011" when OPCODE_int(5 downto 4) = "00" and OPCODE_int(2) = '1' and OPCODE_int(0) = '1' else -- A - B
		"1100" when OPCODE_int(5 downto 3) = "011" and OPCODE_int(2 downto 0) = "000" else -- A sla X
		"1101" when OPCODE_int(5 downto 3) = "011" and OPCODE_int(2 downto 0) = "001" else -- A sra X
		"1110" when OPCODE_int(5 downto 3) = "011" and OPCODE_int(2 downto 0) = "010" else -- A rotl X
		"1111" when OPCODE_int(5 downto 3) = "011" and OPCODE_int(2 downto 0) = "011" else -- A rotr X
	    "0000"; -- A
	
	-- Get the amount ot shift by.
	SH <= instr(19 downto 16);
	-- OEN is high for any opcode starting with 1001, i.e store instructions
	OEN <= 
		'1' when OPCODE_int(5 downto 2) = "1001" else
		'0';
	
	-- Write enable is high for certian stages of exicution 
	WEN <= 
		'1' when STAGE(3) = '1' else
		'1' when STAGE(7) = '1' else
		'0';
	
end Behavioral;

