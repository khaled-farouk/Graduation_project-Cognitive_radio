----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:55:47 06/17/2019 
-- Design Name: 
-- Module Name:    controller - Behavioral 
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


entity controller is
port( 
     clk : in std_logic;
	  sclr : in std_logic;
	  rd_en2 : out std_logic;
	  rd_en3 : out std_logic
	  );
end controller;

architecture Behavioral of controller is
signal count : std_logic_vector (6 downto 0) := "0000000"; 
begin
process ( clk , sclr)
begin
if clk'event and clk = '1' then
if sclr = '1' then
  rd_en2 <= '0';
  rd_en3 <= '0';
  count <= "0000000"; 
else
  count <= count +1;
  if count < "0011110" then
	 rd_en2 <= '0';
    rd_en3 <= '0';
  end if;
  if (count >= "0011110") and (count < "0111110") then
    rd_en2 <= '1';
    rd_en3 <= '0';
  end if;
  if (count >= "0111110") and (count < "1011110") then
    rd_en2 <= '0';
    rd_en3 <= '1';
  end if;
  if (count >= "1011110") then
    count <= "1111000";
    rd_en2 <= '0';
    rd_en3 <= '0';
  end if;
end if;
end if;
end process;
end Behavioral;

