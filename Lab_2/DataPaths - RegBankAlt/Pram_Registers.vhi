
-- VHDL Instantiation Created from source file Pram_Registers.vhd -- 13:39:33 03/03/2017
--
-- Notes: 
-- 1) This instantiation template has been automatically generated using types
-- std_logic and std_logic_vector for the ports of the instantiated module
-- 2) To use this template to instantiate this entity, cut-and-paste and then edit

	COMPONENT Pram_Registers
	PORT(
		addr_A : IN std_logic_vector(66229599 downto 0);
		addr_B : IN std_logic_vector(66229695 downto 0);
		addr_C : IN std_logic_vector(66229791 downto 0);
		data_in : IN std_logic_vector(15 downto 0);
		wr_en : IN std_logic;
		clk : IN std_logic;          
		A_out : OUT std_logic_vector(15 downto 0);
		B_out : OUT std_logic_vector(15 downto 0)
		);
	END COMPONENT;

	Inst_Pram_Registers: Pram_Registers PORT MAP(
		addr_A => ,
		addr_B => ,
		addr_C => ,
		data_in => ,
		wr_en => ,
		clk => ,
		A_out => ,
		B_out => 
	);


