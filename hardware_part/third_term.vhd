----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:29:00 03/09/2019 
-- Design Name: 
-- Module Name:    third_term - Behavioral 
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

entity third_term is
      port ( clk : in std_logic;
				 fraction : in std_logic_vector (15 downto 0);
				 ce : IN STD_LOGIC;
             sclr : IN STD_LOGIC;
		       third_term_value : out std_logic_vector (18 downto 0));
end third_term;

architecture Behavioral of third_term is

COMPONENT squaring
  PORT (
    clk : IN STD_LOGIC;
    a : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    b : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    p : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
  );
END COMPONENT;
attribute box_type : string;
attribute box_type of squaring : component is "black_box";

COMPONENT third_acc
  PORT (
    b : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    clk : IN STD_LOGIC;
    ce : IN STD_LOGIC;
    sclr : IN STD_LOGIC;
    q : OUT STD_LOGIC_VECTOR(33 DOWNTO 0)
  );
END COMPONENT;
attribute box_type of third_acc : component is "black_box";

COMPONENT sqrt
  PORT (
    x_in : IN STD_LOGIC_VECTOR(33 DOWNTO 0);
    x_out : OUT STD_LOGIC_VECTOR(18 DOWNTO 0);
    clk : IN STD_LOGIC
  );
END COMPONENT;
attribute box_type of sqrt : component is "black_box";

SIGNAL f_sq: STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL sq: STD_LOGIC_VECTOR(33 DOWNTO 0);
begin
						
fraction_squaring : squaring
  PORT MAP (
    clk => clk,
    a => fraction,
    b => fraction,
    p => f_sq
  );
  
accumulation : third_acc
  PORT MAP (
    b => f_sq,
    clk => clk,
    ce => ce,
    sclr => sclr,
    q => sq
  );
 
square_root : sqrt
  PORT MAP (
    x_in => sq,
    x_out => third_term_value,
    clk => clk
  ); 

  
end Behavioral;

