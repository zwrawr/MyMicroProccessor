library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.DigEng.ALL;

entity Pram_Registers is
	Generic
	(
		num_reg : natural := 8;
		data_size : natural := 16
	);
	Port ( 
		addr_A : in  STD_LOGIC_VECTOR (log2(num_reg)-1 downto 0);
		addr_B : in  STD_LOGIC_VECTOR (log2(num_reg)-1 downto 0);
		addr_C : in  STD_LOGIC_VECTOR (log2(num_reg)-1 downto 0);
		wr_en : in  STD_LOGIC;
		clk : in STD_LOGIC;
		data_in : in  STD_LOGIC_VECTOR (data_size-1 downto 0);
		A_out : out  STD_LOGIC_VECTOR (data_size-1 downto 0);
		B_out : out  STD_LOGIC_VECTOR (data_size-1 downto 0)
	);
end Pram_Registers;

architecture Behavioral of Pram_Registers is
	
	signal A_index : STD_LOGIC_VECTOR (num_reg-1 downto 0); -- green
	signal B_index : STD_LOGIC_VECTOR (num_reg-1 downto 0); -- red
	signal C_index : STD_LOGIC_VECTOR (num_reg-1 downto 0); -- blue
	
	signal reg_out : STD_LOGIC_VECTOR ((data_size*num_reg)-1 downto 0); -- yellow

begin

	-- Address decoder for reads on B
	A_decoder: entity work.decoder 
	GENERIC MAP(
		num_reg => num_reg
	)
	PORT MAP(
		addr => addr_A,
		enables => A_index,
		en => '1'
	);
	
	-- Address decoder for reads on B
	B_decoder: entity work.decoder 
	GENERIC MAP(
		num_reg => num_reg
	)
	PORT MAP(
		addr => addr_B,
		enables => B_index,
		en => '1'
	);
	
	-- Address decoder for writing
	C_decoder: entity work.decoder 
	GENERIC MAP(
		num_reg => num_reg
	)
	PORT MAP(
		addr => addr_C,
		enables => C_index,
		en => wr_en
	);
	
	-- Create the special R(0) 'register'
	triestate_R0_A: entity work.triestate_buffer 
	GENERIC MAP(
		data_size => data_size
	)
	PORT MAP(
		data_in => (others => '0'),
		en => A_index(0),
		data_out => A_out
	);

	triestate_R0_B: entity work.triestate_buffer 
	GENERIC MAP(
		data_size => data_size
	)
	PORT MAP(
		data_in => (others => '0'),
		en => B_index(0),
		data_out => B_out
	);	

	
	-- Generate registers and tri-states for R(1) to R(N-1)
	generator: for i in 1 to num_reg-1 generate
		
		-- Trie state for the A_itrn bus
		triestate_A: entity work.triestate_buffer 
		GENERIC MAP(
			data_size => data_size
		)
		PORT MAP(
			data_in => reg_out( (i+1)*data_size -1 downto i*data_size),
			en => A_index(i),
			data_out => A_out
		);
	
		-- Trie state for the B_itrn bus
		triestate_B: entity work.triestate_buffer 
		GENERIC MAP(
			data_size => data_size
		)
		PORT MAP(
			data_in => reg_out( (i+1)*data_size -1 downto i*data_size),
			en => B_index(i),
			data_out => B_out
		);	
		
		-- Registers
		Inst_param_reg: entity work.param_reg 
		GENERIC MAP(
			data_size => data_size
		)
		PORT MAP(
			data_in => data_in,
			load => C_index(i),
			clk => clk,
			data_out => reg_out( (i+1)*data_size -1 downto i*data_size)
		);
		
	end generate;

end Behavioral;

