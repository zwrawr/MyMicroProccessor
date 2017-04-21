----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:20:58 02/23/2009 
-- Design Name: 
-- Module Name:    regbank - Behavioral 
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


---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity regbank is
    Port ( A : out  STD_LOGIC_VECTOR (15 downto 0);
           B : out  STD_LOGIC_VECTOR (15 downto 0);
           RSELA : in  STD_LOGIC_VECTOR (4 downto 0);
           RSELB : in  STD_LOGIC_VECTOR (4 downto 0);
           D : in  STD_LOGIC_VECTOR (15 downto 0);
           WSEL : in  STD_LOGIC_VECTOR (4 downto 0);
			  WEN: in STD_LOGIC;
			  CLK, RST: in STD_LOGIC);
end regbank;

architecture Behavioral of regbank is

--type rbank is array (0 to 31) of std_logic_vector (15 downto 0);
signal REG00 : std_logic_vector (15 downto 0);
signal REG01 : std_logic_vector (15 downto 0);
signal REG02 : std_logic_vector (15 downto 0);
signal REG03 : std_logic_vector (15 downto 0);
signal REG04 : std_logic_vector (15 downto 0);
signal REG05 : std_logic_vector (15 downto 0);
signal REG06 : std_logic_vector (15 downto 0);
signal REG07 : std_logic_vector (15 downto 0);
signal REG08 : std_logic_vector (15 downto 0);
signal REG09 : std_logic_vector (15 downto 0);
signal REG10 : std_logic_vector (15 downto 0);
signal REG11 : std_logic_vector (15 downto 0);
signal REG12 : std_logic_vector (15 downto 0);
signal REG13 : std_logic_vector (15 downto 0);
signal REG14 : std_logic_vector (15 downto 0);
signal REG15 : std_logic_vector (15 downto 0);
signal REG16 : std_logic_vector (15 downto 0);
signal REG17 : std_logic_vector (15 downto 0);
signal REG18 : std_logic_vector (15 downto 0);
signal REG19 : std_logic_vector (15 downto 0);
signal REG20 : std_logic_vector (15 downto 0);
signal REG21 : std_logic_vector (15 downto 0);
signal REG22 : std_logic_vector (15 downto 0);
signal REG23 : std_logic_vector (15 downto 0);
signal REG24 : std_logic_vector (15 downto 0);
signal REG25 : std_logic_vector (15 downto 0);
signal REG26 : std_logic_vector (15 downto 0);
signal REG27 : std_logic_vector (15 downto 0);
signal REG28 : std_logic_vector (15 downto 0);
signal REG29 : std_logic_vector (15 downto 0);
signal REG30 : std_logic_vector (15 downto 0);
signal REG31 : std_logic_vector (15 downto 0);

begin

	A <= 	REG00 when RSELA = "00000" else
			REG01 when RSELA = "00001" else
			REG02 when RSELA = "00010" else
			REG03 when RSELA = "00011" else
			REG04 when RSELA = "00100" else
			REG05 when RSELA = "00101" else
			REG06 when RSELA = "00110" else
			REG07 when RSELA = "00111" else
			REG08 when RSELA = "01000" else
			REG09 when RSELA = "01001" else
			REG10 when RSELA = "01010" else
			REG11 when RSELA = "01011" else
			REG12 when RSELA = "01100" else
			REG13 when RSELA = "01101" else
			REG14 when RSELA = "01110" else
			REG15 when RSELA = "01111" else
			REG16 when RSELA = "10000" else
			REG17 when RSELA = "10001" else
			REG18 when RSELA = "10010" else
			REG19 when RSELA = "10011" else
			REG20 when RSELA = "10100" else
			REG21 when RSELA = "10101" else
			REG22 when RSELA = "10110" else
			REG23 when RSELA = "10111" else
			REG24 when RSELA = "11000" else
			REG25 when RSELA = "11001" else
			REG26 when RSELA = "11010" else
			REG27 when RSELA = "11011" else
			REG28 when RSELA = "11100" else
			REG29 when RSELA = "11101" else
			REG30 when RSELA = "11110" else
			REG31 when RSELA = "11111" else
			"XXXXXXXXXXXXXXXX";
			
	B <= 	REG00 when RSELB = "00000" else
			REG01 when RSELB = "00001" else
			REG02 when RSELB = "00010" else
			REG03 when RSELB = "00011" else
			REG04 when RSELB = "00100" else
			REG05 when RSELB = "00101" else
			REG06 when RSELB = "00110" else
			REG07 when RSELB = "00111" else
			REG08 when RSELB = "01000" else
			REG09 when RSELB = "01001" else
			REG10 when RSELB = "01010" else
			REG11 when RSELB = "01011" else
			REG12 when RSELB = "01100" else
			REG13 when RSELB = "01101" else
			REG14 when RSELB = "01110" else
			REG15 when RSELB = "01111" else
			REG16 when RSELB = "10000" else
			REG17 when RSELB = "10001" else
			REG18 when RSELB = "10010" else
			REG19 when RSELB = "10011" else
			REG20 when RSELB = "10100" else
			REG21 when RSELB = "10101" else
			REG22 when RSELB = "10110" else
			REG23 when RSELB = "10111" else
			REG24 when RSELB = "11000" else
			REG25 when RSELB = "11001" else
			REG26 when RSELB = "11010" else
			REG27 when RSELB = "11011" else
			REG28 when RSELB = "11100" else
			REG29 when RSELB = "11101" else
			REG30 when RSELB = "11110" else
			REG31 when RSELB = "11111" else
			"XXXXXXXXXXXXXXXX";
			
   REG00 <= "0000000000000000";

