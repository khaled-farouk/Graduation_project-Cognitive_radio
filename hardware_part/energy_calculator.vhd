----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:26:40 06/27/2019 
-- Design Name: 
-- Module Name:    energy_calculator - Behavioral 
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;
library UNISIM;
use UNISIM.VComponents.all;

entity energy_calculator is
  PORT (
    clk : IN STD_LOGIC;
    en : IN STD_LOGIC;
    clr : IN STD_LOGIC;
    actual_real : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    actual_imag: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    ed : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
  );
end energy_calculator;

architecture Behavioral of energy_calculator is
COMPONENT acc_mult
  PORT (
    clk : IN STD_LOGIC;
    ce : IN STD_LOGIC;
    sclr : IN STD_LOGIC;
    a : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    b : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    s : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
  );
END COMPONENT;
attribute box_type : string;
attribute box_type of acc_mult : component is "black_box";

COMPONENT add_re_im
  PORT (
    a : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    b : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    clk : IN STD_LOGIC;
    s : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
  );
END COMPONENT; 

attribute box_type of  add_re_im : component is "black_box";

signal S1,S2 : STD_LOGIC_VECTOR (15 downto 0);
begin
 MULT_ACC1 : acc_mult
  PORT MAP (
    clk => clk,
    ce => en,
    sclr => clr,
    a => actual_real,
    b => actual_real,
    s => S1  );
  
	 
	 
 MULT_ACC2 : acc_mult
  PORT MAP (
    clk => clk,
    ce => en,
    sclr => clr,
    a => actual_imag,
    b => actual_imag,
    s => S2  );
  
  
ADDING_REAL_IMAGINARY_SQ : add_re_im
  PORT MAP (
    a => S1,
    b => S2,
    clk => clk,
    s => ed
  );

end Behavioral;

