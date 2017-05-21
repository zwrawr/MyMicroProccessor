
-- VHDL Instantiation Created from source file ControlUnit.vhd -- 21:50:27 05/20/2017
--
-- Notes: 
-- 1) This instantiation template has been automatically generated using types
-- std_logic and std_logic_vector for the ports of the instantiated module
-- 2) To use this template to instantiate this entity, cut-and-paste and then edit

	COMPONENT ControlUnit
	PORT(
		clk : IN std_logic;
		rst : IN std_logic;
		PC_Plus : IN std_logic_vector(7 downto 0);
		instr : IN std_logic_vector(31 downto 0);
		Flags : IN std_logic_vector(7 downto 0);          
		Instr_addr : OUT std_logic_vector(7 downto 0);
		PC : OUT std_logic_vector(7 downto 0);
		S : OUT std_logic_vector(4 downto 1);
		RA : OUT std_logic_vector(4 downto 0);
		RB : OUT std_logic_vector(4 downto 0);
		WA : OUT std_logic_vector(4 downto 0);
		MA : OUT std_logic_vector(15 downto 0);
		IMM : OUT std_logic_vector(15 downto 0);
		AL : OUT std_logic_vector(3 downto 0);
		SH : OUT std_logic_vector(3 downto 0);
		WEN : OUT std_logic;
		OEN : OUT std_logic
		);
	END COMPONENT;

	Inst_ControlUnit: ControlUnit PORT MAP(
		clk => ,
		rst => ,
		PC_Plus => ,
		instr => ,
		Flags => ,
		Instr_addr => ,
		PC => ,
		S => ,
		RA => ,
		RB => ,
		WA => ,
		MA => ,
		IMM => ,
		AL => ,
		SH => ,
		WEN => ,
		OEN => 
	);


