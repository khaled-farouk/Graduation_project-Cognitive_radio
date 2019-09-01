----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:53:58 06/07/2019 
-- Design Name: 
-- Module Name:    selector - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;
----------------------------- selector entity -------------------------------------
entity selector is
      port (clk : in std_logic;
		      sclr : in std_logic;
		      error1 : in std_logic_vector (19 downto 0);
				error2 : in std_logic_vector (19 downto 0);
				error3 : in std_logic_vector (19 downto 0);
				error4 : in std_logic_vector (19 downto 0);
				error5 : in std_logic_vector (19 downto 0);
				en1 : out std_logic;
				en2 : out std_logic;
				en3 : out std_logic;
				en4 : out std_logic;
				en5 : out std_logic;
				selection_finish : out std_logic
				);
end selector;
-----------------------------------------------------------------------------------
-------------------------------- selector architecture ----------------------------
architecture Behavioral of selector is
----------------------------- signal definition -----------------------------------
signal samples : std_logic_vector (4 downto 0) := "00000";
-----------------------------------------------------------------------------------
begin
---------------------- process of selection ---------------------------------------
process (clk,error1,error2,error3,error4,error5,samples,sclr)
begin
if clk'event and clk = '1' then
----------------------- reseting all values if sclr pulse come --------------------
 if sclr = '1' then
          samples <= "00000";
          en1 <= '0';
			 en2 <= '0';
			 en3 <= '0';
			 en4 <= '0';
			 en5 <= '0';
			 selection_finish <= '0';
-------------- get enable bits and selection finish indicator if no sclr pulse ----
 else
 samples <= samples +1;
----------- outputs are zeros if the number of operations is less than 32 ---------
   if samples < "10000" then 
          en1 <= '0';
			 en2 <= '0';
			 en3 <= '0';
			 en4 <= '0';
			 en5 <= '0';
			 selection_finish <= '0';
------------------------------ after calculations finished get enable bits ----------
---------------------------- select the 3 users with the least error values ---------
   else
     samples <= "10000";
	  selection_finish <= '1';
     if (error1 >= error3)  and (error2 >= error3) and (error1 >= error4) and (error2 >= error4) and (error1 >= error5) and (error2 >= error5)then
		    en1 <= '0';
			 en2 <= '0';
			 en3 <= '1';
			 en4 <= '1';
			 en5 <= '1';
      elsif (error1 >= error2)  and (error3 >= error2) and (error1 >= error4) and (error3 >= error4)  and (error1 >= error5) and (error3 >= error5)then
			 en1 <= '0';
			 en2 <= '1';
			 en3 <= '0';
			 en4 <= '1';
			 en5 <= '1';
      elsif (error1 >= error3)  and (error4 >= error3) and (error1 >= error2) and (error4 >= error2)  and (error1 >= error5) and (error4 >= error5)then
			 en1 <= '0';
			 en2 <= '1';
			 en3 <= '1';
			 en4 <= '0';
			 en5 <= '1';
      elsif (error1 >= error2)  and (error5 >= error2) and (error1 >= error4) and (error5 >= error4)  and (error1 >= error3) and (error5 >= error3)then
			 en1 <= '0';
			 en2 <= '1';
			 en3 <= '1';
			 en4 <= '1';
			 en5 <= '0';
      elsif (error2 >= error1)  and (error3 >= error1) and (error2 >= error4) and (error3 >= error4) and (error2 >= error5) and (error3 >= error5)  then
			 en1 <= '1';
			 en2 <= '0';
			 en3 <= '0';
			 en4 <= '1';
			 en5 <= '1';
      elsif (error2 >= error1)  and (error4 >= error1) and (error2 >= error3) and (error4 >= error3) and (error2 >= error5) and (error4 >= error5)  then
			 en1 <= '1';
			 en2 <= '0';
			 en3 <= '1';
			 en4 <= '0';
			 en5 <= '1';
      elsif (error2 >= error1)  and (error5 >= error1) and (error2 >= error4) and (error5 >= error4) and (error2 >= error3) and (error5 >= error3)  then
			 en1 <= '1';
			 en2 <= '0';
			 en3 <= '1';
			 en4 <= '1';
			 en5 <= '0';
      elsif (error4 >= error1)  and (error3 >= error1) and (error4 >= error2) and (error3 >= error2) and (error4 >= error5) and (error3 >= error5)  then
			 en1 <= '1';
			 en2 <= '1';
			 en3 <= '0';
			 en4 <= '0';
			 en5 <= '1';
      elsif (error3 >= error1)  and (error5 >= error1) and (error3 >= error4) and (error5 >= error4) and (error3 >= error2) and (error5 >= error2)  then
			 en1 <= '1';
			 en2 <= '1';
			 en3 <= '0';
			 en4 <= '1';
			 en5 <= '0';
      else
			 en1 <= '1';
			 en2 <= '1';
			 en3 <= '1';
			 en4 <= '0';
			 en5 <= '0';
      end if;
------------------------------------------------------------------------------------------------
  end if;
 end if;
end if;
end process;
end Behavioral;
------------------------------------------------------------------------------------------------
