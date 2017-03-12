
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.DigEng.All;

entity DataPath_D is
	Generic(
		data_size : natural := 16;
		num_registers : natural := 5
	);
	Port ( 
		clk : in  STD_LOGIC;
		rst : in STD_LOGIC;
		en : in STD_LOGIC;
		
		R_A : in  STD_LOGIC_VECTOR (log2(num_registers)-1 downto 0);
		R_B : in  STD_LOGIC_VECTOR (log2(num_registers)-1 downto 0);
		W_EN : in  STD_LOGIC;
		W_A : in  STD_LOGIC_VECTOR (log2(num_registers)-1 downto 0);
		IMM : in  STD_LOGIC_VECTOR (data_size-1 downto 0);
		M_A : in  STD_LOGIC_VECTOR (data_size-1 downto 0);
		M_in : in  STD_LOGIC_VECTOR (data_size-1 downto 0);
		SEL : in  STD_LOGIC_VECTOR (7 downto 0);
		AL : in  STD_LOGIC_VECTOR (3 downto 0);
		SH : in  STD_LOGIC_VECTOR (log2(data_size)-1 downto 0);
		
		Flags : out  STD_LOGIC_VECTOR (7 downto 0);
		M_DA : out  STD_LOGIC_VECTOR (data_size-1 downto 0);
		M_out : out  STD_LOGIC_VECTOR (data_size-1 downto 0)
	);
end DataPath_D;

architecture Behavioral of DataPath_D is

	-- Data to write to the registers
	signal reg_in : STD_LOGIC_VECTOR (data_size-1 downto 0);
	
	-- Outputs of the registers
	signal A_data : STD_LOGIC_VECTOR (data_size-1 downto 0);
	signal B_data : STD_LOGIC_VECTOR (data_size-1 downto 0);
	
	-- The two multiplexers for A and B
	signal A_mux : STD_LOGIC_VECTOR (data_size-1 downto 0);
	signal B_mux : STD_LOGIC_VECTOR (data_size-1 downto 0);
	
	-- Output of the register on the A and B buses
	signal A_reg_out : STD_LOGIC_VECTOR (data_size-1 downto 0);
	signal B_reg_out : STD_LOGIC_VECTOR (data_size-1 downto 0);
	
	-- The inputs to the ALU
	signal A_ALU : STD_LOGIC_VECTOR (data_size-1 downto 0);
	signal B_ALU : STD_LOGIC_VECTOR (data_size-1 downto 0);
	
	-- The output of the combined ALU and shifter
	signal ALU_out : STD_LOGIC_VECTOR (data_size-1 downto 0);
	signal ALU_reg_out : STD_LOGIC_VECTOR (data_size-1 downto 0);

	-- The ALU output after it passes through a second register
	signal ALU_reg_out_reg_out : STD_LOGIC_VECTOR (data_size-1 downto 0);

	-- Signals for memory registers
	signal M_in_reg_out : STD_LOGIC_VECTOR (data_size-1 downto 0);

begin

	-- The two multiplexers for A and B
	A_mux <= A_reg_out when SEL(7) = '0' else reg_in;
	B_mux <= B_reg_out when SEL(6) = '0' else reg_in;


	-- The multiplexers on the input of the ALU
	A_ALU <=
		ALU_reg_out 	when SEL(3 downto 2) = "11" else
		(others => 'U') when SEL(3 downto 2) = "10" else
		A_reg_out 		when SEL(3 downto 2) = "01" else
		reg_in 			when SEL(3 downto 2) = "01" else
		(others => 'U');
	B_ALU <=
		reg_in 			when SEL(1 downto 0) = "11" else
		IMM 			when SEL(1 downto 0) = "10" else
		B_reg_out 		when SEL(1 downto 0) = "01" else
		reg_in 			when SEL(1 downto 0) = "01" else
		(others => 'U');
	
	
	-- The address multiplexer for the memory
	M_DA <= M_A when SEL(4) = '1' else ALU_reg_out;
		
	-- The register write multiplexer
	reg_in <= ALU_reg_out_reg_out when SEL(5) = '1' else M_in_reg_out;

	-- The register on the A bus
	A_reg: entity work.Reg Generic Map (data_size => data_size)
	PORT MAP(
		clk => clk,
		rst => rst,
		en => en,
		data_in => A_mux,
		data_out => A_reg_out
	);
	
	-- The register on the B bus
	B_reg: entity work.Reg Generic Map (data_size => data_size)
	PORT MAP(
		clk => clk,
		rst => rst,
		en => en,
		data_in => B_mux,
		data_out => B_reg_out
	);
	
	-- The Register on the out put of the ALU
	ALU_reg: entity work.Reg Generic Map (data_size => data_size)
	PORT MAP(
		clk => clk,
		rst => rst,
		en => en,		
		data_in => ALU_out,
		data_out => ALU_reg_out
	);
	
	-- The register on the memory read bus
	M_in_reg: entity work.Reg Generic Map (data_size => data_size)
	PORT MAP(
		clk => clk,
		rst => rst,
		en => en,		data_in => M_in,
		data_out => M_in_reg_out
	);
	
	-- The second register on the ALU out
	ALU_reg_out_reg: entity work.Reg Generic Map (data_size => data_size)
	PORT MAP(
		clk => clk,
		rst => rst,
		en => en,		
		data_in => ALU_reg_out,
		data_out => ALU_reg_out_reg_out
	);
	
	-- The register on the memory read bus
	M_out_reg: entity work.Reg Generic Map (data_size => data_size)
	PORT MAP(
		clk => clk,
		rst => rst,
		en => en,
		data_in => B_reg_out,
		data_out => M_out
	);

	-- The ALU and shifter from Lab 1
	ALU: entity work.ALU_param GENERIC MAP( N => data_size )
	PORT MAP(
		A => A_ALU,
		B => B_ALU,
		X => SH,
		ctrl => AL,
		O => ALU_out,
		flags => flags
	);
	
	-- The register array from Lab_1
	Registers: entity work.regbank 
	PORT MAP(
		RSELA => R_A,
		RSELB => R_B,
		WSEL => W_A,
		D => reg_in,
		WEN => W_EN,
		clk => clk,
		A => A_data,
		B => B_data,
		rst => '0'
	);

end Behavioral;

