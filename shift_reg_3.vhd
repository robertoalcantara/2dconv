----------------------------------------------------------------------------------
-- roberto@eletronica.org
-- Create Date:    20:08:45 12/06/2018 
-- Module Name:    shift_reg_3 - Behavioral 

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity shift_reg_3 is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           input : in  STD_LOGIC_VECTOR (7 downto 0);
           pixel1 : out  STD_LOGIC_VECTOR (7 downto 0);
           pixel2 : out  STD_LOGIC_VECTOR (7 downto 0);
           pixel3 : out  STD_LOGIC_VECTOR (7 downto 0));
end shift_reg_3;

architecture Behavioral of shift_reg_3 is

	constant LINE_SIZE: integer:= 66; --imagem tem 64, com padding fica 66

	type t_array is array (0 to LINE_SIZE-1) of std_logic_vector(7 downto 0);
	
	signal mem : t_array; -- 66x66, imagem 64x64 com padding
	signal pixel1_next : std_logic_vector(7 downto 0);
	signal pixel2_next : std_logic_vector(7 downto 0);
	signal pixel3_next : std_logic_vector(7 downto 0);
	signal input_next: std_logic_vector(7 downto 0);

begin
	
--state and data registers
process(clk,reset)
begin
  if reset='1' then
		pixel1 <= (others=>'0');		
		pixel2 <= (others=>'0');
		pixel3 <= (others=>'0');
		for cnt in 0 to LINE_SIZE-1 loop 
			mem(cnt) <= "00000000";
		end loop;
		
  elsif ( clk'event and clk='1') then
	
	for cnt in 0 to LINE_SIZE-2 loop 
		mem(cnt) <= mem(cnt+1);
	end loop;
	mem(LINE_SIZE-1) <= input_next;
   pixel1 <= pixel1_next;
   pixel2 <= pixel2_next;
   pixel3 <= pixel3_next;	
  
  end if;
  
end process;    


--next-state logic and output logic
process(input,mem(0),mem(1),mem(2), mem(3))
begin
	input_next <= input;
	pixel3_next <= mem(1);
   pixel2_next <= mem(2);
   pixel1_next <= mem(3);
end process;



end Behavioral;

