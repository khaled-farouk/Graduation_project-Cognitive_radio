----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    06:26:39 03/09/2019 
-- Design Name: 
-- Module Name:    second_term - Behavioral 
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
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
library UNISIM;
use UNISIM.VComponents.all;

entity second_term is
      port ( clk : in std_logic;
		       one_lower : in std_logic_vector ( 15 downto 0);
				 zero_upper : in std_logic_vector ( 15 downto 0);
				 ce : IN STD_LOGIC;
             sclr : IN STD_LOGIC;
		       second_term_value : out std_logic_vector (34 downto 0));
end second_term;

architecture Behavioral of second_term is

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

COMPONENT HalfLn
  PORT (
    x_in : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    y_in : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    phase_out : OUT STD_LOGIC_VECTOR(32 DOWNTO 0)
  );
END COMPONENT;
attribute box_type of HalfLn : component is "black_box";

COMPONENT second_acc
  PORT (
    b : IN STD_LOGIC_VECTOR(32 DOWNTO 0);
    clk : IN STD_LOGIC;
    ce : IN STD_LOGIC;
    sclr : IN STD_LOGIC;
    q : OUT STD_LOGIC_VECTOR(34 DOWNTO 0)
  );
END COMPONENT;
attribute box_type of second_acc : component is "black_box";

CONSTANT I1 : STD_LOGIC := '1';
CONSTANT I0 : STD_LOGIC := '0';
SIGNAL num,denum : STD_LOGIC_VECTOR (15 DOWNTO 0);
SIGNAL h_ln : STD_LOGIC_VECTOR (32 DOWNTO 0);
begin
sub1 : sub_add
  PORT MAP (
    a => zero_upper,
    b => one_lower,
    clk => clk,
    add => I0,
    s => num 
  );

add1 : sub_add
  PORT MAP (
    a => zero_upper,
    b => one_lower,
    clk => clk,
    add => I1,
    s => denum
  );

half_ln : HalfLn
  PORT MAP (
    x_in => denum,
    y_in => num,
    phase_out => h_ln
  );


get_second_term : second_acc
  PORT MAP (
    b => h_ln,
    clk => clk,
    ce => ce,
    sclr => sclr,
    q => second_term_value
  );

end Behavioral;

