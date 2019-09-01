----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:47:32 06/20/2019 
-- Design Name: 
-- Module Name:    clk_enable - Behavioral 
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

entity clk_enable is
      port( clk : in std_logic;
		      sclr : in std_logic;
				rdy : in std_logic;
				ce : out std_logic
				);
end clk_enable;

architecture Behavioral of clk_enable is
signal count : std_logic_vector (6 downto 0) := "0000000"; 
signal start : std_logic := '0';
begin
process (clk,sclr,rdy,count,start)
begin
if clk'event and clk = '1' then
if sclr = '1' then
  ce <= '0';
  start <= '0';
  count <= "0000000";
else 
   if rdy = '1' then
	   start <= '1';
	end if;
	if start = '1' then
	   count <= count + 1 ;
	
	--------------- clk enable  ------------ 
      if count = "0001000" then
         ce <= '1';
      end if;
      if (count > "001000") and (count < "0110000" ) then
         ce <= '0' ;
      end if;
      if count = "0110000" then
         ce <= '1';
      end if;
      if (count > "0110000") and (count < "1110000" ) then
         ce <= '0' ;
      end if;
      if count = "1110000" then
         ce <= '1';
      end if;
      if (count > "1110000") then
         ce <= '0' ;
			count <= "1111011";
      end if;	
      
   -----------------------------------------------------------------  		
	end if;
end if;
end if;      
end process;

end Behavioral;

