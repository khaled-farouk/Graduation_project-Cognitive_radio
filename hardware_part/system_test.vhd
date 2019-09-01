--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   21:34:26 06/15/2019
-- Design Name:   
-- Module Name:   H:/project/presentation/final/system_test.vhd
-- Project Name:  final
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: selection_detection
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;
 
ENTITY system_test IS
END system_test;
 
ARCHITECTURE behavior OF system_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT selection_detection
    PORT(
         clk : IN  std_logic;
         period : IN  std_logic_vector(10 downto 0);
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
         user1 : IN  std_logic_vector(7 downto 0);
         user2 : IN  std_logic_vector(7 downto 0);
         user3 : IN  std_logic_vector(7 downto 0);
         en1 : OUT  std_logic;
         en2 : OUT  std_logic;
         en3 : OUT  std_logic;
         en4 : OUT  std_logic;
         en5 : OUT  std_logic;
         selection_finish : OUT  std_logic;
         give_decision : OUT  std_logic;
         done : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   constant period : std_logic_vector(10 downto 0) := std_logic_vector(to_unsigned(496, 11));
   signal rec1 : std_logic_vector(7 downto 0) := "01010101";
   signal rec2 : std_logic_vector(7 downto 0) := "11000111";
   signal rec3 : std_logic_vector(7 downto 0) := "10110111";
   signal rec4 : std_logic_vector(7 downto 0) := "00001101";
   signal rec5 : std_logic_vector(7 downto 0) := "01111110";
   signal sig1 : std_logic_vector(7 downto 0) := "01100100";
   signal sig2 : std_logic_vector(7 downto 0) := "10101010";
   signal sig3 : std_logic_vector(7 downto 0) := "00011110";
   signal sig4 : std_logic_vector(7 downto 0) := "10000010";
   signal sig5 : std_logic_vector(7 downto 0) := "10110001";
   signal user1 : std_logic_vector(7 downto 0) := "00100001";
   signal user2 : std_logic_vector(7 downto 0) := "00110001";
   signal user3 : std_logic_vector(7 downto 0) := "00011011";

 	--Outputs
   signal en1 : std_logic;
   signal en2 : std_logic;
   signal en3 : std_logic;
   signal en4 : std_logic;
   signal en5 : std_logic;
   signal selection_finish : std_logic;
   signal give_decision : std_logic;
   signal done : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: selection_detection PORT MAP (
          clk => clk,
          period => period,
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
          user1 => user1,
          user2 => user2,
          user3 => user3,
          en1 => en1,
          en2 => en2,
          en3 => en3,
          en4 => en4,
          en5 => en5,
          selection_finish => selection_finish,
          give_decision => give_decision,
          done => done
        );

   -- Clock process definitions
   clk_process :process
   begin
	   rec1 <= rec2 + 4;
		rec2 <= rec4 - 23;
		rec3 <= rec5 + 11;
		rec4 <= rec1 + 26;
		rec5 <= rec3 - 9;
		sig1 <= sig5 + 18;
		sig2 <= sig4 - 12;
		sig3 <= sig1 + 21;
		sig4 <= sig2 - 33;
		sig5 <= sig3 + 24;
		user1 <= user3 - 4 ;
		user2 <= user1 + 3 ;
		user3 <= user2 - 2 ;
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
		
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for clk_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
