----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    04:40:41 12/13/2018 
-- Design Name: 
-- Module Name:    conv_top - Behavioral 
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity conv_top is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC);
end conv_top;

architecture Behavioral of conv_top is


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

	signal conv_in : std_logic_vector(7 downto 0) := (others => '0');
	signal clk_conv : std_logic;
	signal fb_in_addr : std_logic_vector(10 downto 0);
	signal fb_out_addr : std_logic_vector(10 downto 0);
	signal fb_out_we : std_logic;
	 
	 
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
	 
   signal input_sr1 : std_logic_vector(7 downto 0) := (others => '0'); 
   signal pixel1_sr1 : std_logic_vector(7 downto 0);
   signal pixel2_sr1 : std_logic_vector(7 downto 0);
   signal pixel3_sr1 : std_logic_vector(7 downto 0);
   signal pixel1_sr2 : std_logic_vector(7 downto 0);
   signal pixel2_sr2 : std_logic_vector(7 downto 0);
   signal pixel3_sr2 : std_logic_vector(7 downto 0);
   signal pixel1_sr3 : std_logic_vector(7 downto 0);
   signal pixel2_sr3 : std_logic_vector(7 downto 0);
   signal pixel3_sr3 : std_logic_vector(7 downto 0);	
	
	
	COMPONENT read_image_VHDL
    PORT(
         clock : IN  std_logic;
         data : IN  std_logic_vector(7 downto 0);
         rdaddress : IN  std_logic_vector(10 downto 0);
         wraddress : IN  std_logic_vector(10 downto 0);
         we : IN  std_logic;
         re : IN  std_logic;
         q : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    signal data_fbin : std_logic_vector(7 downto 0) := (others => '0');
    signal wraddress_fbin : std_logic_vector(10 downto 0) := (others => '0');
    signal rdaddress_fout : std_logic_vector(10 downto 0) := (others => '0');


	 COMPONENT conv2d
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         pixel_input : IN  std_logic_vector(7 downto 0);
         output : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;	 
    signal output_conv : std_logic_vector(7 downto 0);


begin

	control: controller PORT MAP (
          reset => reset,
          clk => clk,
          fb_in_addr => fb_in_addr,
          fb_out_addr => fb_out_addr,
          fb_out_we => fb_out_we,
          conv_in => conv_in
        );
		  
  fb_input: read_image_VHDL PORT MAP (
          clock => clk,
          data => data_fbin,
          rdaddress => fb_in_addr,
          wraddress => wraddress_fbin,
          we => '0',
          re => '1',
          q => input_sr1
        );		  
		  
	sr_1: shift_reg_3 PORT MAP (
          clk => clk,
          reset => reset,
          input => input_sr1,
          pixel1 => pixel1_sr1,
          pixel2 => pixel2_sr1,
          pixel3 => pixel3_sr1
        );		  

	sr_2: shift_reg_3 PORT MAP (
          clk => clk,
          reset => reset,
          input => pixel1_sr1,
          pixel1 => pixel1_sr2,
          pixel2 => pixel2_sr2,
          pixel3 => pixel3_sr2
        );			

	sr_3: shift_reg_3 PORT MAP (
          clk => clk,
          reset => reset,
          input => pixel1_sr2,
          pixel1 => pixel1_sr3,
          pixel2 => pixel2_sr3,
          pixel3 => pixel3_sr3
        );			  
		  
		  
	conv: conv2d PORT MAP (
          clk => clk,
          reset => reset,
          pixel_input => pixel1_sr3,
          output => output_conv
	  );
		  

  fb_output: read_image_VHDL PORT MAP (
          clock => clk,
          data => output_conv,
          rdaddress => rdaddress_fout,
          wraddress => fb_out_addr,
          we => fb_out_we,
          re => '0',
          q => open
        );				  

end Behavioral;

