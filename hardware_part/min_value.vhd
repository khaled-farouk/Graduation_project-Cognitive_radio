----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:18:51 03/14/2019 
-- Design Name: 
-- Module Name:    min_value - Behavioral 
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

entity min_value is
     port( clk : in std_logic;
	        ed : in std_logic_vector (15  downto 0);
			  upper_value : in std_logic_vector (15  downto 0);
			  min_val : out std_logic_vector (15 downto 0));
end min_value;

architecture Behavioral of min_value is
signal temp1 : std_logic_vector (15 downto 0):= (others => '0');

begin
process( clk,ed,upper_value,temp1)
begin
    if clk'event and clk = '1' then
       if upper_value > ed then
		    temp1 <= ed;
		 else
			 temp1 <= upper_value;
		 end if;
	 end if;
	 min_val <= temp1;
end process;
end Behavioral;

