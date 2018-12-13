--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   04:50:13 12/13/2018
-- Design Name:   
-- Module Name:   /home/robertoalcantara/Documents/Xilinx/Conv/conv_top_tb.vhd
-- Project Name:  Conv
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: conv_top
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY conv_top_tb IS
END conv_top_tb;
 
ARCHITECTURE behavior OF conv_top_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT conv_top
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';

   -- Clock period definitions
   constant clk_period : time := 1 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: conv_top PORT MAP (
          clk => clk,
          reset => reset
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
		reset <= '1';
      wait for 5 ns;	
		reset <= '0';
		
      wait for clk_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
