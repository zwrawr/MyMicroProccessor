library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.DigEng.ALL;

entity DataPath_C is
	GENERIC(
		data_size : natural := 16; 
		num_registers : natural := 5
	);
	Port ( 
		clk : in  STD_LOGIC;
		rst : in STD_LOGIC;
		en : in STD_LOGIC;
		
		-- Inputs
		R_A : in  STD_LOGIC_VECTOR (log2(num_registers)-1 downto 0);
		R_B : in  STD_LOGIC_VECTOR (log2(num_registers)-1 downto 0);
		W_EN : in  STD_LOGIC;
		W_A : in  STD_LOGIC_VECTOR (log2(num_registers)-1 downto 0);
		
		IMM : in  STD_LOGIC_VECTOR (data_size-1 downto 0);
		M_A : in  STD_LOGIC_VECTOR (data_size-1 downto 0);
		M_in : in  STD_LOGIC_VECTOR (data_size-1 downto 0);
		PC : in  STD_LOGIC_VECTOR (15 downto 0);
		S : in  STD_LOGIC_VECTOR (4 downto 1);
		AL : in  STD_LOGIC_VECTOR (3 downto 0);
		SH : in  STD_LOGIC_VECTOR (log2(data_size)-1  downto 0);
		
		-- Outputs
		PC_plus : out  STD_LOGIC_VECTOR (15 downto 0);
		Flags : out  STD_LOGIC_VECTOR (7 downto 0);
		M_DA : out  STD_LOGIC_VECTOR (data_size-1 downto 0);
		M_out : out  STD_LOGIC_VECTOR (data_size-1 downto 0)
	);
end DataPath_C;

architecture Behavioral of DataPath_C is
	
	-- Data to write to the registers
	signal reg_in : STD_LOGIC_VECTOR (data_size-1 downto 0);
	
	-- Outputs of the registers
	signal A_data : STD_LOGIC_VECTOR (data_size-1 downto 0);
	signal B_data : STD_LOGIC_VECTOR (data_size-1 downto 0);
	
	-- Output of the register on the A and B buses
	signal A_reg_out : STD_LOGIC_VECTOR (data_size-1 downto 0);
	signal B_reg_out : STD_LOGIC_VECTOR (data_size-1 downto 0);
	
	-- The Outputs of the two Muxes on the input to the ALU
	signal A_mux : STD_LOGIC_VECTOR (data_size-1 downto 0);
	signal B_mux : STD_LOGIC_VECTOR (data_size-1 downto 0);
	
	-- The output of the combined ALU and shifter
	signal ALU_out : STD_LOGIC_VECTOR (data_size-1 downto 0);
	signal ALU_reg_out : STD_LOGIC_VECTOR (data_size-1 downto 0);

	-- The output of the memory in register
	signal M_in_reg_out : STD_LOGIC_VECTOR (data_size-1 downto 0);

begin
	
	-- The two multiplexers on the input to the ALU
	A_mux <= A_reg_out when S(2) = '0' else PC;
	B_mux <= B_reg_out when S(1) = '0' else IMM;

	-- The address multiplexer for the memory
	M_DA <= M_A when s(3) = '1' else ALU_reg_out;
	
	M_out <= B_reg_out;
	PC_plus <= ALU_reg_out;
	
	-- The register write multiplexer
	reg_in <= ALU_reg_out when s(4) = '0' else M_in_reg_out;

	-- The register on the A bus
	A_reg: entity work.Reg Generic Map (data_size => data_size)
	PORT MAP(
		clk => clk,
		rst => rst,
		en => en,
		data_in => A_data,
		data_out => A_reg_out
	);
	
	-- The register on the B bus
	B_reg: entity work.Reg Generic Map (data_size => data_size)
	PORT MAP(
		clk => clk,
		rst => rst,
		en => en,
		data_in => B_data,
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
		en => en,
		data_in => M_in,
		data_out => M_in_reg_out
	);

	-- The ALU and shifter from Lab 1
	ALU: entity work.ALU_param GENERIC MAP( N => data_size )
	PORT MAP(
		A => A_mux,
		B => B_mux,
		X => SH,
		ctrl => AL,
		O => ALU_out,
		flags => flags
	);
	
	-- The register array from Lab_1
	Registers: entity work.Pram_Registers 
	Generic Map(
		num_reg => num_registers,
		data_size => data_size
	)
	PORT MAP(
		addr_A => R_A,
		addr_B => R_B,
		addr_C => W_A,
		data_in => reg_in,
		wr_en => W_EN,
		clk => clk,
		A_out => A_data,
		B_out => B_data
	);

end Behavioral;

