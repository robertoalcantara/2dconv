----------------------------------------------------------------------------------
-- roberto@eletronica.org
-- 
-- Create Date:    23:24:37 12/08/2018 
-- Module Name:    conv2d - Behavioral 
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use IEEE.NUMERIC_STD.ALL;

entity conv2d is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           pixel1_input : in  STD_LOGIC_VECTOR (7 downto 0);
			  pixel2_input : in  STD_LOGIC_VECTOR (7 downto 0);
           pixel3_input : in  STD_LOGIC_VECTOR (7 downto 0);
           pixel4_input : in  STD_LOGIC_VECTOR (7 downto 0);
			  pixel5_input : in  STD_LOGIC_VECTOR (7 downto 0);
           pixel6_input : in  STD_LOGIC_VECTOR (7 downto 0);
           pixel7_input : in  STD_LOGIC_VECTOR (7 downto 0);
			  pixel8_input : in  STD_LOGIC_VECTOR (7 downto 0);
           pixel9_input : in  STD_LOGIC_VECTOR (7 downto 0);
			  
           output : out  STD_LOGIC_VECTOR (7 downto 0));
end conv2d;

architecture Behavioral of conv2d is
	signal cnt, cnt_next : std_logic_vector(3 downto 0);
	signal output_calc, output_calc_next: integer; 
	
	type t_kernel_const is array (0 to 8) of integer; --atencao contagem TO 
	constant kernel : t_kernel_const := ( 
	0,1,0,
	1,-4,0,
	0,1,0);

	type t_state is (start, conv); 
	signal state, state_next : t_state;
	 
begin


--state and data registers
process(clk,reset)
begin
  if reset='1' then
    --output_calc <= 0;
	--cnt <= std_logic_vector( to_unsigned(0,4) );
	--state <= start;
	
  elsif ( clk'event and clk='1') then
	--	cnt <= cnt_next;
--		state <= state_next;
--		output_calc <= output_calc_next;
  end if;
  
end process;    


--next-state logic and output logic
--process(cnt, state, pixel_input)
--begin

--	state_next <= state;
--	output_calc_next <= output_calc;
--	cnt_next <= cnt;
		
--	case state is
--		when start =>
--			cnt_next <= "0000"; 
--			output_calc_next <= 0;
--			state_next <= conv;

--	    when conv =>
--			--if unsigned(cnt) /= 9 then 
--				--output_calc_next <= output_calc + ( kernel(to_integer(unsigned(cnt))) * to_integer(signed(pixel_input)) ); 
--				cnt_next <= std_logic_vector(  unsigned(cnt) + 1 );
--			else 
--				state_next <= start;
--			end if; 		 
--	end case;
	
--end process;


--process (output_calc_next) 
--begin
--	output <= std_logic_vector( to_unsigned(output_calc_next,8) );
--end process;


process (pixel1_input,pixel2_input,pixel3_input,pixel4_input,pixel5_input,pixel6_input, pixel7_input, pixel8_input) 
begin
	output <= std_logic_vector(to_unsigned (
		to_integer(unsigned(pixel1_input)) * kernel(0) +
		to_integer(unsigned(pixel2_input)) * kernel(1) +
		to_integer(unsigned(pixel3_input)) * kernel(2) +
		to_integer(unsigned(pixel4_input)) * kernel(3) +
		to_integer(unsigned(pixel5_input)) * kernel(4) +
		to_integer(unsigned(pixel6_input)) * kernel(5) +
		to_integer(unsigned(pixel7_input)) * kernel(6) +
		to_integer(unsigned(pixel8_input)) * kernel(7) +
		to_integer(unsigned(pixel9_input)) * kernel(8)
	, output'length));


--	to_integer(unsigned(pixel1_input)) ) );-- *kernel(0);-- + to_integer(signed(pixel2_input))*kernel(1) ;--+ pixel3_input*kernel(2) + pixel4_input*kernel(3) + pixel5_input*kernel(4) + pixel6_input*kernel(5) + pixel7_input*kernel(6) + pixel8_input*kernel(7) + pixel9_input*kernel(8);
end process;


end Behavioral;

