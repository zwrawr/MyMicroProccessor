
-- VHDL Instantiation Created from source file Sequencer.vhd -- 16:03:34 05/20/2017
--
-- Notes: 
-- 1) This instantiation template has been automatically generated using types
-- std_logic and std_logic_vector for the ports of the instantiated module
-- 2) To use this template to instantiate this entity, cut-and-paste and then edit

	COMPONENT Sequencer
	PORT(
		clk : IN std_logic;
		rst : IN std_logic;
		instr : IN std_logic_vector(31 downto 0);
		PC_plus : IN std_logic_vector(7 downto 0);
		flags : IN std_logic_vector(6 downto 0);          
		PC : OUT std_logic_vector(7 downto 0);
		MIA : OUT std_logic_vector(7 downto 0)
		);
	END COMPONENT;

	Inst_Sequencer: Sequencer PORT MAP(
		clk => ,
		rst => ,
		instr => ,
		PC_plus => ,
		flags => ,
		PC => ,
		MIA => 
	);


