----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
---- Design Name: 
-- Module Name:    first_term - Behavioral  
-- Create Date:    16:31:02 03/08/2019 

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

entity first_term is
      port( clk : in std_logic;
		      ce : IN STD_LOGIC;
            sclr : IN STD_LOGIC;
		      one_lower : in std_logic_vector ( 15 downto 0);
				zero_upper : in std_logic_vector ( 15 downto 0);		
				fraction : out std_logic_vector ( 15 downto 0);				
				first_term_value : out std_logic_vector ( 17 downto 0)
				);
end first_term;

architecture Behavioral of first_term is

COMPONENT subtract
  PORT (
    a : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    b : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    clk : IN STD_LOGIC;
    s : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
  );
END COMPONENT;
attribute box_type : string;
attribute box_type of subtract : component is "black_box";

component division
	port (
	clk: in std_logic;
	rfd: out std_logic;
	dividend: in std_logic_vector(15 downto 0);
	divisor: in std_logic_vector(15 downto 0);
	quotient: out std_logic_vector(15 downto 0);
	fractional: out std_logic_vector(15 downto 0));
end component;
attribute box_type of division : component is "black_box";

COMPONENT first_acc
  PORT (
    b : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    clk : IN STD_LOGIC;
	 ce : IN STD_LOGIC;
    sclr : IN STD_LOGIC;
    q : OUT STD_LOGIC_VECTOR(17 DOWNTO 0)
  );
END COMPONENT;
attribute box_type of first_acc : component is "black_box";

SIGNAL v,q,f :std_logic_vector(15 downto 0);
signal r : std_logic;
begin

user_sub : subtract
  PORT MAP (
    a => one_lower,
    b => zero_upper,
    clk => clk,
    s => v 
	 );
			
user_div : division
	port map (
	   clk => clk,
		rfd => r,
		dividend => v,
		divisor => one_lower,
		quotient => q,
		fractional => f
		);			
				 

get_first_term : first_acc
  PORT MAP (
    b => f,
    clk => clk,
    sclr => sclr,
	 ce => ce,
    q => first_term_value
  );	

fraction <= f;  
end Behavioral;

