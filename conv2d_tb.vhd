--------------------------------------------------------------------------------
-- Module Name:   /home/robertoalcantara/Documents/Xilinx/Conv/conv2d_tb.vhd
-- Project Name:  Conv
-- VHDL Test Bench Created by ISE for module: conv2d
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

 
ENTITY conv2d_tb IS
END conv2d_tb;
 
ARCHITECTURE behavior OF conv2d_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT conv2d
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         pixel_input : IN  std_logic_vector(7 downto 0);
         output : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
   signal pixel_input : std_logic_vector(7 downto 0) := (others => '0');
 	--Outputs
   signal output : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant clk_period : time := 1 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: conv2d PORT MAP (
          clk => clk,
          reset => reset,
          pixel_input => pixel_input,
          output => output
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
      wait for 1 ns;	
	  reset <= '0';
	  
	  pixel_input <= "00000010";
	 
      wait for clk_period*10;


      wait;
   end process;

END;
