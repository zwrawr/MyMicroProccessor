
-- VHDL Instantiation Created from source file ALU_param.vhd -- 13:37:59 03/03/2017
--
-- Notes: 
-- 1) This instantiation template has been automatically generated using types
-- std_logic and std_logic_vector for the ports of the instantiated module
-- 2) To use this template to instantiate this entity, cut-and-paste and then edit

	COMPONENT ALU_param
	PORT(
		A : IN std_logic_vector(7 downto 0);
		B : IN std_logic_vector(7 downto 0);
		X : IN std_logic_vector(66422079 downto 0);
		ctrl : IN std_logic_vector(3 downto 0);          
		O : OUT std_logic_vector(7 downto 0);
		flags : OUT std_logic_vector(7 downto 0)
		);
	END COMPONENT;

	Inst_ALU_param: ALU_param PORT MAP(
		A => ,
		B => ,
		X => ,
		ctrl => ,
		O => ,
		flags => 
	);


