
-- VHDL Instantiation Created from source file Processor.vhd -- 21:50:31 05/20/2017
--
-- Notes: 
-- 1) This instantiation template has been automatically generated using types
-- std_logic and std_logic_vector for the ports of the instantiated module
-- 2) To use this template to instantiate this entity, cut-and-paste and then edit

	COMPONENT Processor
	PORT(
		clk : IN std_logic;
		en : IN std_logic;
		rst : IN std_logic;
		start : IN std_logic;          
		data_out : OUT std_logic_vector(15 downto 0)
		);
	END COMPONENT;

	Inst_Processor: Processor PORT MAP(
		clk => ,
		en => ,
		rst => ,
		start => ,
		data_out => 
	);


