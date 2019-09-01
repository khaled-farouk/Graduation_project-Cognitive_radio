----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    07:33:47 03/14/2019 
-- Design Name: 
-- Module Name:    theta_call - Behavioral 
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

entity theta_square is
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
end theta_square;

architecture Behavioral of theta_square is

component signal_memory 
  PORT (
    clk : IN STD_LOGIC;
    srst : IN STD_LOGIC;
	 start : in std_logic;
    din1 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	 din2 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	 din3 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	 rdy1 : in std_logic;
	 rdy2 : in std_logic;	  
	 rdy3 : in std_logic;
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
    sig : out STD_LOGIC_VECTOR(7 DOWNTO 0);
	 zero_lower : out std_logic_vector ( 15 downto 0); 
	 zero_upper : out std_logic_vector ( 15 downto 0);
	 one_lower : out std_logic_vector ( 15 downto 0);
	 one_upper : out std_logic_vector ( 15 downto 0)
  );
end component;


component min_value 
     port( clk : in std_logic;
	        ed : in std_logic_vector (15  downto 0);
			  upper_value : in std_logic_vector (15  downto 0);
			  min_val : out std_logic_vector (15 downto 0));
end component;

component max_value 
     port( clk : in std_logic;
	        lower_value : in std_logic_vector (15 downto 0);
			  min_val : in std_logic_vector (15 downto 0);
			  max_val : out std_logic_vector (15 downto 0));
end component;


COMPONENT energy_detector 
     port( clk : in std_logic;
	        start : in std_logic;
			  sclr : in std_logic;
	        user : in std_logic_vector ( 7 downto 0);
			  x : out std_logic_vector ( 15 downto 0);
			  rdy1 : out std_logic;
			  rdy2 : out std_logic;
			  rdy3 : out std_logic
			  );
end COMPONENT;

------------------------------------------------------------------------------------------------
signal one_lower,x,one_upper,zero_lower,zero_upper,minimum_zero,minimum_one : STD_LOGIC_VECTOR (15 downto 0);
signal rdy1,rdy2,rdy3 : std_logic;
signal sig_vector : std_logic_vector(7 downto 0);
begin

MEMORY : signal_memory 
  PORT MAP (
    clk => clk,
    srst => sclr,
	 start => start,
    din1 => user1,
	 din2 => user2,
	 din3 => user3,
	 rdy1 => rdy1,
	 rdy2 => rdy2,
	 rdy3 => rdy3,
	 zero_lower1 => zero_lower1,
	 zero_lower2 => zero_lower2,
	 zero_lower3 => zero_lower3,
	 zero_upper1 => zero_upper1,
	 zero_upper2 => zero_upper2,
	 zero_upper3 => zero_upper3,
	 one_lower1 => one_lower1,
	 one_lower2 => one_lower2,
	 one_lower3 => one_lower3,
	 one_upper1 => one_upper1,
	 one_upper2 => one_upper2,
	 one_upper3 => one_upper3,
	 sig => sig_vector,
	 zero_lower => zero_lower,
	 zero_upper => zero_upper,
	 one_lower => one_lower,
	 one_upper => one_upper
  );

energy_detection : energy_detector
  PORT MAP (
    clk => clk,
    start => start,
	 sclr => sclr,
    user => sig_vector,
    x => x,
	 rdy1 => rdy1,
	 rdy2 => rdy2,
	 rdy3 => rdy3
  );
x_sq <= x;
rdy <= rdy1;
MINIMUM_zero_ed : min_value 
     port map( clk => clk,
	        ed => x,
           upper_value => zero_upper,
			  min_val => minimum_zero);
			  
MINIMUM_one_ed : min_value 
     port map( clk => clk,
	        ed => x,
			  upper_value => one_upper,
			  min_val => minimum_one);
			  
MAXIMUM_zero_min : max_value 
     port map( clk => clk,
	        lower_value => zero_lower,
           min_val => minimum_zero,
			  max_val => theta_zero_sq);

MAXIMUM_one_min : max_value 
     port map( clk => clk,
	        lower_value => one_lower,
			  min_val => minimum_one,
			  max_val => theta_one_sq);			  

end Behavioral;
 

