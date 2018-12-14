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
         pixel1_input : IN  std_logic_vector(7 downto 0);
			pixel2_input : IN  std_logic_vector(7 downto 0);
         pixel3_input : IN  std_logic_vector(7 downto 0);
         pixel4_input : IN  std_logic_vector(7 downto 0);
			pixel5_input : IN  std_logic_vector(7 downto 0);
         pixel6_input : IN  std_logic_vector(7 downto 0);
         pixel7_input : IN  std_logic_vector(7 downto 0);
			pixel8_input : IN  std_logic_vector(7 downto 0);
         pixel9_input : IN  std_logic_vector(7 downto 0);

         output : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
   signal pixel1_input : std_logic_vector(7 downto 0) := (others => '0');
   signal pixel2_input : std_logic_vector(7 downto 0) := (others => '0');
   signal pixel3_input : std_logic_vector(7 downto 0) := (others => '0');
   signal pixel4_input : std_logic_vector(7 downto 0) := (others => '0');
   signal pixel5_input : std_logic_vector(7 downto 0) := (others => '0');
   signal pixel6_input : std_logic_vector(7 downto 0) := (others => '0');
   signal pixel7_input : std_logic_vector(7 downto 0) := (others => '0');
	signal pixel8_input : std_logic_vector(7 downto 0) := (others => '0');
   signal pixel9_input : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal output : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant clk_period : time := 1 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: conv2d PORT MAP (
          clk => clk,
          reset => reset,
          pixel1_input => pixel1_input,
			 pixel2_input => pixel2_input,
			 pixel3_input => pixel3_input,
			 pixel4_input => pixel4_input,
			 pixel5_input => pixel5_input,
			 pixel6_input => pixel6_input,
			 pixel7_input => pixel7_input,
			 pixel8_input => pixel8_input,
			 pixel9_input => pixel9_input,
			 

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
	  
	  pixel1_input <= "00000001";
 	  pixel2_input <= "00000010";
	  pixel3_input <= "00000011";
	  pixel4_input <= "00000100";
	  pixel5_input <= "00000101";
	  pixel6_input <= "00000110";
	  pixel7_input <= "00000111";
	  pixel8_input <= "00001000";
	  pixel9_input <= "00001001";

      wait for clk_period*10;


      wait;
   end process;

END;
