
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- ====
-- Processor
-- Top level schematic that connects all of the main blocks of the 
-- CPU together.
-- ====

entity Processor is
    Port ( 
		clk : in  STD_LOGIC;
		en : in STD_LOGIC;
		rst : in  STD_LOGIC;
		
		start : in  STD_LOGIC;
		data_out : out  STD_LOGIC_VECTOR (15 downto 0)
	);
end Processor;



architecture Behavioral of Processor is

	--signal data_in : STD_LOGIC_VECTOR(15 downto 0);
	signal mWE : STD_LOGIC;
	signal oWE : STD_LOGIC;
	signal mDAddress : STD_LOGIC_VECTOR(6 downto 0);
	signal DPD_out : STD_LOGIC_VECTOR(31 downto 0);
	signal DPD_in : STD_LOGIC_VECTOR(31 downto 0);
	signal I_addr : STD_LOGIC_VECTOR(6 downto 0);
	signal I_out : STD_LOGIC_VECTOR(31 downto 0);
	signal oD_out : STD_LOGIC_VECTOR(15 downto 0);
	signal Instr_Addr : STD_LOGIC_VECTOR(7 downto 0);



	signal D_addr : STD_LOGIC_VECTOR(6 downto 0);

	signal Flags : STD_LOGIC_VECTOR(7 downto 0);
	signal PC : STD_LOGIC_VECTOR(7 downto 0);
	signal S : STD_LOGIC_VECTOR (4 downto 1);
	signal RA : STD_LOGIC_VECTOR (4 downto 0);
	signal RB : STD_LOGIC_VECTOR (4 downto 0);
	signal WA : STD_LOGIC_VECTOR (4 downto 0);
	signal MA : STD_LOGIC_VECTOR (15 downto 0);
	signal IMM : STD_LOGIC_VECTOR (15 downto 0);
	signal AL : STD_LOGIC_VECTOR (3 downto 0);
	signal SH : STD_LOGIC_VECTOR (3 downto 0);

	signal OEN : STD_LOGIC;
	signal WEN : STD_LOGIC;


	signal MDA : STD_LOGIC_VECTOR (15 downto 0);
	signal M_in : STD_LOGIC_VECTOR (15 downto 0);
	signal M_out : STD_LOGIC_VECTOR (15 downto 0);

	signal PC_PLUS_16 : STD_LOGIC_VECTOR(15 downto 0) := (others => '0' );
	signal PC_16 : STD_LOGIC_VECTOR(15 downto 0) := (others => '0' );
	signal PC_PLUS : STD_LOGIC_VECTOR(7 downto 0);

begin

	Inst_OutputReg: entity work.OutputReg PORT MAP(
		clk => clk,
		data_in => oD_out,
		WE => oWE,
		data_out => data_out
	);
	
	--DUAL PORT MEMORY
	Inst_DualPortMemory: entity work.DualPortMemory PORT MAP(
		clk => clk,
		I_addr => I_addr,
		D_addr => mDAddress,
		D_in => DPD_in,
		WE => mWE,
		D_out => DPD_out,
		I_out => I_out
	);
	
	-- MMU
	Inst_MMU: entity work.MMU PORT MAP(
		I_addr => Instr_addr,
		OEn => OEN,
		D_in => M_out,
		D_out => M_in,
		D_addr => MDA,
		start => start,
		oWE => oWE,
		oD_out => oD_out,
		mWE => mWE,
		mD_addr => mDAddress,
		mD_in => DPD_out,
		mD_out => DPD_in,
		mI_addr => I_addr
	);

	Inst_DataPath_C: entity work.DataPath_C PORT MAP(
		clk => clk,
		rst => rst,
		en => en,
		R_A => RA,
		R_B => RB,
		W_EN => WEN,
		W_A => WA,
		IMM => IMM,
		M_A => MA,
		M_in => M_in,
		PC => PC_16,
		S => S,
		AL => AL,
		SH => SH,
		PC_plus => PC_Plus_16,
		Flags => Flags,
		M_DA => MDA,
		M_out => M_out
	);
	PC_16(7 downto 0) <= PC;
	PC_Plus <= PC_Plus_16(7 downto 0);
	
	Inst_ControlUnit: entity work.ControlUnit PORT MAP(
		clk => clk,
		rst => rst,
		en => en,
		PC_Plus => PC_Plus,
		instr => I_out,
		Flags => Flags,
		Instr_addr => Instr_addr,
		PC => PC,
		S => S,
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

