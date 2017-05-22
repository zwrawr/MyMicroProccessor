library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- ====
-- ControlUnit
-- The main control unit for the processor.
-- Contains the decode, instruction register, sequencer and FSM.
-- ====

entity ControlUnit is
    Port ( 
	
		   clk : in std_logic; -- clock
		   rst : in std_logic; --  sync active high reset
		   en : in STD_LOGIC; -- active high enable
		   
		   PC_Plus : in  STD_LOGIC_VECTOR(7 downto 0); -- the PC plus offset
           instr : in  STD_LOGIC_VECTOR (31 downto 0); -- the current instruction
		   Flags : in STD_LOGIC_VECTOR(7 downto 0); --  the flags from the ALU


           Instr_addr : out  STD_LOGIC_VECTOR (7 downto 0); -- The address of the next instruction
           PC : out  STD_LOGIC_VECTOR(7 downto 0); -- The program counter
		   
		   S : out  STD_LOGIC_VECTOR (4 downto 1); -- Selects for the ALU multiplexers

		   RA : out  STD_LOGIC_VECTOR (4 downto 0); -- Index of working register A
           RB : out  STD_LOGIC_VECTOR (4 downto 0); -- Index of working register B
           WA : out  STD_LOGIC_VECTOR (4 downto 0); -- Index of working register to be written to (Rt)
		   
           MA : out  STD_LOGIC_VECTOR (15 downto 0); -- Memory address from instruction
           IMM : out  STD_LOGIC_VECTOR (15 downto 0); -- Intermediate value from instruction
		   
           AL : out  STD_LOGIC_VECTOR (3 downto 0); -- The ALU control code
           SH : out  STD_LOGIC_VECTOR (3 downto 0); -- The amount of bits to shift by
		   
           WEN : out  STD_LOGIC; -- Write enable for the registers
		   OEN : out  STD_LOGIC --  Write enable for the memory
		 );
end ControlUnit;

architecture Behavioral of ControlUnit is

	signal OPCODE : STD_LOGIC_VECTOR (5 downto 0);
	
	signal STAGE : STD_LOGIC_VECTOR (8 downto 0);
begin

	-- The control FSM
	Inst_ControlFSM: entity work.ControlFSM PORT MAP(
		clk => clk ,
		rst => rst,
		opcode => OPCODE ,
		S => S,
		STAGE => STAGE
	);
	
	-- The PC sequencer
	Inst_Sequencer: entity work.Sequencer PORT MAP(
		clk => clk ,
		rst => rst,
		en => en,
		STAGE => STAGE,
		instr => instr ,
		PC_plus => PC_Plus,
		flags => Flags,
		PC => PC,
		MIA => Instr_addr 
	);
	
	-- The combonational decoder
	Inst_Decoder_Block: entity work.Decoder_Block PORT MAP(
		instr => instr,
		STAGE => STAGE,
		OPCODE => OPCODE,
		RA => RA,
		RB => RB,
		WA => WA,
		MA => MA,
		IMM => IMM,
		AL => AL,
		SH => SH,
		WEN => WEN,
		OEN => OEN
	);


end Behavioral;

