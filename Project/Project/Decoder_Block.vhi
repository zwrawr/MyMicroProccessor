
-- VHDL Instantiation Created from source file Decoder_Block.vhd -- 16:18:16 05/20/2017
--
-- Notes: 
-- 1) This instantiation template has been automatically generated using types
-- std_logic and std_logic_vector for the ports of the instantiated module
-- 2) To use this template to instantiate this entity, cut-and-paste and then edit

	COMPONENT Decoder_Block
	PORT(
		instr : IN std_logic_vector(31 downto 0);          
		OPCODE : OUT std_logic_vector(5 downto 0);
		RA : OUT std_logic_vector(4 downto 0);
		RB : OUT std_logic_vector(4 downto 0);
		WA : OUT std_logic_vector(4 downto 0);
		MA : OUT std_logic_vector(15 downto 0);
		IMM : OUT std_logic_vector(15 downto 0);
		AL : OUT std_logic_vector(3 downto 0);
		SH : OUT std_logic_vector(3 downto 0);
		WEN : OUT std_logic;
		OEN : OUT std_logic
		);
	END COMPONENT;

	Inst_Decoder_Block: Decoder_Block PORT MAP(
		instr => ,
		OPCODE => ,
		RA => ,
		RB => ,
		WA => ,
		MA => ,
		IMM => ,
		AL => ,
		SH => ,
		WEN => ,
		OEN => 
	);


