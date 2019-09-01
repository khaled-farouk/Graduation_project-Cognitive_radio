----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    04:12:11 06/13/2019 
-- Design Name: 
-- Module Name:    final_threshold_calculation - Behavioral 
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
library UNISIM;
use UNISIM.VComponents.all;

entity final_threshold_calculation is
      port ( clk : in std_logic;		
             first_term_value : in std_logic_vector (17 downto 0);
             second_term_value : in std_logic_vector (34 downto 0);
             third_term_value : in std_logic_vector (18 downto 0);				 
		       threshold_vector : out std_logic_vector (34 downto 0));
end final_threshold_calculation;

architecture Behavioral of final_threshold_calculation is
COMPONENT final_mult
  PORT (
    a : IN STD_LOGIC_VECTOR(18 DOWNTO 0);
    p : OUT STD_LOGIC_VECTOR(29 DOWNTO 0)
  );
END COMPONENT;

attribute box_type : string;
attribute box_type of final_mult : component is "black_box";

COMPONENT final_adding
  PORT (
    a : IN STD_LOGIC_VECTOR(30 DOWNTO 0);
    b : IN STD_LOGIC_VECTOR(34 DOWNTO 0);
    clk : IN STD_LOGIC;
    s : OUT STD_LOGIC_VECTOR(34 DOWNTO 0)
  );
END COMPONENT;

attribute box_type of final_adding : component is "black_box";

COMPONENT final_value
  PORT (
    a : IN STD_LOGIC_VECTOR(34 DOWNTO 0);
    b : IN STD_LOGIC_VECTOR(29 DOWNTO 0);
    clk : IN STD_LOGIC;
    s : OUT STD_LOGIC_VECTOR(34 DOWNTO 0)
  );
END COMPONENT;

attribute box_type of final_value : component is "black_box";

signal first_term_final : std_logic_vector(30 downto 0);
signal third_term_final : std_logic_vector(29 downto 0);
signal first_plus_second : std_logic_vector(34 downto 0);
begin

final_third_term : final_mult
  PORT MAP (
    a => third_term_value,
    p => third_term_final
  );

first_term_final <= first_term_value & "0000000000000" ;		

ADD_FIRST_SECOND : final_adding
  PORT MAP (
    a =>  first_term_final,
    b => second_term_value,
    clk => clk,
    s => first_plus_second
  );
  
GET_THRESHOLD : final_value
  PORT MAP (
    a => first_plus_second,
    b => third_term_final,
    clk => clk,
    s => threshold_vector
  );

end Behavioral;

