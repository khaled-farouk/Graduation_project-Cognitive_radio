----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:37:49 06/10/2019 
-- Design Name: 
-- Module Name:    selection_detection - Behavioral 
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
------------------ main entity of the whole system ---------------------
entity selection_detection is
     port ( clk : in std_logic;
				period : in std_logic_vector ( 10 downto 0);
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
				user1 : in std_logic_vector ( 7 downto 0);
				user2 : in std_logic_vector ( 7 downto 0);
				user3 : in std_logic_vector ( 7 downto 0);
				en1 : out std_logic;
				en2 : out std_logic;
				en3 : out std_logic;
				en4 : out std_logic;
				en5 : out std_logic;
				selection_finish : out std_logic;
				give_decision : out std_logic;
				done : out std_logic);
end selection_detection;
------------------------------------------------------------------------------
------------------------- The architecture of the system----------------------
architecture Behavioral of selection_detection is

----- defining the user selection module as a compenent in the system  -------
component user_selection 
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
end component;
-------------------------------------------------------------------------------

-- defining the detection (decide) module as a component in the system --------
component decide 
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
end component;
-------------------------------------------------------------------------------

-- defining the starter module that generates the upper and lower values of variances as a component--
component starter 
      port (clk : in std_logic;
		      en1 : in std_logic;
				en2 : in std_logic;
				en3 : in std_logic;
				en4 : in std_logic;
				en5 : in std_logic;
				selection_finish : in std_logic;
				period : in std_logic_vector ( 10 downto 0);
				zero_lower1 : out std_logic_vector ( 15 downto 0);
				zero_lower2 : out std_logic_vector ( 15 downto 0);
				zero_lower3 : out std_logic_vector ( 15 downto 0);
				zero_upper1 : out std_logic_vector ( 15 downto 0);
				zero_upper2 : out std_logic_vector ( 15 downto 0);
				zero_upper3 : out std_logic_vector ( 15 downto 0);
				one_lower1 : out std_logic_vector ( 15 downto 0);
				one_lower2 : out std_logic_vector ( 15 downto 0);
				one_lower3 : out std_logic_vector ( 15 downto 0);
				one_upper1 : out std_logic_vector ( 15 downto 0);
				one_upper2 : out std_logic_vector ( 15 downto 0);
				one_upper3 : out std_logic_vector ( 15 downto 0);
				sclr : out std_logic;
				enable : out std_logic
				);
end component;
---------------------------------------------------------------------------------------------------
----------------------------------- signals difinition ------------------------------------------
SIGNAL  ZL1,ZL2,ZL3,ZU1,ZU2,ZU3,OL1,OL2,OL3,OU1,OU2,OU3 : STD_LOGIC_VECTOR (15 downto 0);
SIGNAL  sclr,enable,en_1,en_2,en_3,en_4,en_5,s_f : STD_LOGIC;
--------------------------------------------------------------------------------------------------
begin
---------------------------------- user selection mapping ---------------------------------------
selection : user_selection 
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
		 en1 => en_1,
		 en2 => en_2,
		 en3 => en_3,
		 en4 => en_4,
		 en5 => en_5,
		 selection_finish => s_f
		 );
-------------------------------------------------------------------------------------------------

------------------------------------- decide mapping --------------------------------------------		 
detection : decide 
  PORT MAP (
       clk => clk,
		 sclr => sclr,
		 start => enable,
		 user1 => user1,
		 user2 => user2,
		 user3 => user3,
		 zero_lower1 => ZL1,
		 zero_lower2 => ZL2,
		 zero_lower3 => ZL3,
		 zero_upper1 => ZU1,
		 zero_upper2 => ZU2,
		 zero_upper3 => ZU3,
		 one_lower1 => OL1,
		 one_lower2 => OL2,
		 one_lower3 => OL3,
		 one_upper1 => OU1,
		 one_upper2 => OU2,
		 one_upper3 => OU3,
		 give_decision => give_decision,
		 done => done);
-------------------------------------------------------------------------------------------------

-------------------------------------- starter mapping -----------------------------------------
start_detection : starter 
  PORT MAP (
       clk => clk,
		 en1 => en_1,
		 en2 => en_2,
		 en3 => en_3,
		 en4 => en_4,
		 en5 => en_5,
		 selection_finish => s_f,
		 zero_lower1 => ZL1,
		 zero_lower2 => ZL2,
		 zero_lower3 => ZL3,
		 zero_upper1 => ZU1,
		 zero_upper2 => ZU2,
		 zero_upper3 => ZU3,
		 one_lower1 => OL1,
		 one_lower2 => OL2,
		 one_lower3 => OL3,
		 one_upper1 => OU1,
		 one_upper2 => OU2,
		 one_upper3 => OU3,
		 period => period,
		 sclr => sclr,
		 enable => enable
		 );
-------------------------------------------------------------------------------------------------
------------------ user selection outputs are also outputs of the system ------------------------
en1 <= en_1;
en2 <= en_2;
en3 <= en_3;
en4 <= en_4;
en5 <= en_5;
selection_finish <= s_f;
-------------------------------------------------------------------------------------------------
end Behavioral;

