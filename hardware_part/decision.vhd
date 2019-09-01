----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    07:08:57 03/16/2019 
-- Design Name: 
-- Module Name:    decision - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;

entity decision is
    port( clk : in std_logic;
	       threshold_int : IN std_logic_vector (9 downto 0);
			 threshold_fraction : IN std_logic_vector (24 downto 0);
			 llr_quotient : IN STD_LOGIC_VECTOR (19 downto 0);
			 llr_fraction : IN STD_LOGIC_VECTOR (11 downto 0);
			 dec : out std_logic);			
end decision;

architecture Behavioral of decision is
signal temp1 : std_logic_vector (34 downto 0):= (others => '0');
signal temp2 : std_logic_vector (44 downto 0):= (others => '0');
signal temp : std_logic := '0' ;
begin
process(clk, threshold_int,threshold_fraction,llr_quotient,llr_fraction,temp1,temp2,temp)
begin
temp1(34 downto 25) <= threshold_int;
temp1(24 downto 0) <= threshold_fraction;
temp2(44 downto 25) <= llr_quotient;
temp2(24 downto 13) <= llr_fraction;
temp2(12 downto 0) <= (others => '0');
if clk'event and clk = '1' then
   if signed(temp2) > signed(temp1) then
	    dec <= '1' ;
   else
	    dec <= '0' ;	
   end if;
end if;
end process;	
end Behavioral;

