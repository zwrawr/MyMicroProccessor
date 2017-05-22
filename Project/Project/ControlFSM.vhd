
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ControlFSM is
	Port ( 
		clk : in  STD_LOGIC;
		rst : in STD_LOGIC;
		opcode : in  STD_LOGIC_Vector(5 downto 0);
		S : out  STD_LOGIC_VECTOR (4 downto 1);
		STAGE : out STD_LOGIC_VECTOR(8 downto 0)
	);
end ControlFSM;

architecture Behavioral of ControlFSM is

	type STATE_TYPE is ( S0, S1, S2, S3, S4, S5, S6, S7, S8);
	signal curr_state, next_state: STATE_TYPE;
	
	signal optype : STD_LOGIC_VECTOR(1 downto 0);
	
begin

	restart : process(clk,rst) is
	begin
		if rising_edge(clk) then
			if (rst='1') then
				curr_state <= S0;
			else
				curr_state <= next_state;
			end if;
		end if;
	end process;
	
	control : process(curr_state, opcode, optype) is
	begin
	
		-- Top two bits of the opcode tell us which type of instruction this is
		optype <= opcode(opcode'length -1 downto opcode'length -2);
		
		case curr_state is
			when S0 =>
				next_state <= S1;
			when S1 =>
				if (optype = "11") then
					-- Branch
					next_state <= S8;
				elsif (optype = "10") then
					-- Memory
					next_state <= S4;
				else
					-- Registers
					next_state <= S2;
				end if;
			when S2 =>
				next_state <= S3;
			when S3 =>
				next_state <= S0;
			when S4 =>
				if (opcode(1) = '1') then
					-- Store
					next_state <= S5;
				else
					-- Load
					next_state <= S6;
				end if;
			when S5 =>
				next_state <= S0;
			when S6 =>
				next_state <= S7;
			when S7 =>
				next_state <= S0;
			when S8 =>
				next_state <= S0;
		end case;
	end process;
	
	STAGE(0) <= '1' when curr_state = S0 else '0';
	STAGE(1) <= '1' when curr_state = S1 else '0';
	STAGE(2) <= '1' when curr_state = S2 else '0';
	STAGE(3) <= '1' when curr_state = S3 else '0';
	STAGE(4) <= '1' when curr_state = S4 else '0';
	STAGE(5) <= '1' when curr_state = S5 else '0';
	STAGE(6) <= '1' when curr_state = S6 else '0';
	STAGE(7) <= '1' when curr_state = S7 else '0';
	STAGE(8) <= '1' when curr_state = S8 else '0';
	
	S(1) <=
		'-' when curr_state = S0 else
		'-' when curr_state = S1 and optype /= "11" else
		'1' when curr_state = S1 and optype = "11" else
		'0' when curr_state = S2 else
		'-' when curr_state = S3 else
		'1' when curr_state = S4 else
		'-' when curr_state = S5 else
		'-' when curr_state = S6 else
		'0' when curr_state = S7 else
		'0' when curr_state = S8 else
		'X';
		
	S(2) <=
		'1' when curr_state = S0 else
		'-' when curr_state = S1 and optype /= "11" else
		'1' when curr_state = S1 and optype = "11" else
		'0' when curr_state = S2 else
		'-' when curr_state = S3 else
		'0' when curr_state = S4 else
		'-' when curr_state = S5 else
		'-' when curr_state = S6 else
		'0' when curr_state = S7 else
		'0' when curr_state = S8 else
		'X';
		
	S(3) <= '1' when opcode = "100001" and curr_state = S7 else
			'1' when opcode = "100101" and curr_state = S7 else
			'0';
			
	S(4) <= 
		'-' when curr_state = S0 else
		'-' when curr_state = S1 else
		'-' when curr_state = S2 else
		'0' when curr_state = S3 else
		'-' when curr_state = S4 else
		'-' when curr_state = S5 else
		'1' when curr_state = S6 else
		'-' when curr_state = S7 else
		'-' when curr_state = S8 else
		'X';

end Behavioral;

