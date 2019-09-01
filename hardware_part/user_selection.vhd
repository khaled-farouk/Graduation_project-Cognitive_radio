----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    08:08:36 06/07/2019 
-- Design Name: 
-- Module Name:    user_selection - Behavioral 
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
----------------------- selection entity -----------------------------------------
entity user_selection is
     port ( clk : in std_logic;
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
	         en1 : out std_logic;
				en2 : out std_logic;
				en3 : out std_logic;
				en4 : out std_logic;
				en5 : out std_logic;
				selection_finish : out std_logic
				);
end user_selection;
-----------------------------------------------------------------------------------

-------------------------- architecture of user selection module ------------------
architecture Behavioral of user_selection is

------- defining the module that used to calculate all errors between vectors -----
component get_all_error_values
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
end component;
---------------------------------------------------------------------------------

----- defining the module that select the users to be enabled to cooperate ------
component selector 
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
end component;
----------------------------------------------------------------------------------
------------------------- defining the error signals -----------------------------
signal error1,error2,error3,error4,error5 : std_logic_vector(19 downto 0);
----------------------------------------------------------------------------------
begin
-------------------------- mapping the error estimator ---------------------------  
error_estimator : get_all_error_values 
  PORT MAP (
    clk => clk,
    sclr => sclr,
    rec1 => rec1,
	 rec2 => rec2, 
	 rec3 => rec3,
	 rec4 => rec4,
	 rec5 => rec5,
	 sig1 => sig1,
	 sig2 => sig2,
	 sig3 => sig3,
	 sig4 => sig4,
	 sig5 => sig5,
	 error1 => error1,
	 error2 => error2,
	 error3 => error3,
	 error4 => error4,
	 error5 => error5
  );  
-------------------------------------------------------------------------------  
------------------------ mapping the selector ---------------------------------
final_selection : selector
  PORT MAP (
    clk => clk,
	 sclr => sclr,
    error1 => error1,
	 error2 => error2,
	 error3 => error3,
	 error4 => error4,
	 error5 => error5,
	 en1 => en1,
	 en2 => en2,
	 en3 => en3,
	 en4 => en4,
	 en5 => en5,
	 selection_finish => selection_finish
  );
--------------------------------------------------------------------------------
end Behavioral;
--------------------------------------------------------------------------------
