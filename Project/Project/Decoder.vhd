----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:58:01 05/18/2017 
-- Design Name: 
-- Module Name:    Decoder_Block - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Decoder_Block is
    Port ( instr : in  STD_LOGIC_VECTOR (31 downto 0);
	
		   OPCODE : out STD_LOGIC_VECTOR(5 downto 0);

           RA : out  STD_LOGIC_VECTOR (4 downto 0);
           RB : out  STD_LOGIC_VECTOR (4 downto 0);
           WA : out  STD_LOGIC_VECTOR (4 downto 0);
		   
           MA : out  STD_LOGIC_VECTOR (15 downto 0);
           IMM : out  STD_LOGIC_VECTOR (15 downto 0);
		   
           AL : out  STD_LOGIC_VECTOR (3 downto 0);
           SH : out  STD_LOGIC_VECTOR (3 downto 0);
		   
           WEN : out  STD_LOGIC;
		   OEN : out  STD_LOGIC
	);

end Decoder_Block;

architecture Behavioral of Decoder_Block is
	signal OPCODE_int : STD_LOGIC_VECTOR(5 downto 0);

	signal IMM_internal : STD_LOGIC_VECTOR(15 downto 0);
	
	signal InstrInternal1 : std_logic_vector(IMM_internal'range) := (others => '0');
	signal InstrInternal2 : std_logic_vector(IMM_internal'range) := (others => '0');
begin

	OPCODE_int <= instr(31 downto 26);
	OPCODE <= OPCODE_int;
		
	RA <= instr(9 downto 5);
	WA <= instr(4 downto 0);
	RB <=
		instr(20 downto 16) when OPCODE_int(5 downto 4) = "00" else
		instr(4 downto 0);
	
	InstrInternal1(9 downto 0) <= instr(19 downto 10);
	InstrInternal2(8 downto 0) <= instr(24 downto 16);

	IMM_internal <= 
		InstrInternal1 when OPCODE_int(5 downto 4) = "10" and  OPCODE_int(1 downto 0) = "11" else
		InstrInternal2 when OPCODE_int(5 downto 4) = "11" else
		instr(25 downto 10); 
	
	IMM <= IMM_internal;
	MA <= IMM_internal;

	AL <=
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
	
	SH <= instr(19 downto 16);
	
	OEN <= 
		'1' when OPCODE_int(5 downto 2) = "1001" else
		'0';
		
	WEN <= 
		'0' when OPCODE_int(5 downto 0) = "000000" else
		'0' when OPCODE_int(5 downto 2) = "1001" else
		'0' when OPCODE_int(5 downto 4) ="11" else
		'1';
	
end Behavioral;

