----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    08:15:30 06/14/2019 
-- Design Name: 
-- Module Name:    enable - Behavioral 
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

------------------------------- enabler entity ------------------------------
entity enable is
      port (clk : in std_logic;
		      sclr : in std_logic;
		      error_num : in std_logic_vector (17 downto 0);
				error : out std_logic_vector (17 downto 0));
end enable;
------------------------------------------------------------------------------

----------------------------- enabler architecture ---------------------------
architecture Behavioral of enable is
------------------- signals definitions --------------------------------------
signal samples : std_logic_vector (4 downto 0) := "00000";
signal e : std_logic_vector (17 downto 0) := "000000000000000000";
begin
------------------------ process for get the error value ---------------------
process (clk,error_num,e,samples)
begin
----------------------- check the process after each clock--------------------
if clk'event and clk = '1' then
----------- reseting the value of error to zero after each sclr pulse --------
 if sclr = '1' then 
   samples <= "00000";
   e <= "000000000000000000" ;
------------------------------------------------------------------------------
-------------------------- if no pulse of sclr get error values --------------
 else
   samples <= samples +1;
-- only when the number of calculations is less than 16 get the error at the output-- 
   if samples < "10000" then
       e <= error_num;
   else
       samples <= "10000";
       e <= "000000000000000000" ;	
   end if;
--------------------------------------------------------------------------------------
 end if;
end if;
error <= e;
end process;
end Behavioral;
------------------------------------------------------------------------------------
