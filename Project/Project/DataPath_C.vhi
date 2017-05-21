
-- VHDL Instantiation Created from source file DataPath_C.vhd -- 15:56:43 05/20/2017
--
-- Notes: 
-- 1) This instantiation template has been automatically generated using types
-- std_logic and std_logic_vector for the ports of the instantiated module
-- 2) To use this template to instantiate this entity, cut-and-paste and then edit

	COMPONENT DataPath_C
	PORT(
		clk : IN std_logic;
		rst : IN std_logic;
		en : IN std_logic;
		R_A : IN std_logic_vector(66309919 downto 0);
		R_B : IN std_logic_vector(66310015 downto 0);
		W_EN : IN std_logic;
		W_A : IN std_logic_vector(66310207 downto 0);
		IMM : IN std_logic_vector(15 downto 0);
		M_A : IN std_logic_vector(15 downto 0);
		M_in : IN std_logic_vector(15 downto 0);
		PC : IN std_logic_vector(15 downto 0);
		S : IN std_logic_vector(4 downto 1);
		AL : IN std_logic_vector(3 downto 0);
		SH : IN std_logic_vector(66310879 downto 0);          
		PC_plus : OUT std_logic_vector(15 downto 0);
		Flags : OUT std_logic_vector(7 downto 0);
		M_DA : OUT std_logic_vector(15 downto 0);
		M_out : OUT std_logic_vector(15 downto 0)
		);
	END COMPONENT;

	Inst_DataPath_C: DataPath_C PORT MAP(
		clk => ,
		rst => ,
		en => ,
		R_A => ,
		R_B => ,
		W_EN => ,
		W_A => ,
		IMM => ,
		M_A => ,
		M_in => ,
		PC => ,
		S => ,
		AL => ,
		SH => ,
		PC_plus => ,
		Flags => ,
		M_DA => ,
		M_out => 
	);


