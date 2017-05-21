LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

entity MMU is
	Port ( 	
		I_addr : in  STD_LOGIC_VECTOR (7 downto 0);

		OEn : in  STD_LOGIC;
		D_in : in  STD_LOGIC_VECTOR (15 downto 0);
		D_out : out  STD_LOGIC_VECTOR (15 downto 0);
		D_addr : in  STD_LOGIC_VECTOR (15 downto 0);

		start : in  STD_LOGIC;

		oWE : out  STD_LOGIC;
		oD_out : out  STD_LOGIC_VECTOR (15 downto 0);

		mWE : out  STD_LOGIC;
		mD_addr : out  STD_LOGIC_VECTOR (6 downto 0);
		mD_in : in  STD_LOGIC_VECTOR (31 downto 0);
		mD_out : out  STD_LOGIC_VECTOR (31 downto 0);
		mI_addr : out  STD_LOGIC_VECTOR (6 downto 0)
		
	);
end MMU;

architecture Behavioral of MMU is
	signal to_write : STD_LOGIC_VECTOR (31 downto 0);
	
	signal isMemAccess : STD_LOGIC;
begin

	isMemAccess <=
		'1' when unsigned(D_addr) >= 64 and  unsigned(D_addr) < 64+(64*2) else
		'0';
		
	--Instructions
	mI_addr <= I_addr(6 downto 0);
	
	-- Output Reg
	oD_out <= D_in;
	oWE <= '1' when D_addr = X"01F8" and OEn = '1' else '0';
	
	-- Data to write to memory
	to_write(31 downto 16) <=
		D_in when D_addr(0) = '0' else
		mD_in(31 downto 16);
		
	to_write(15 downto 0) <=
		D_in when D_addr(0) = '0' else
		mD_in(15 downto 0);

	mD_out <= to_write;
	
	mWE <= 
		'1' when isMemAccess = '1' and OEn = '1' else
		'0';
	
	mD_addr <= std_logic_vector(unsigned(D_addr(7 downto 1)) + to_unsigned(64,7));
	
	-- Data to processor
	D_out <=
		mD_in(31 downto 16) 	when isMemAccess = '1' and D_addr(0) = '1' 	else
		mD_in(15 downto 0) 	when isMemAccess = '1' and D_addr(0) = '0' 	else
		X"ffff" 			when D_addr = X"01F0" and start = '1' 		else
		X"0000" 			when D_addr = X"01F0" and start = '0' 		else
		(others =>'U');


end Behavioral;

