library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.DigEng.all;

entity DataPath_B is
	GENERIC(
		data_size : natural := 16;
		num_registers : natural := 32
	);
	Port ( 
		clk : in  STD_LOGIC;
		
		R_A : in  STD_LOGIC_VECTOR (log2(num_registers)-1 downto 0); -- Read address A 
		R_B : in  STD_LOGIC_VECTOR (log2(num_registers)-1 downto 0); -- Read address B
		W_EN : in  STD_LOGIC;										 -- Register write enable
		W_A : in  STD_LOGIC_VECTOR (log2(num_registers)-1 downto 0); -- Write address
		IMM : in  STD_LOGIC_VECTOR (data_size-1 downto 0);			 -- Itermediate value
		AL : in  STD_LOGIC_VECTOR (3 downto 0);						 -- ALU control
		SH : in  STD_LOGIC_VECTOR (log2(data_size)-1 downto 0);		 -- Shift amount
		M_A : in  STD_LOGIC_VECTOR (data_size-1 downto 0);			 -- Memory address
		S : in  STD_LOGIC_VECTOR (4 downto 1);						 -- Selector control
		flags : out STD_LOGIC_VECTOR(7 downto 0);					 -- ALU flags
		M_B : out STD_LOGIC_VECTOR (data_size-1 downto 0);			 -- Memory output (write)
		M_DA : out  STD_LOGIC_VECTOR (data_size-1 downto 0);		 -- Memory address
		M_in : in  STD_LOGIC_VECTOR (data_size-1 downto 0)			 -- Memory input (read)
	);
end DataPath_B;

architecture Behavioral of DataPath_B is

	signal reg_in : STD_LOGIC_VECTOR (data_size-1 downto 0); -- register write data
	
	signal A_data : STD_LOGIC_VECTOR (data_size-1 downto 0); -- Data from register at address R_A
	signal B_data : STD_LOGIC_VECTOR (data_size-1 downto 0); -- Data from register at address R_B
	
	signal B_mux : STD_LOGIC_VECTOR (data_size-1 downto 0);	-- B input to the ALU

	signal ALU_out : STD_LOGIC_VECTOR (data_size-1 downto 0); -- Output of the ALU

begin
	
	-- Multiplexer on the ALU's B input
	B_mux <= B_data when S(1) = '0' else IMM;
	
	-- Multiplexer for the memory address
	M_DA <= M_A when s(3) = '1' else ALU_out;
	
	-- Multiplexer for the register write data
	reg_in <= ALU_out when s(4) = '0' else M_in;
	
	-- Memory write (output) connection
	M_B <= B_data;
	
	-- The ALU
	ALU: entity work.ALU_param 
	GENERIC MAP(
		N => data_size
	)
	PORT MAP(
		A => A_data,
		B => B_mux,
		X => SH,
		ctrl => AL,
		O => ALU_out,
		flags => flags
	);
	
	-- The register bank
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

