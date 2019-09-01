----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:04:04 06/13/2019 
-- Design Name: 
-- Module Name:    get_all_error_values - Behavioral 
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
--------------- error estimator (get_all_error_values) entity ----------------
entity get_all_error_values is
  PORT (
    clk : IN STD_LOGIC;
	 sclr : in std_logic;
    rec1 : in std_logic_vector ( 7 downto 0);
	 rec2 : in std_logic_vector ( 7 downto 0);
	 rec3 : in std_logic_vector ( 7 downto 0);
	 rec4 : in std_logic_vector ( 7 downto 0);
	 rec5 : in std_logic_vector ( 7 downto 0);
	 sig1 : in std_logic_vector ( 7 downto 0);
	 sig2 : in std_logic_vector ( 7 downto 0);
    sig3 : in std_logic_vector ( 7 downto 0);
	 sig4 : in std_logic_vector ( 7 downto 0);
	 sig5 : in std_logic_vector ( 7 downto 0);
    error1: OUT STD_LOGIC_VECTOR(19 DOWNTO 0);
	 error2: OUT STD_LOGIC_VECTOR(19 DOWNTO 0);
	 error3: OUT STD_LOGIC_VECTOR(19 DOWNTO 0);
	 error4: OUT STD_LOGIC_VECTOR(19 DOWNTO 0);
	 error5: OUT STD_LOGIC_VECTOR(19 DOWNTO 0)
  );
end get_all_error_values;
-------------------------------------------------------------------------------

--------------------- architecture of error estimator -------------------------
architecture Behavioral of get_all_error_values is

------------------ defining the error calculator module as a component ---------
component error_calculator 
  PORT (
    clk : IN STD_LOGIC;
	 sclr : in std_logic;
    sig_vector : in std_logic_vector (7 downto 0);
	 orginal_vector : in std_logic_vector (7 downto 0);
    error: OUT STD_LOGIC_VECTOR(19 DOWNTO 0)
  );
end component;
--------------------------------------------------------------------------------

begin
------------------------------ first error calculator mapping ------------------
first_signal_error : error_calculator
  PORT MAP (
    clk => clk,
	 sclr => sclr,
	 sig_vector => sig1,
    orginal_vector => rec1,
    error => error1
  );
--------------------------------------------------------------------------------

------------------------------ second error calculator mapping ------------------
second_signal_error : error_calculator
  PORT MAP (
    clk => clk,
	 sclr => sclr,
	 sig_vector => sig2,
    orginal_vector => rec2,
    error => error2
  );
--------------------------------------------------------------------------------  

------------------------------ third error calculator mapping ------------------
third_signal_error : error_calculator
  PORT MAP (
    clk => clk,
	 sclr => sclr,
	 sig_vector => sig3,
    orginal_vector => rec3,
    error => error3
  );
--------------------------------------------------------------------------------  

------------------------------ fourth error calculator mapping ------------------ 
fourth_signal_error : error_calculator
  PORT MAP (
    clk => clk,
	 sclr => sclr,
	 sig_vector => sig4,
    orginal_vector => rec4,
    error => error4
  );
--------------------------------------------------------------------------------  

------------------------------ fifth error calculator mapping ------------------ 
fifth_signal_error : error_calculator
  PORT MAP (
    clk => clk,
	 sclr => sclr,
	 sig_vector => sig5,
    orginal_vector => rec5,
    error => error5
  );
--------------------------------------------------------------------------------  
end Behavioral;
--------------------------------------------------------------------------------  
