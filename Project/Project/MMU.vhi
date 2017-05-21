
-- VHDL Instantiation Created from source file MMU.vhd -- 15:54:13 05/20/2017
--
-- Notes: 
-- 1) This instantiation template has been automatically generated using types
-- std_logic and std_logic_vector for the ports of the instantiated module
-- 2) To use this template to instantiate this entity, cut-and-paste and then edit

	COMPONENT MMU
	PORT(
		clk : IN std_logic;
		I_addr : IN std_logic_vector(7 downto 0);
		OEn : IN std_logic;
		D_in : IN std_logic_vector(15 downto 0);
		D_addr : IN std_logic_vector(15 downto 0);
		start : IN std_logic;
		mD_in : IN std_logic_vector(31 downto 0);          
		D_out : OUT std_logic_vector(15 downto 0);
		oWE : OUT std_logic;
		oD_out : OUT std_logic_vector(15 downto 0);
		mWE : OUT std_logic;
		mD_addr : OUT std_logic_vector(6 downto 0);
		mD_out : OUT std_logic_vector(31 downto 0);
		mI_addr : OUT std_logic_vector(6 downto 0)
		);
	END COMPONENT;

	Inst_MMU: MMU PORT MAP(
		clk => ,
		I_addr => ,
		OEn => ,
		D_in => ,
		D_out => ,
		D_addr => ,
		start => ,
		oWE => ,
		oD_out => ,
		mWE => ,
		mD_addr => ,
		mD_in => ,
		mD_out => ,
		mI_addr => 
	);


