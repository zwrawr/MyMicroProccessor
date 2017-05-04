
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity Sequencer is
	Port ( 
		clk : in  STD_LOGIC;
		instr : in  STD_LOGIC_VECTOR (31 downto 0); -- instruction
		PC_plus : in  STD_LOGIC_VECTOR (7 downto 0); -- PC + offset
		flags : in  STD_LOGIC_VECTOR (7 downto 0); -- flags
		PC : out  STD_LOGIC_VECTOR (7 downto 0);
		MIA : out  STD_LOGIC_VECTOR (7 downto 0)
	);
end Sequencer;

architecture Behavioral of Sequencer is
	signal PC_internal : STD_LOGIC_VECTOR (7 downto 0); -- current internal PC state
	signal PC_next : STD_LOGIC_VECTOR (7 downto 0); -- the next PC state
		
	signal cond_met : STD_LOGIC; -- weather the branching condition has been met
	
	signal opcode : STD_LOGIC_VECTOR(5 downto 0); -- the opcode part of the instruction
	signal offset : STD_LOGIC_VECTOR(8 downto 0); -- the opcode part of the instruction
	signal cond : STD_LOGIC_VECTOR(2 downto 0); -- the condition part of the opcode
begin

	opcode <= instr(31 downto 26);
	offset <= instr(24 downto 16);
	cond <= opcode(2 downto 0);

	cond_met <=
		'1' when cond = "000" and flags(0) = '1' else -- ra = 0
		'1' when cond = "001" and flags(1) = '1' else  -- ra != 0
		'1' when cond = "010" and flags(2) = '1' else  -- ra = 1
		'1' when cond = "011" and flags(4) = '1' else  -- ra < 0
		'1' when cond = "100" and flags(3) = '1' else  -- ra > 0
		'1' when cond = "101" and flags(6) = '1' else  -- ra <= 0
		'1' when cond = "110" and flags(5) = '1' else  -- ra >= 0
		'1' when cond = "111" else  -- jump
		'0';

	PC <= PC_internal;
	MIA <= PC_internal;

	PC_next <=
		-- if its a branch instruction and the condition is met then do PC_plus
		PC_plus when opcode(5 downto 4) = "11" and cond_met = '1' else 
		-- else incriment the value
		std_logic_vector(unsigned(PC_internal) + 1);

    -- The Instruction register update process
	register_proc : process(clk) is
	begin
		if rising_edge(clk) then
			PC_internal <= PC_next;
		end if;
	end process;

end Behavioral;

