----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:45:11 06/17/2019 
-- Design Name: 
-- Module Name:    second_llr_term - Behavioral 
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

entity second_llr_term is
      port( clk : in std_logic;
				theta_zero_sq : in std_logic_vector ( 15 downto 0);
			   theta_one_sq : in std_logic_vector ( 15 downto 0);
            sclr : IN STD_LOGIC;
				rdy : in std_logic;
				llr_second_value : out std_logic_vector (17 downto 0));
end second_llr_term;

architecture Behavioral of second_llr_term is
COMPONENT sub_add
  PORT (
    a : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    b : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    clk : IN STD_LOGIC;
    add : IN STD_LOGIC;
    s : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
  );
END COMPONENT;
attribute box_type : string;
attribute box_type of sub_add : component is "black_box";

COMPONENT clk_enable 
      port( clk : in std_logic;
		      sclr : in std_logic;
				rdy : in std_logic;
				ce : out std_logic
				);
end COMPONENT;

COMPONENT half_ln_new
  PORT (
    x_in : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    y_in : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    phase_out : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
  );
END COMPONENT;
attribute box_type of half_ln_new : component is "black_box";

COMPONENT sec_llr_acc
  PORT (
    b : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    clk : IN STD_LOGIC;
    ce : IN STD_LOGIC;
    sclr : IN STD_LOGIC;
    q : OUT STD_LOGIC_VECTOR(17 DOWNTO 0)
  );
END COMPONENT;
attribute box_type of sec_llr_acc : component is "black_box";

CONSTANT I1 : STD_LOGIC := '1';
CONSTANT I0 : STD_LOGIC := '0';
SIGNAL num,denum,h_ln : STD_LOGIC_VECTOR (15 DOWNTO 0);
signal ce : std_logic;
begin
sub1 : sub_add
  PORT MAP (
    a => theta_zero_sq,
    b => theta_one_sq,
    clk => clk,
    add => I0,
    s => num 
  );

add1 : sub_add
  PORT MAP (
    a => theta_zero_sq,
    b => theta_one_sq,
    clk => clk,
    add => I1,
    s => denum
  );
  
HALF_LN : half_ln_new
  PORT MAP (
    x_in => denum,
    y_in => num,
    phase_out => h_ln
  );
  
get_enabling_bit : clk_enable
  PORT MAP (
    clk => clk,
    sclr => sclr,
    rdy => rdy,
	 ce => ce
  );

get_second_term : sec_llr_acc
  PORT MAP (
    b => h_ln,
    clk => clk,
    ce => ce,
    sclr => sclr,
    q => llr_second_value
  );
  
end Behavioral;

