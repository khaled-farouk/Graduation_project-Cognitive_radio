----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    07:30:44 06/17/2019 
-- Design Name: 
-- Module Name:    signal_selector - Behavioral 
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

entity signal_selector is
  PORT (
    clk : in std_logic;
	 sclr : in std_logic;
	 din1 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	 din2 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	 din3 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	 rdy1 : in std_logic;
	 rdy2 : in std_logic;	  
	 rdy3 : in std_logic;
	 zero_lower1 : in std_logic_vector ( 15 downto 0);
	 zero_lower2 : in std_logic_vector ( 15 downto 0);
	 zero_lower3 : in std_logic_vector ( 15 downto 0);
	 zero_upper1 : in std_logic_vector ( 15 downto 0);
	 zero_upper2 : in std_logic_vector ( 15 downto 0);
	 zero_upper3 : in std_logic_vector ( 15 downto 0);
	 one_lower1 : in std_logic_vector ( 15 downto 0);
	 one_lower2 : in std_logic_vector ( 15 downto 0);
	 one_lower3 : in std_logic_vector ( 15 downto 0);
	 one_upper1 : in std_logic_vector ( 15 downto 0);
	 one_upper2 : in std_logic_vector ( 15 downto 0);
	 one_upper3 : in std_logic_vector ( 15 downto 0);
    sig : out STD_LOGIC_VECTOR(7 DOWNTO 0);
	 zero_lower : out std_logic_vector ( 15 downto 0); 
	 zero_upper : out std_logic_vector ( 15 downto 0);
	 one_lower : out std_logic_vector ( 15 downto 0);
	 one_upper : out std_logic_vector ( 15 downto 0)
  );
end signal_selector;

architecture Behavioral of signal_selector is
signal count : std_logic_vector (6 downto 0) := "0000000"; 
begin
process (clk,sclr,din1,din2,din3,zero_lower1,zero_lower2,zero_lower3,one_upper1,one_upper2,one_upper3,zero_upper1,zero_upper2,zero_upper3,one_lower1,one_lower2,one_lower3)
begin
if clk'event and clk = '1' then
if sclr = '1' then
  count <= "0000000";
  sig <= "00000000";
  zero_lower <= "0000000000000000";
  zero_upper <= "0000000000000000";
  one_lower <= "0000000000000000";
  one_upper <= "0000000000000000";
else 
  count <= count + 1;
  if rdy1 = '1' then
    zero_lower <= zero_lower1;
	 zero_upper <= zero_upper1;
	 one_lower <= one_lower1;
	 one_upper <= one_upper1; 
  end if;
  if rdy2 = '1' then
    zero_lower <= zero_lower2;
	 zero_upper <= zero_upper2;
	 one_lower <= one_lower2;
	 one_upper <= one_upper2; 
  end if;
  if rdy3 = '1' then
    zero_lower <= zero_lower3;
	 zero_upper <= zero_upper3;
	 one_lower <= one_lower3;
	 one_upper <= one_upper3; 
  end if;
  
  if count < "0100000" then
	 sig <= din1;
  end if;
  if (count >= "0100000") and (count < "1000000") then
    sig <= din2;
  end if;
  if (count >= "1000000") and (count < "1100000") then
    sig <= din3;
  end if;
  if (count >= "1100000") then
    count <= "1111100";
    sig <= "00000000";
  end if;
end if;
end if;      
end process;


end Behavioral;

