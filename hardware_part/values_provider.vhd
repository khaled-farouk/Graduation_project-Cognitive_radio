----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:32:35 06/17/2019 
-- Design Name: 
-- Module Name:    values_provider - Behavioral 
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity values_provider is
      port ( 
		       clk : in std_logic;
				 sclr : in std_logic;
				 zero_upper1 : in std_logic_vector ( 15 downto 0);
			  	 zero_upper2 : in std_logic_vector ( 15 downto 0);
				 zero_upper3 : in std_logic_vector ( 15 downto 0);
				 one_lower1 : in std_logic_vector ( 15 downto 0);
				 one_lower2 : in std_logic_vector ( 15 downto 0);
				 one_lower3 : in std_logic_vector ( 15 downto 0);
				 one_lower : out std_logic_vector ( 15 downto 0);
				 zero_upper : out std_logic_vector ( 15 downto 0);
				 ce1 : out std_logic;
				 ce2 : out std_logic;
				 ce3 : out std_logic
		 );
				 
end values_provider;

architecture Behavioral of values_provider is
signal enable_count : std_logic_vector (5 downto 0) := "000000";
signal count: std_logic_vector (1 downto 0) := "00";
signal finished : std_logic := '0' ;
begin
process(clk,sclr,count,finished,enable_count,zero_upper1,zero_upper2,zero_upper3,one_lower1,one_lower2,one_lower3) 
begin
if clk'event and clk = '1' then
if sclr = '1' then 
   count <= "00";
	enable_count <= "000000";
	finished <= '0';
else
   enable_count <= enable_count +1 ;
   if finished = '1' then
	   enable_count <= "000000";
	end if;
  	if (enable_count >= "100011") and (enable_count < "100110") then
	   ce1 <= '1';	
	else
	   ce1 <= '0';	
   end if;
	if (enable_count >= "000001") and (enable_count < "000100") then
	   ce2 <= '1';
	else
	   ce2 <= '0';
   end if;
	if (enable_count >= "100100") and (enable_count < "100111") then
	   ce3 <= '1';
	elsif (enable_count >= "100111")then
	   ce3 <= '0';
		finished <= '1';
   else 
	   ce3 <= '0';
   end if; 
	
   if count = "00" then 
		zero_upper <= zero_upper1;
		one_lower <= one_lower1;
		count <= "01";
   elsif count = "01" then
		zero_upper <= zero_upper2;
		one_lower <= one_lower2;
		count <= "10";	
	elsif count = "10" then
		zero_upper <= zero_upper3;
		one_lower <= one_lower3;
		count <= "11";
   end if;
end if;
end if;
end process;
end Behavioral;

