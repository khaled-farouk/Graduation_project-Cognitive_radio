----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:41:53 06/20/2019 
-- Design Name: 
-- Module Name:    acc_mode_indicator - Behavioral 
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

entity acc_mode_indicator is
      port( clk : in std_logic;
		      sclr : in std_logic;
				rdy : in std_logic;
				theta_zero_sq : in std_logic_vector ( 15 downto 0);
			   theta_one_sq : in std_logic_vector ( 15 downto 0);
				ce : out std_logic;
				mode : out std_logic;
				th_sq : out std_logic_vector ( 15 downto 0);
				finish : out std_logic
				);
end acc_mode_indicator;

architecture Behavioral of acc_mode_indicator is
signal count : std_logic_vector (7 downto 0) := "00000000"; 
signal start : std_logic := '0';
signal c : std_logic_vector (2 downto 0) := "000";
begin
process (clk,sclr,rdy,count,start,c)
begin
if clk'event and clk = '1' then
if sclr = '1' then
  ce <= '0';
  start <= '0';
  th_sq <= "0000000000000001";
  finish <= '0' ;
  count <= "00000000";
  c <= "000";
else 
   if rdy = '1' then
	   start <= '1';
	end if;
	if start = '1' then
	   count <= count + 1 ;
	-------------------------- theta value ---------------------
		if count = "00000100" then 
			th_sq <= theta_zero_sq;
		end if;	
		if count = "00010000" then 
			th_sq <= theta_one_sq;
		end if;
		if count = "00101010" then 
			th_sq <= theta_zero_sq;
		end if;
		if count = "00111000" then 
			th_sq <= theta_one_sq;
		end if;
		if count = "01010000" then 
			th_sq <= theta_zero_sq;
		end if;
		if count = "01011110" then 
			th_sq <= theta_one_sq;
		end if;
	-------------------------------------------------------------
	--------------- clk enable and accumulation mode ------------ 
      if count = "00101000" then
         ce <= '1';
         mode <= '1';
      end if;
      if (count > "00101000") and (count < "00110100" ) then
         ce <= '0' ;
      end if;
      if count = "00110100"  then
         ce <= '1';
         mode <= '0';
      end if;
      if (count > "00110100" ) and (count < "01001110" ) then
         ce <= '0' ;
      end if;
      if count = "01001110" then
         ce <= '1';
         mode <= '1';
      end if;
      if (count > "01001110") and (count < "01011110" ) then
         ce <= '0' ;
      end if;	
      if count = "01011110" then
         ce <= '1';
         mode <= '0';
      end if;
      if (count > "01011110") and (count < "01111000" ) then
         ce <= '0' ;
      end if;
      if count = "01111000" then
         ce <= '1';
         mode <= '1';
      end if;
      if (count > "01111000") and (count < "10000100" ) then
         ce <= '0' ;
      end if;	
      if count = "10000100" then
         ce <= '1';
         mode <= '0';
      end if;
		if count > "10000100" then
		   ce <= '0' ;
			c <= c + 1;
			if c >= "100" then
			   finish <= '1';
			   c <= "101";
			end if;
			count <= "10001100";		
		end if;
   -----------------------------------------------------------------  		
	end if;
end if;
end if;      
end process;
end Behavioral;

