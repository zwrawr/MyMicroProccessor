
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ControlUnit is
    Port ( 
	
		   clk : in std_logic;
		   rst : in std_logic;
		   en : in STD_LOGIC;
		   
		   PC_Plus : in  STD_LOGIC_VECTOR(7 downto 0);
           instr : in  STD_LOGIC_VECTOR (31 downto 0);
		   Flags : in STD_LOGIC_VECTOR(7 downto 0);
           Instr_addr : out  STD_LOGIC_VECTOR (7 downto 0);
           PC : out  STD_LOGIC_VECTOR(7 downto 0);
		   
		   S : out  STD_LOGIC_VECTOR (4 downto 1);

		   RA : out  STD_LOGIC_VECTOR (4 downto 0);
           RB : out  STD_LOGIC_VECTOR (4 downto 0);
           WA : out  STD_LOGIC_VECTOR (4 downto 0);
		   
           MA : out  STD_LOGIC_VECTOR (15 downto 0);
           IMM : out  STD_LOGIC_VECTOR (15 downto 0);
		   
           AL : out  STD_LOGIC_VECTOR (3 downto 0);
           SH : out  STD_LOGIC_VECTOR (3 downto 0);
		   
           WEN : out  STD_LOGIC;
		   OEN : out  STD_LOGIC
		 );
end ControlUnit;

architecture Behavioral of ControlUnit is

	signal OPCODE : STD_LOGIC_VECTOR (5 downto 0);
	signal FETCH : STD_LOGIC;

begin

	Inst_ControlFSM: entity work.ControlFSM PORT MAP(
		clk => clk ,
		rst => rst,
		opcode => OPCODE ,
		S => S,
		FETCH => FETCH
	);
	
	Inst_Sequencer: entity work.Sequencer PORT MAP(
		clk => clk ,
		rst => rst,
		en => en,
		FETCH => FETCH,
		instr => instr ,
		PC_plus => PC_Plus,
		flags => Flags,
		PC => PC,
		MIA => Instr_addr 
	);
	
	Inst_Decoder_Block: entity work.Decoder_Block PORT MAP(
		instr => instr,
		OPCODE => OPCODE,
		RA => RA,
		RB => RB,
		WA => WA,
		MA => MA,
		IMM => IMM,
		AL => AL,
		SH => SH,
		WEN => WEN,
		OEN => OEN
	);


end Behavioral;

