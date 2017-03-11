
library IEEE;
use IEEE.STD_LOGIC_1164.all;
USE ieee.numeric_std.ALL;

package easyprint is

function s_tostr(val : std_logic_vector) return string;
function u_tostr(val : std_logic_vector) return string;

function to_bstring(sl : std_logic) return string;
function to_bstring(slv : std_logic_vector) return string;


end easyprint;

package body easyprint is

	-- ==== ==== ==== ==== ==== ==== ==== ==== ==== ==== ==== ==== ==== ==== ==== ====  
	-- From http://stackoverflow.com/a/24336034 By Morten Zilmer
	-- Allows printing a std_logic_vector as a string that represents it's binary form.
	-- ==== ==== ==== ==== ==== ==== ==== ==== ==== ==== ==== ==== ==== ==== ==== ====  
	function to_bstring(sl : std_logic) return string is
		variable sl_str_v : string(1 to 3);  -- std_logic image with quotes around
	begin
		sl_str_v := std_logic'image(sl);
		return "" & sl_str_v(2);  -- "" & character to get string
	end function;
	
	function to_bstring(slv : std_logic_vector) return string is
		alias    slv_norm : std_logic_vector(1 to slv'length) is slv;
		variable sl_str_v : string(1 to 1);  -- String of std_logic
		variable res_v    : string(1 to slv'length);
	begin
		for idx in slv_norm'range loop
			sl_str_v := to_bstring(slv_norm(idx));
			res_v(idx) := sl_str_v(1);
		end loop;
		return res_v;
	end function;
	-- ==== ==== ==== ==== ==== ==== ==== ==== ==== ==== ==== ==== ==== ==== ==== ====  

	
	-- converts an std_logic_vector to a string that represents it's signed value
	function s_tostr(val : std_logic_vector) return string is
	begin
		return integer'image( to_integer(signed(val)) );
	end function;
	
	-- converts an std_logic_vector to a string that represents it's unsigned value
	function u_tostr(val : std_logic_vector) return string is
	begin
		return integer'image( to_integer(unsigned(val)) );
	end function;
 
end easyprint;
