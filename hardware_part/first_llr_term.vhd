----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    08:19:07 06/13/2019 
-- Design Name: 
-- Module Name:    first_llr_term - Behavioral 
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

entity first_llr_term is
      port( clk : in std_logic;
		      sclr : in std_logic;
				rdy : in std_logic;
				theta_zero_sq : in std_logic_vector ( 15 downto 0);
			   theta_one_sq : in std_logic_vector ( 15 downto 0);
				x_sq : in std_logic_vector ( 15 downto 0);
				llr_first_value : out std_logic_vector (31 downto 0);
				finish : out std_logic
				);
end first_llr_term;

architecture Behavioral of first_llr_term is
component theta_div
	port (
	clk: in std_logic;
	rfd: out std_logic;
	dividend: in std_logic_vector(15 downto 0);
	divisor: in std_logic_vector(15 downto 0);
	quotient: out std_logic_vector(15 downto 0);
	fractional: out std_logic_vector(15 downto 0));
end component;

attribute box_type : string;
attribute box_type of theta_div : component is "black_box";

COMPONENT llr_first_accumulator
  PORT (
    b : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    clk : IN STD_LOGIC;
    add : IN STD_LOGIC;
    ce : IN STD_LOGIC;
    sclr : IN STD_LOGIC;
    q : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
  );
END COMPONENT;
attribute box_type of llr_first_accumulator : component is "black_box";

COMPONENT acc_mode_indicator 
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
end COMPONENT;

signal temp,first : STD_LOGIC_VECTOR (31 downto 0);
signal q , th_sq , f : STD_LOGIC_VECTOR (15 downto 0);
signal ce , mode ,r1 : std_logic;
begin

indicator :  acc_mode_indicator
		port map(
			clk => clk,
			sclr => sclr,
			rdy => rdy,
			theta_zero_sq => theta_zero_sq,
	      theta_one_sq => theta_one_sq,
			ce => ce,
			mode => mode,
			th_sq => th_sq,
			finish => finish
			);
			
div : theta_div
		port map(
			clk => clk,
			rfd => r1,
			dividend => x_sq,
			divisor => th_sq,
			quotient => q,
			fractional => f
			);


temp <= q & f;
			
first_llr_accumulation : llr_first_accumulator
  PORT MAP (
    b => temp,
    clk => clk,
    add => mode,
    ce => ce,
    sclr => sclr,
    q => llr_first_value
  ); 
   
end Behavioral;

