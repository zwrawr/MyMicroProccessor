
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- ====
-- Sequencer
-- Decides on what instruction to exicute next.
-- Handels branches and incrimenting the PC
-- ====

entity Sequencer is
	Port ( 
		clk : in  STD_LOGIC; -- clock
		rst : in STD_LOGIC; -- active high sync reset
		en : in STD_LOGIC; -- enable
		STAGE : in STD_LOGIC_VECTOR(8 downto 0); -- stage of exicution flags
		instr : in  STD_LOGIC_VECTOR (31 downto 0); -- instruction
		PC_plus : in  STD_LOGIC_VECTOR (7 downto 0); -- PC + offset
		flags : in  STD_LOGIC_VECTOR (7 downto 0); -- flags
		PC : out  STD_LOGIC_VECTOR (7 downto 0); -- program counter
		MIA : out  STD_LOGIC_VECTOR (7 downto 0) -- memory address of instruction
	);
end Sequencer;

architecture Behavioral of Sequencer is
	signal PC_internal : STD_LOGIC_VECTOR (7 downto 0) := (others => '0'); -- current internal PC state
	signal PC_next : STD_LOGIC_VECTOR (7 downto 0); -- the next PC state
		
	signal cond_met : STD_LOGIC; -- whether the branching condition has been met
	
	signal opcode : STD_LOGIC_VECTOR(5 downto 0); -- the opcode part of the instruction
	signal cond : STD_LOGIC_VECTOR(2 downto 0); -- the condition part of the opcode
	
	signal cond_met_i : STD_LOGIC;
begin

	-- assign opcode and cond from the instruction
	opcode <= instr(31 downto 26);
	cond <= opcode(2 downto 0);

	-- Calculate weather the condition to branch has been met
	cond_met <=
		'1' when cond = "000" and flags(0) = '1' and STAGE(8) = '1' else  -- ra = 0
		'1' when cond = "001" and flags(1) = '1' and STAGE(8) = '1' else  -- ra != 0
		'1' when cond = "010" and flags(2) = '1' and STAGE(8) = '1' else  -- ra = 1
		'1' when cond = "011" and flags(4) = '1' and STAGE(8) = '1' else  -- ra < 0
		'1' when cond = "100" and flags(3) = '1' and STAGE(8) = '1' else  -- ra > 0
		'1' when cond = "101" and flags(6) = '1' and STAGE(8) = '1' else  -- ra <= 0
		'1' when cond = "110" and flags(5) = '1' and STAGE(8) = '1' else  -- ra >= 0
		'1' when cond = "111" else -- jump
		'0';
	
	-- map internal signals to outputs
	PC <= PC_internal;
	MIA <= PC_internal;

    -- The Instruction register update process
	register_proc : process(clk, rst, en, STAGE, cond_met, opcode) is
	begin
		if rising_edge(clk) then
			if rst = '1' then
				PC_internal <= (others => '0');
			elsif en = '1' and STAGE(0) = '1' then
				if opcode(5 downto 4) = "11" and cond_met_i = '1' then
					PC_internal <= PC_next;
				else
					PC_internal <= std_logic_vector(unsigned(PC_internal) + 1);
				end if;
			end if;
		end if;
	end process;
	
	-- Add a register for PC_PLUS so we can keep the value until after
	-- the condition is evaluated.
	stick_proc : process(clk, PC_plus, STAGE) is
	begin
		if rising_edge(clk) and STAGE(8) = '1' then
			PC_next <= PC_plus;
		end if;
	end process;

	-- Add a register for cond met so we can keep the value until we need
	-- to branch.
	met_proc : process(clk, cond_met, STAGE) is
	begin
		if rising_edge(clk) and STAGE(8) = '1' then
			cond_met_i <= cond_met;
		end if;
	end process;
	
end Behavioral;

