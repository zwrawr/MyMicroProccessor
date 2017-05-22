
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;

entity DualPortMemory is
    Port ( 
		clk : in std_logic;
		I_addr : in  STD_LOGIC_VECTOR (6 downto 0);
		D_addr : in  STD_LOGIC_VECTOR (6 downto 0);
		D_in : in  STD_LOGIC_VECTOR (31 downto 0);
		WE : in  STD_LOGIC;
		D_out : out  STD_LOGIC_VECTOR (31 downto 0);
		I_out : out  STD_LOGIC_VECTOR (31 downto 0)
		
	);
end DualPortMemory;

architecture Behavioral of DualPortMemory is
	type ram_type is array (0 to (2**7)-1) of std_logic_vector(31 downto 0);
    signal ram : ram_type := (
		0 => X"00000000",
		1 => X"00000000",
		2 => X"CDFF8000",
		3 => X"00000000",
		4 => X"C1FF8000",
--		0 => X"00000000",
--		1 => X"8407C00F",
--		2 => X"C1FF800F",
--		3 => X"18AD9C1F",
--		4 => X"00000001",
--		5 => X"20000021",
--		6 => X"CC02801F",
--		7 => X"980003E1",
--		8 => X"20000021",
--		9 => X"240003FF",
--		10 => X"DDFE0000",
--		11 => X"84019002",
--		12 => X"5400101E",
--		13 => X"880003C3",
--		14 => X"8C000FC4",
--		15 => X"5BFFFC1D",
--		16 => X"80000007",
--		17 => X"500043A5",
--		18 => X"50000486",
--		19 => X"C0010006",
--		20 => X"00038067",
--		21 => X"64010084",
--		22 => X"60010063",
--		23 => X"240000A5",
--		24 => X"C5FD0005",
--		25 => X"94000007",
--		26 => X"680900E7",
--		27 => X"6C0300E7",
--		28 => X"400000E8",
--		29 => X"4C0403A8",
--		30 => X"14038109",
--		31 => X"1C00052A",
--		32 => X"D004800A",
--		33 => X"C004000A",
--		34 => X"1800294B",
--		35 => X"C003000B",
--		36 => X"480580EC",
--		37 => X"9C00040C",
--		38 => X"4405818C",
--		39 => X"C800800C",
--		40 => X"DC000000",
--		41 => X"DC000000",
--		42 => X"940FFC07",
--		43 => X"DC000000",
		others => X"00000000"
	);	
begin

	I_out <= ram(to_integer(unsigned(I_addr)));
	D_out <= ram(to_integer(unsigned(D_addr)));


	write_proc : process(clk, WE)
	begin
		if (rising_edge(clk) and WE = '1') then
			ram(to_integer(unsigned(D_addr))) <= D_in;
		end if;
	end process;
end Behavioral;
