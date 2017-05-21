LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE work.easyprint.ALL;
 
ENTITY Decoder_TB IS
END Decoder_TB;
 
ARCHITECTURE behavior OF Decoder_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Decoder_Block
    PORT(
         instr : IN  std_logic_vector(31 downto 0);
		 OPCODE : OUT  std_logic_vector(5 downto 0);
         RA : OUT  std_logic_vector(4 downto 0);
         RB : OUT  std_logic_vector(4 downto 0);
         WA : OUT  std_logic_vector(4 downto 0);
         MA : OUT  std_logic_vector(15 downto 0);
         IMM : OUT  std_logic_vector(15 downto 0);
         AL : OUT  std_logic_vector(3 downto 0);
         SH : OUT  std_logic_vector(3 downto 0);
         WEN : OUT  std_logic;
         OEN : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal instr : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal OPCODE : std_logic_vector(5 downto 0);
   signal RA : std_logic_vector(4 downto 0);
   signal RB : std_logic_vector(4 downto 0);
   signal WA : std_logic_vector(4 downto 0);
   signal MA : std_logic_vector(15 downto 0);
   signal IMM : std_logic_vector(15 downto 0);
   signal AL : std_logic_vector(3 downto 0);
   signal SH : std_logic_vector(3 downto 0);
   signal WEN : std_logic;
   signal OEN : std_logic;
   
   -- Test Data
	type TEST_RECORD is record
		--Inputs
		 instr : std_logic_vector(31 downto 0);
		 
		 --Outputs
		 OPCODE : std_logic_vector(5 downto 0);
         RA : std_logic_vector(4 downto 0);
         RB : std_logic_vector(4 downto 0);
         WA : std_logic_vector(4 downto 0);
         MA : std_logic_vector(15 downto 0);
         IMM : std_logic_vector(15 downto 0);
         AL : std_logic_vector(3 downto 0);
         SH : std_logic_vector(3 downto 0);
         WEN : std_logic;
         OEN : std_logic;
		
	end record;
   
    type TEST_RECORD_ARRAY is array (NATURAL range <>) of TEST_RECORD;
	
	constant test_data : TEST_RECORD_ARRAY := (
--	INSTRUCTION,								OPCODE, 	RA, 		RB,			WA, 	MA,				    	IMM,				ALU,	SH,		WEN, OEN
		("011000------0010------1001110011",	"011000",	"10011",	"-----",	"10011", "----------------",	"----------------",	"1100",	"0010",	'1', '0'),
		("00011000110011001100110101011110",	"000110",	"01010",	"-----",	"11110", "----------------",	"0011001100110011",	"1010",	"----",	'1', '0'),	 
		("000100-----00011------0001000010", 	"000100",  	"00010", 	"00011",	"00010", "----------------",	"----------------",	"1010",	"----",	'1', '0'),
		("10000100000001111100000000001111",	"100001",	"-----",	"-----",	"01111", 			X"01F0",	"----------------",	"----", "----",	'1', '0')
	);
	
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Decoder_Block PORT MAP (
          instr => instr,
		  OPCODE => OPCODE,
          RA => RA,
          RB => RB,
          WA => WA,
          MA => MA,
          IMM => IMM,
          AL => AL,
          SH => SH,
          WEN => WEN,
          OEN => OEN
        );

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      for i in test_data'range loop
		

			-- assign test inputs
			instr <= test_data(i).instr;
			
			wait for 100 ns;
			
			-- Check to see if the out put was what we were expecting
			assert std_match(OPCODE, test_data(i).OPCODE)
			report lf & " [ERR!] Test " & integer'image(i)& 
			" Actual OPCODE did not equal expected OPCODE."&
			" Actual [ " & to_bstring(OPCODE) & " ]" &
			" Expected [ " & to_bstring(test_data(i).OPCODE) & " ]" & lf
			severity error;
			
			assert std_match(RA, test_data(i).RA)
			report lf & " [ERR!] Test " & integer'image(i)& 
			" Actual RA did not equal expected RA."&
			" Actual [ " & to_bstring(RA) & " ]" &
			" Expected [ " & to_bstring(test_data(i).RA) & " ]" & lf
			severity error;

			assert std_match(RB, test_data(i).RB)
			report lf & " [ERR!] Test " & integer'image(i)& 
			" Actual RB did not equal expected RB."&
			" Actual [ " & to_bstring(RB) & " ]" &
			" Expected [ " & to_bstring(test_data(i).RB) & " ]" & lf
			severity error;
			
			assert std_match(WA, test_data(i).WA)
			report lf & " [ERR!] Test " & integer'image(i)& 
			" Actual PC did not equal expected RB."&
			" Actual [ " & to_bstring(WA) & " ]" &
			" Expected [ " & to_bstring(test_data(i).WA) & " ]" & lf
			severity error;
			
			assert std_match(MA, test_data(i).MA)
			report lf & " [ERR!] Test " & integer'image(i)& 
			" Actual MA did not equal expected MA."&
			" Actual [ " & to_bstring(MA) & " ]" &
			" Expected [ " & to_bstring(test_data(i).MA) & " ]" & lf
			severity error;
			
			assert std_match(IMM, test_data(i).IMM)
			report lf & " [ERR!] Test " & integer'image(i)& 
			" Actual IMM did not equal expected IMM."&
			" Actual [ " & to_bstring(IMM) & " ]" &
			" Expected [ " & to_bstring(test_data(i).IMM) & " ]" & lf
			severity error;
			
			assert std_match(AL, test_data(i).AL)
			report lf & " [ERR!] Test " & integer'image(i)& 
			" Actual AL did not equal expected AL."&
			" Actual [ " & to_bstring(AL) & " ]" &
			" Expected [ " & to_bstring(test_data(i).AL) & " ]" & lf
			severity error;
			
			assert std_match(SH, test_data(i).SH)
			report lf & " [ERR!] Test " & integer'image(i)& 
			" Actual SH did not equal expected SH."&
			" Actual [ " & to_bstring(SH) & " ]" &
			" Expected [ " & to_bstring(test_data(i).SH) & " ]" & lf
			severity error;
			
			assert std_match(WEN, test_data(i).WEN)
			report lf & " [ERR!] Test " & integer'image(i)& 
			" Actual WEN did not equal expected WEN."&
			" Actual [ " & to_bstring(WEN) & " ]" &
			" Expected [ " & to_bstring(test_data(i).WEN) & " ]" & lf
			severity error;
			
			assert std_match(OEN, test_data(i).OEN)
			report lf & " [ERR!] Test " & integer'image(i)& 
			" Actual OEN did not equal expected OEN."&
			" Actual [ " & to_bstring(WEN) & " ]" &
			" Expected [ " & to_bstring(test_data(i).OEN) & " ]" & lf
			severity error;
			
			-- if there were no isses report that the test was successful
			assert not (
				std_match(OPCODE, test_data(i).OPCODE) and
				std_match(RA, test_data(i).RA) and
				std_match(RB, test_data(i).RB) and
				std_match(WA, test_data(i).WA) and
				std_match(MA, test_data(i).MA) and
				std_match(IMM, test_data(i).IMM) and
				std_match(AL, test_data(i).AL) and
				std_match(SH, test_data(i).SH) and
				std_match(OEN, test_data(i).OEN) and
				std_match(WEN, test_data(i).WEN)
			)
			report lf & " [ OK ] Test " & integer'image(i)& " was successful!" & lf
			severity note;
			

		end loop;

		-- End of test

      -- insert stimulus here 

      wait;
   end process;

END;
