----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    07:03:55 03/16/2019 
-- Design Name: 
-- Module Name:    decide - Behavioral 
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
-------------------------------- decide entity -----------------------------------
entity decide is
     port ( clk : in std_logic;
	         sclr : in std_logic;
	         start : in std_logic;
	         user1 : in std_logic_vector ( 7 downto 0);
				user2 : in std_logic_vector ( 7 downto 0);
				user3 : in std_logic_vector ( 7 downto 0);
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
	         give_decision : out std_logic;
				done : out std_logic);
	         
end decide;
------------------------------------------------------------------------------------
--------------------------- decide architecture ------------------------------------
architecture Behavioral of decide is
---------- defining the threshold module as a component of the decide module -------
component threshold 
      port ( clk : in std_logic;
		       sclr : in std_logic;
				 zero_upper1 : in std_logic_vector ( 15 downto 0);
			  	 zero_upper2 : in std_logic_vector ( 15 downto 0);
				 zero_upper3 : in std_logic_vector ( 15 downto 0);
				 one_lower1 : in std_logic_vector ( 15 downto 0);
				 one_lower2 : in std_logic_vector ( 15 downto 0);
				 one_lower3 : in std_logic_vector ( 15 downto 0);
				 threshold_int : out std_logic_vector (9 downto 0);
				 threshold_fraction : out std_logic_vector (24 downto 0)
				 );
end component;
------------------------------------------------------------------------------------

--------------------- log likelihood ratio module as a component -------------------
component llr 
   port ( clk : in std_logic;
	       start : in std_logic;
			 sclr : in std_logic;
	       user1 : in std_logic_vector ( 7 downto 0);
			 user2 : in std_logic_vector ( 7 downto 0);
			 user3 : in std_logic_vector ( 7 downto 0);
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
	       llr_quotient : out STD_LOGIC_VECTOR (19 downto 0);
			 llr_fraction : out STD_LOGIC_VECTOR (11 downto 0);
			 finish : out std_logic);		  
end component;
-----------------------------------------------------------------------------------

----------  defining a decision module that compares between threshold and llr ----
component decision 
    port( clk : in std_logic;
	       threshold_int : IN std_logic_vector (9 downto 0);
			 threshold_fraction : IN std_logic_vector (24 downto 0);
			 llr_quotient : IN STD_LOGIC_VECTOR (19 downto 0);
			 llr_fraction : IN STD_LOGIC_VECTOR (11 downto 0);
			 dec : out std_logic);		
end component;
-------------------------------------------------------------------------------------

-------------------------------- signal definition ----------------------------------
SIGNAL  thr_q : STD_LOGIC_VECTOR (9 downto 0);
SIGNAL  thr_f : STD_LOGIC_VECTOR (24 downto 0);
SIGNAL  llr_q : STD_LOGIC_VECTOR (19 downto 0);
SIGNAL  llr_f : STD_LOGIC_VECTOR (11 downto 0);
-------------------------------------------------------------------------------------
begin
---------------------------------- threshold mapping --------------------------------
threshold_value : threshold 
  PORT MAP (
     clk => clk, 
     sclr => sclr,
	  zero_upper1 => zero_upper1,
	  zero_upper2 => zero_upper2,
	  zero_upper3 => zero_upper3,
	  one_lower1 =>  one_lower1,
	  one_lower2 =>  one_lower2,
	  one_lower3 =>  one_lower3,
	  threshold_int => thr_q,
	  threshold_fraction => thr_f
	  );
-------------------------------------------------------------------------------------

------------------------- log likelihood ratio mapping ------------------------------	  
LLR_map : llr
  PORT MAP (
     clk => clk,
	  start => start,
	  sclr => sclr,
	  user1 => user1,
	  user2 => user2,
	  user3 => user3,
	  zero_lower1 => zero_lower1,
	  zero_lower2 => zero_lower2,
	  zero_lower3 => zero_lower3,
	  zero_upper1 => zero_upper1,
	  zero_upper2 => zero_upper2,
	  zero_upper3 => zero_upper3,
	  one_lower1 =>  one_lower1,
	  one_lower2 =>  one_lower2,
	  one_lower3 =>  one_lower3,
	  one_upper1 =>  one_upper1,
	  one_upper2 =>  one_upper2,
	  one_upper3 =>  one_upper3,
	  llr_quotient => llr_q,
	  llr_fraction => llr_f,
     finish => done
	  );
------------------------------------------------------------------------------------

------------------------------- decesion module mapping ----------------------------	  
decesion_module_map : decision
  PORT MAP (
     clk => clk,
	  threshold_int => thr_q,
	  threshold_fraction => thr_f,
	  llr_quotient => llr_q,
	  llr_fraction => llr_f,
	  dec => give_decision
	  );
-------------------------------------------------------------------------------------	  
end Behavioral;
-------------------------------------------------------------------------------------
