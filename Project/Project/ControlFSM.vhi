
-- VHDL Instantiation Created from source file ControlFSM.vhd -- 16:02:41 05/20/2017
--
-- Notes: 
-- 1) This instantiation template has been automatically generated using types
-- std_logic and std_logic_vector for the ports of the instantiated module
-- 2) To use this template to instantiate this entity, cut-and-paste and then edit

	COMPONENT ControlFSM
	PORT(
		clk : IN std_logic;
		rst : IN std_logic;
		opcode : IN std_logic_vector(5 downto 0);          
		S : OUT std_logic_vector(3 downto 0)
		);
	END COMPONENT;

	Inst_ControlFSM: ControlFSM PORT MAP(
		clk => ,
		rst => ,
		opcode => ,
		S => 
	);


