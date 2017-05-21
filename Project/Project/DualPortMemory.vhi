
-- VHDL Instantiation Created from source file DualPortMemory.vhd -- 16:33:33 05/20/2017
--
-- Notes: 
-- 1) This instantiation template has been automatically generated using types
-- std_logic and std_logic_vector for the ports of the instantiated module
-- 2) To use this template to instantiate this entity, cut-and-paste and then edit

	COMPONENT DualPortMemory
	PORT(
		clk : IN std_logic;
		I_addr : IN std_logic_vector(6 downto 0);
		D_addr : IN std_logic_vector(6 downto 0);
		D_in : IN std_logic_vector(31 downto 0);
		WE : IN std_logic;          
		D_out : OUT std_logic_vector(31 downto 0);
		I_out : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

	Inst_DualPortMemory: DualPortMemory PORT MAP(
		clk => ,
		I_addr => ,
		D_addr => ,
		D_in => ,
		WE => ,
		D_out => ,
		I_out => 
	);


