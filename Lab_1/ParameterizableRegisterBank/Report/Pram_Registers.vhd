----------------------------------------------------------------------------------
-- 
-- Uni			:	University of York
-- Course		:	Electronic Engineering
-- Module  		:	Computer Architectures 
-- Engineers	:	Y3839090 & Y3840426
-- 
-- Create Date	:	20:11:17 02/23/2017
-- Design Name	:	Param_Registers - Behavioral 
-- Description	:	A parameteriable dual read single write register array. 		
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.DigEng.ALL;

entity Pram_Registers is
	Generic
	(
		num_reg : natural := 8; -- The number of registers to create
		data_size : natural := 16 -- The data size of these registers in bits
	);
	Port ( 
		addr_A : in  STD_LOGIC_VECTOR (log2(num_reg)-1 downto 0); -- A address to read from 
		addr_B : in  STD_LOGIC_VECTOR (log2(num_reg)-1 downto 0); -- B address to read from
		addr_C : in  STD_LOGIC_VECTOR (log2(num_reg)-1 downto 0); -- C address to write to.
		data_in : in  STD_LOGIC_VECTOR (data_size-1 downto 0); -- The data to write
		wr_en : in  STD_LOGIC; -- write enable
		clk : in STD_LOGIC;
		A_out : out  STD_LOGIC_VECTOR (data_size-1 downto 0); -- Data read from addr_A
		B_out : out  STD_LOGIC_VECTOR (data_size-1 downto 0) -- Data read from addr_B
	);
end Pram_Registers;

architecture Behavioral of Pram_Registers is
	
	signal A_index : STD_LOGIC_VECTOR (num_reg-1 downto 0); -- Decoded address signal for A
	signal B_index : STD_LOGIC_VECTOR (num_reg-1 downto 0); -- Decoded address signal for B
	signal C_index : STD_LOGIC_VECTOR (num_reg-1 downto 0); -- Decoded address signal for C (writes)
	
	signal reg_out : STD_LOGIC_VECTOR ((data_size*num_reg)-1 downto 0); -- output bus from all of the registers

begin

	-- Address decoder for reads on B
	A_decoder: entity work.decoder 
	GENERIC MAP( num_reg => num_reg )
	PORT MAP(
		addr => addr_A,
		enables => A_index,
		en => '1'
	);
	
	-- Address decoder for reads on B
	B_decoder: entity work.decoder 
	GENERIC MAP( num_reg => num_reg )
	PORT MAP(
		addr => addr_B,
		enables => B_index,
		en => '1'
	);
	
	-- Address decoder for writing
	C_decoder: entity work.decoder 
	GENERIC MAP( num_reg => num_reg )
	PORT MAP(
		addr => addr_C,
		enables => C_index,
		en => wr_en
	);
	
	-- Create the special R(0) 'register' by have zero inputs to it's tristate buffers
	triestate_R0_A: entity work.triestate_buffer 
	GENERIC MAP( data_size => data_size )
	PORT MAP(
		data_in => (others => '0'),
		en => A_index(0),
		data_out => A_out
	);
	triestate_R0_B: entity work.triestate_buffer 
	GENERIC MAP( data_size => data_size )
	PORT MAP(
		data_in => (others => '0'),
		en => B_index(0),
		data_out => B_out
	);	

	
	-- Generate registers and tri-states for R(1) to R(N-1)
	generator: for i in 1 to num_reg-1 generate
		
		-- Trie state for the A_itrn bus
		triestate_A: entity work.triestate_buffer 
		GENERIC MAP( data_size => data_size )
		PORT MAP(
			data_in => reg_out( (i+1)*data_size -1 downto i*data_size),
			en => A_index(i),
			data_out => A_out
		);
	
		-- Trie state for the B_itrn bus
		triestate_B: entity work.triestate_buffer 
		GENERIC MAP( data_size => data_size )
		PORT MAP(
			data_in => reg_out( (i+1)*data_size -1 downto i*data_size),
			en => B_index(i),
			data_out => B_out
		);	
		
		-- Registers
		Inst_param_reg: entity work.param_reg 
		GENERIC MAP( data_size => data_size )
		PORT MAP(
			data_in => data_in,
			load => C_index(i),
			clk => clk,
			data_out => reg_out( (i+1)*data_size -1 downto i*data_size)
		);
		
	end generate;

end Behavioral;

