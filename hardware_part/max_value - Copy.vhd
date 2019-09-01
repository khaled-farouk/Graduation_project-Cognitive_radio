----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:27:36 03/14/2019 
-- Design Name: 
-- Module Name:    max_value - Behavioral 
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
use ieee.std_logic_unsigned.all;

entity max_value is
     port( clk : in std_logic;
	        lower_value : in std_logic_vector (15 downto 0);
			  min_val : in std_logic_vector (15 downto 0);
			  max_val : out std_logic_vector (15 downto 0));
end max_value;

architecture Behavioral of max_value is
signal temp2 : std_logic_vector (15 downto 0):= (others => '0');
begin
process( clk,lower_value,min_val,temp2)
begin
    if clk'event and clk = '1' then
       if lower_value > min_val then
		    temp2 <= lower_value;
		 else
			 temp2 <= min_val;
		 end if;
	 end if;
	 max_val <= temp2;
end process;
end Behavioral;

