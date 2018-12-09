----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:24:37 12/08/2018 
-- Design Name: 
-- Module Name:    conv2d - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity conv2d is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           pixel_input : in  STD_LOGIC_VECTOR (7 downto 0);
           output : out  STD_LOGIC_VECTOR (7 downto 0));
end conv2d;

architecture Behavioral of conv2d is
	signal cnt, cnt_next : std_logic_vector(3 downto 0);
	signal output_calc, output_calc_next: integer; 
	
	type t_kernel_const is array (0 to 8) of integer; --atencao contagem TO 
	constant kernel : t_kernel_const := ( 
	-1,-1,-1,
	-1, 8,-1,
	-1,-1,-1);
--		"00000001", "00000001", "00000001" ,
--		"00000001", "00000001", "00000001" ,
--		"00000001", "00000001", "00000001" );

	type t_state is (start, conv); 
	signal state, state_next : t_state;
	 
begin


--state and data registers
process(clk,reset)
begin
  if reset='1' then
    output_calc <= 0;
	cnt <= std_logic_vector( to_unsigned(0,4) );
	state <= start;
	
  elsif ( clk'event and clk='1') then
		cnt <= cnt_next;
		state <= state_next;
		output_calc <= output_calc_next;
  end if;
  
end process;    


--next-state logic and output logic
process(cnt, state, pixel_input)
begin

	state_next <= state;
	output_calc_next <= output_calc;
	cnt_next <= cnt;
		
	case state is
		when start =>
			cnt_next <= "0000"; 
			output_calc_next <= 0;
			state_next <= conv;

	    when conv =>
			if unsigned(cnt) /= 9 then 
				output_calc_next <= output_calc + ( kernel(to_integer(unsigned(cnt))) * to_integer(unsigned(pixel_input)) ); 
				cnt_next <= std_logic_vector(  unsigned(cnt) + 1 );
			else 
				state_next <= start;
			end if; 		 
	end case;
	
end process;


process (output_calc_next) 
begin
	output <= std_logic_vector( to_unsigned(output_calc_next,8) );
end process;


end Behavioral;

