----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:33:58 03/09/2017 
-- Design Name: 
-- Module Name:    DataPath_C - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.DigEng.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity DataPath_C is
	GENERIC(
		data_size : natural := 16;
		num_registers : natural := 5
	);
	Port ( 
		clk : in  STD_LOGIC;
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
		PC_plus : out  STD_LOGIC_VECTOR (15 downto 0);
		Flags : out  STD_LOGIC_VECTOR (7 downto 0);
		M_DA : out  STD_LOGIC_VECTOR (data_size-1 downto 0);
		M_out : out  STD_LOGIC_VECTOR (data_size-1 downto 0)
	);
end DataPath_C;

architecture Behavioral of DataPath_C is
	signal reg_in : STD_LOGIC_VECTOR (data_size-1 downto 0);
	
	signal A_data : STD_LOGIC_VECTOR (data_size-1 downto 0);
	signal B_data : STD_LOGIC_VECTOR (data_size-1 downto 0);
	
	signal A_mux : STD_LOGIC_VECTOR (data_size-1 downto 0);
	signal B_mux : STD_LOGIC_VECTOR (data_size-1 downto 0);
	
	signal A_reg_out : STD_LOGIC_VECTOR (data_size-1 downto 0);
	signal B_reg_out : STD_LOGIC_VECTOR (data_size-1 downto 0);
	
	signal ALU_out : STD_LOGIC_VECTOR (data_size-1 downto 0);
	signal ALU_reg_out : STD_LOGIC_VECTOR (data_size-1 downto 0);

	signal M_in_reg_out : STD_LOGIC_VECTOR (data_size-1 downto 0);

begin

	A_mux <= A_reg_out when S(2) = '0' else PC;
	B_mux <= B_reg_out when S(1) = '0' else IMM;

	M_DA <= M_A when s(3) = '1' else ALU_reg_out;
	M_out <= B_reg_out;

	PC_plus <= ALU_reg_out;
	reg_in <= ALU_reg_out when s(4) = '0' else M_in_reg_out;


	A_reg: entity work.Reg Generic Map (data_size => data_size)
	PORT MAP(
		clk => clk,
		data_in => A_data,
		data_out => A_reg_out
	);
	
	B_reg: entity work.Reg Generic Map (data_size => data_size)
	PORT MAP(
		clk => clk,
		data_in => B_data,
		data_out => B_reg_out
	);
	
	ALU_reg: entity work.Reg Generic Map (data_size => data_size)
	PORT MAP(
		clk => clk,
		data_in => ALU_out,
		data_out => ALU_reg_out
	);
	
	M_in_reg: entity work.Reg Generic Map (data_size => data_size)
	PORT MAP(
		clk => clk,
		data_in => M_in,
		data_out => M_in_reg_out
	);

	ALU: entity work.ALU_param GENERIC MAP( N => data_size )
	PORT MAP(
		A => A_mux,
		B => B_mux,
		X => SH,
		ctrl => AL,
		O => ALU_out,
		flags => flags
	);
	
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

