
-- VHDL Instantiation Created from source file OutputReg.vhd -- 16:33:52 05/20/2017
--
-- Notes: 
-- 1) This instantiation template has been automatically generated using types
-- std_logic and std_logic_vector for the ports of the instantiated module
-- 2) To use this template to instantiate this entity, cut-and-paste and then edit

	COMPONENT OutputReg
	PORT(
		clk : IN std_logic;
		data_in : IN std_logic_vector(15 downto 0);
		WE : IN std_logic;          
		data_out : OUT std_logic_vector(15 downto 0)
		);
	END COMPONENT;

	Inst_OutputReg: OutputReg PORT MAP(
		clk => ,
		data_in => ,
		WE => ,
		data_out => 
	);


