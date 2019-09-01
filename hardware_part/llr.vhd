----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:18:31 03/15/2019 
-- Design Name: 
-- Module Name:    llr - Behavioral 
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

entity llr is
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
end llr;

architecture Behavioral of llr is

component theta_square 
     port( clk : in std_logic;
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
			  rdy : out std_logic;
	        theta_zero_sq : out std_logic_vector ( 15 downto 0);
			  theta_one_sq : out std_logic_vector ( 15 downto 0);
			  x_sq : out std_logic_vector ( 15 downto 0)
			  );
end component;
 
component first_llr_term 
      port( clk : in std_logic;
		      sclr : in std_logic;
				rdy : in std_logic;
				theta_zero_sq : in std_logic_vector ( 15 downto 0);
			   theta_one_sq : in std_logic_vector ( 15 downto 0);
				x_sq : in std_logic_vector ( 15 downto 0);
				llr_first_value : out std_logic_vector (31 downto 0);
				finish : out std_logic
				);
end component; 

component second_llr_term 
      port( clk : in std_logic;
				theta_zero_sq : in std_logic_vector ( 15 downto 0);
			   theta_one_sq : in std_logic_vector ( 15 downto 0);
            sclr : IN STD_LOGIC;
				rdy : in std_logic;
				llr_second_value : out std_logic_vector (17 downto 0)
				);
end component;

COMPONENT llr_result
  PORT (
    a : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    b : IN STD_LOGIC_VECTOR(21 DOWNTO 0);
    clk : IN STD_LOGIC;
    s : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
  );
END COMPONENT;
attribute box_type : string;
attribute box_type of llr_result : component is "black_box";

----------------------------------------------------------------------------------------------

signal first,llr_vector : STD_LOGIC_VECTOR (31 downto 0);
signal second : STD_LOGIC_VECTOR (17 downto 0);
signal second_final : STD_LOGIC_VECTOR (21 downto 0);
signal tzs,tos,x : STD_LOGIC_VECTOR (15 downto 0);
signal done ,rdy: std_logic;
begin 

theta_sq : theta_square 
     port map( clk => clk,
	        sclr => sclr,
	        start => start,
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
			  rdy => rdy,
	        theta_zero_sq => tzs,
			  theta_one_sq => tos,
			  x_sq => x
			  );
	
			
get_llr_first_term : first_llr_term  
  PORT MAP (
    clk => clk,
	 rdy => rdy,
	 theta_zero_sq => tzs,
	 theta_one_sq => tos,
	 sclr => sclr,
	 x_sq => x,
    llr_first_value => first,
    finish => finish	 
  );

get_llr_second_term : second_llr_term 
  PORT MAP (
    clk => clk,
	 theta_zero_sq => tzs,
	 theta_one_sq => tos,
	 sclr => sclr,
	 rdy => rdy,
    llr_second_value => second 
  );				

second_final <= second & "1111";

LLR_VALUE : llr_result
  PORT MAP (
    a => first,
    b => second_final,
    clk => clk,
    s => llr_vector
  );
  

llr_quotient <= llr_vector(31 downto 12);
llr_fraction <= llr_vector(11 downto 0);
			 
 

end Behavioral;

