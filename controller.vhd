----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    03:22:14 12/13/2018 
-- Design Name: 
-- Module Name:    controller - Behavioral 
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

entity controller is
    Port ( reset : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           fb_in_addr : out  STD_LOGIC_VECTOR (10 downto 0);
           fb_out_addr : out  STD_LOGIC_VECTOR (10 downto 0);
           fb_out_we : out  STD_LOGIC;
           conv_in : in  STD_LOGIC_VECTOR (7 downto 0));
end controller;

architecture Behavioral of controller is

	constant LINE_SIZE: integer:= 66; --imagem tem 64, com padding fica 66
	constant PIXELS_TO_VALID: integer := LINE_SIZE*3; -- para ter uma saida valida preenche 3 linhas
	constant TOTAL_PIXELS: integer := 4356;
	signal cnt, cnt_next: integer;
	
	type t_state is (start, out_valid, done); 
	signal state, state_next : t_state;
	
	signal fb_out_we_reg, fb_out_we_next : STD_LOGIC;
	signal fb_out_addr_reg, fb_out_addr_reg_next: STD_LOGIC_VECTOR (10 downto 0);
	
	
begin



--state and data registers
process(clk,reset)
begin
  if reset='1' then
	cnt <= 0;
	state <= start;
	fb_out_we_reg <= '0';
	fb_out_addr_reg <= (others=>'0');
	
  elsif ( clk'event and clk='1') then
		cnt <= cnt_next;
		state <= state_next;
		fb_out_we_reg <= fb_out_we_next;
		fb_out_addr_reg <= fb_out_addr_reg_next;
  end if;
  
end process;    



--next-state logic and output logic
process(cnt, state)
begin

	state_next <= state;
	cnt_next <= cnt;
	fb_out_we_next <= fb_out_we_reg;
	fb_out_addr_reg_next <= fb_out_addr_reg;
		
	case state is
		when start =>
			if (cnt = PIXELS_TO_VALID-1)  then
				state_next <= out_valid;
				fb_out_we_next <= '1'; --inicia a gravacao no fb de saida
			end if;
			cnt_next <= cnt + 1; 

		when out_valid =>
			fb_out_addr_reg_next <= std_logic_vector(to_unsigned(   to_integer(unsigned(fb_out_addr_reg))+1  ,fb_out_addr_reg_next'length))  ;
			
			if (cnt /= TOTAL_PIXELS-1) then
				cnt_next <= cnt + 1;
			else
				state_next <= done;
			end if;

		when done =>
			fb_out_we_next <= '0'; --finaliza a gravacao no fb de saida
			state_next <= done;	--do nothing, wait reset
			
	end case;

end process;


process (cnt)
begin
	fb_in_addr <= std_logic_vector( to_unsigned(cnt, fb_in_addr'length) );
end process;

process( fb_out_we_reg, fb_out_addr_reg )
begin
	fb_out_we <= fb_out_we_reg;
	fb_out_addr <= fb_out_addr_reg;
end process;


end Behavioral;

