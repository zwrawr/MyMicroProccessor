----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:18:19 03/03/2017 
-- Design Name: 
-- Module Name:    DataPath_B - Behavioral 
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
use work.DigEng.all;

entity DataPath_B is
	GENERIC(
		data_size : natural := 16,
		num_registers : natural := 5
	);
	Port ( 
		R_A : in  STD_LOGIC_VECTOR (log2(num_registers)-1 downto 0);
		R_B : in  STD_LOGIC_VECTOR (log2(num_registers)-1 downto 0);
		W_EN : in  STD_LOGIC;
		W_A : in  STD_LOGIC_VECTOR (log2(num_registers)-1 downto 0);
		clk : in  STD_LOGIC;
		IMM : in  STD_LOGIC_VECTOR (data_size-1 downto 0);
		AL : in  STD_LOGIC_VECTOR (3 downto 0);
		SH : in  STD_LOGIC_VECTOR (log2(data_size)-1 downto 0);
		M_A : in  STD_LOGIC_VECTOR (data_size-1 downto 0);
		S : in  STD_LOGIC_VECTOR (4 downto 1);
		flags : out STD_LOGIC_VECTOR(7 downto 0);
		M_B : out STD_LOGIC_VECTOR (data_size-1 downto 0);
		M_DA : out  STD_LOGIC_VECTOR (data_size-1 downto 0);
		M_in : in  STD_LOGIC_VECTOR (data_size-1 downto 0)
	);
end DataPath_B;

architecture Behavioral of DataPath_B is

	signal reg_in : STD_LOGIC_VECTOR (data_size-1 downto 0);
	
	signal A_data : STD_LOGIC_VECTOR (data_size-1 downto 0);
	signal B_data : STD_LOGIC_VECTOR (data_size-1 downto 0);
	
	signal B_mux : STD_LOGIC_VECTOR (data_size-1 downto 0);
	
	signal ALU_out : STD_LOGIC_VECTOR (data_size-1 downto 0);

begin

	B_mux <= B_data when S(1) = '0' else IMM;

	M_DA <= M_A when s(3) = '1' else ALU_out;
	
	reg_in <= ALU_out when s(4) = '0' else M_in;

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