process (CLK)
begin
	if (CLK'event and CLK = '1') then
		if RST = '1' then
		   REG01 <= "0000000000000000";
		   REG02 <= "0000000000000000";
		   REG03 <= "0000000000000000";
		   REG04 <= "0000000000000000";
		   REG05 <= "0000000000000000";
		   REG06 <= "0000000000000000";
		   REG07 <= "0000000000000000";
		   REG08 <= "0000000000000000";
		   REG09 <= "0000000000000000";
		   REG10 <= "0000000000000000";
		   REG11 <= "0000000000000000";
		   REG12 <= "0000000000000000";
		   REG13 <= "0000000000000000";
		   REG14 <= "0000000000000000";
		   REG15 <= "0000000000000000";
		   REG16 <= "0000000000000000";
		   REG17 <= "0000000000000000";
		   REG18 <= "0000000000000000";
		   REG19 <= "0000000000000000";
		   REG20 <= "0000000000000000";
		   REG21 <= "0000000000000000";
		   REG22 <= "0000000000000000";
		   REG23 <= "0000000000000000";
		   REG24 <= "0000000000000000";
		   REG25 <= "0000000000000000";
		   REG26 <= "0000000000000000";
		   REG27 <= "0000000000000000";
		   REG28 <= "0000000000000000";
		   REG29 <= "0000000000000000";
		   REG30 <= "0000000000000000";
		   REG31 <= "0000000000000000";
		else
			if (WEN = '1') then
				case WSEL is
--					when "00000" => REG00 <= D;
					when "00001" => REG01 <= D;
					when "00010" => REG02 <= D;
					when "00011" => REG03 <= D;
					when "00100" => REG04 <= D;
					when "00101" => REG05 <= D;
					when "00110" => REG06 <= D;
					when "00111" => REG07 <= D;
					when "01000" => REG08 <= D;
					when "01001" => REG09 <= D;
					when "01010" => REG10 <= D;
					when "01011" => REG11 <= D;
					when "01100" => REG12 <= D;
					when "01101" => REG13 <= D;
					when "01110" => REG14 <= D;
					when "01111" => REG15 <= D;
					when "10000" => REG16 <= D;
					when "10001" => REG17 <= D;
					when "10010" => REG18 <= D;
					when "10011" => REG19 <= D;
					when "10100" => REG20 <= D;
					when "10101" => REG21 <= D;
					when "10110" => REG22 <= D;
					when "10111" => REG23 <= D;
					when "11000" => REG24 <= D;
					when "11001" => REG25 <= D;
					when "11010" => REG26 <= D;
					when "11011" => REG27 <= D;
					when "11100" => REG28 <= D;
					when "11101" => REG29 <= D;
					when "11110" => REG30 <= D;
					when "11111" => REG31 <= D;
					when others => REG31 <= REG31;
				end case;
			end if;
		end if; 
	end if;
end process;

end Behavioral;
