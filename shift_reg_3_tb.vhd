--------------------------------------------------------------------------------
-- roberto@eletronica.org
-- Create Date:   20:47:44 12/06/2018  
-- Module Name:   /home/robertoalcantara/Documents/Xilinx/Conv/shift_reg_3_tb.vhd
-- Project Name:  Conv
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY shift_reg_3_tb IS
END shift_reg_3_tb;
 
ARCHITECTURE behavior OF shift_reg_3_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT shift_reg_3
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         input : IN  std_logic_vector(7 downto 0);
         pixel1 : OUT  std_logic_vector(7 downto 0);
         pixel2 : OUT  std_logic_vector(7 downto 0);
         pixel3 : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
   signal input : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal pixel1 : std_logic_vector(7 downto 0);
   signal pixel2 : std_logic_vector(7 downto 0);
   signal pixel3 : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant clk_period : time := 1 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: shift_reg_3 PORT MAP (
          clk => clk,
          reset => reset,
          input => input,
          pixel1 => pixel1,
          pixel2 => pixel2,
          pixel3 => pixel3
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for 1 ns;
		clk <= '1';
		wait for 1 ns;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
   
	  reset <= '1';
	  wait for 2 ns;
	  reset <= '0';
   
	  input <= "10101010";

      wait;
   end process;

END;
