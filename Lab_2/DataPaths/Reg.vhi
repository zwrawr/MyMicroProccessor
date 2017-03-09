
-- VHDL Instantiation Created from source file Reg.vhd -- 15:07:00 03/09/2017
--
-- Notes: 
-- 1) This instantiation template has been automatically generated using types
-- std_logic and std_logic_vector for the ports of the instantiated module
-- 2) To use this template to instantiate this entity, cut-and-paste and then edit

	COMPONENT Reg
	PORT(
		clk : IN std_logic;
		data_in : IN std_logic_vector(7 downto 0);          
		data_out : OUT std_logic_vector(7 downto 0)
		);
	END COMPONENT;

	Inst_Reg: Reg PORT MAP(
		clk => ,
		data_in => ,
		data_out => 
	);


