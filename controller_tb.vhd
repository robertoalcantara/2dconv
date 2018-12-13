--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   04:10:09 12/13/2018
-- Design Name:   
-- Module Name:   /home/robertoalcantara/Documents/Xilinx/Conv/controller_tb.vhd
-- Project Name:  Conv
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: controller
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
 
ENTITY controller_tb IS
END controller_tb;
 
ARCHITECTURE behavior OF controller_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT controller
    PORT(
         reset : IN  std_logic;
         clk : IN  std_logic;
         fb_in_addr : OUT  std_logic_vector(10 downto 0);
         fb_out_addr : OUT  std_logic_vector(10 downto 0);
         fb_out_we : OUT  std_logic;
         conv_in : IN  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal reset : std_logic := '0';
   signal clk : std_logic := '0';
   signal conv_in : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal clk_conv : std_logic;
   signal fb_in_addr : std_logic_vector(10 downto 0);
   signal fb_out_addr : std_logic_vector(10 downto 0);
   signal fb_out_we : std_logic;

   -- Clock period definitions
   constant clk_period : time := 2 ns; 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: controller PORT MAP (
          reset => reset,
          clk => clk,
          clk_conv => clk_conv,
          fb_in_addr => fb_in_addr,
          fb_out_addr => fb_out_addr,
          fb_out_we => fb_out_we,
          conv_in => conv_in
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
      -- hold reset state for 100 ns.
		reset <= '1';
      wait for 5 ns;
		reset <= '0';		
      -- insert stimulus here 

      wait;
   end process;

END;
