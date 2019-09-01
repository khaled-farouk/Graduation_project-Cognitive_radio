----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:17:08 03/09/2019 
-- Design Name: 
-- Module Name:    threshold - Behavioral 
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
--------------------------------- threshold entity -------------------------------
entity threshold is
      port ( clk : in std_logic;
		       sclr : in std_logic;
				 zero_upper1 : in std_logic_vector ( 15 downto 0);
			  	 zero_upper2 : in std_logic_vector ( 15 downto 0);
				 zero_upper3 : in std_logic_vector ( 15 downto 0);
				 one_lower1 : in std_logic_vector ( 15 downto 0);
				 one_lower2 : in std_logic_vector ( 15 downto 0);
				 one_lower3 : in std_logic_vector ( 15 downto 0);
				 threshold_int : out std_logic_vector (9 downto 0);
				 threshold_fraction : out std_logic_vector (24 downto 0)
				 );
end threshold;
----------------------------------------------------------------------------------

---------------------------------- threshold architecture ------------------------
architecture Behavioral of threshold is

-- values provider that generate upper zero and lower one values and  enable bits as a component --
component values_provider 
      port ( 
		       clk : in std_logic;
				 sclr : in std_logic;
				 zero_upper1 : in std_logic_vector ( 15 downto 0);
			  	 zero_upper2 : in std_logic_vector ( 15 downto 0);
				 zero_upper3 : in std_logic_vector ( 15 downto 0);
				 one_lower1 : in std_logic_vector ( 15 downto 0);
				 one_lower2 : in std_logic_vector ( 15 downto 0);
				 one_lower3 : in std_logic_vector ( 15 downto 0);
				 one_lower : out std_logic_vector ( 15 downto 0);
				 zero_upper : out std_logic_vector ( 15 downto 0);
				 ce1 : out std_logic;
				 ce2 : out std_logic;
				 ce3 : out std_logic
		 );				 
end component;
--------------------------------------------------------------------------------------------------

-------------------------------  defining the first term as a component --------------------------
----------------- first term = sum ( 1 - ( one lower(m) / zero upper (m) ), m) -------------------
component first_term 
      port( clk : in std_logic;
		      ce : IN STD_LOGIC;
            sclr : IN STD_LOGIC;
		      one_lower : in std_logic_vector ( 15 downto 0);
				zero_upper : in std_logic_vector ( 15 downto 0);		
				fraction : out std_logic_vector ( 15 downto 0);				
				first_term_value : out std_logic_vector ( 17 downto 0)
				);
end component;
--------------------------------------------------------------------------------------------------

-------------------------------  defining the second term as a component -------------------------
----------------- second term = sum 0.5( log ( one lower(m) / zero upper (m) ), m) ---------------
component second_term 
      port ( clk : in std_logic;
		       one_lower : in std_logic_vector ( 15 downto 0);
				 zero_upper : in std_logic_vector ( 15 downto 0);
				 ce : IN STD_LOGIC;
             sclr : IN STD_LOGIC;
		       second_term_value : out std_logic_vector (34 downto 0));
end component;
--------------------------------------------------------------------------------------------------

-------------------------------  defining the third term as a component -------------------------
----------------- third term = sum 0.5( sqrt ( sum ( fraction^2, m))) ---------------------------
component third_term 
      port ( clk : in std_logic;
				 fraction : in std_logic_vector ( 15 downto 0);
				 ce : IN STD_LOGIC;
             sclr : IN STD_LOGIC;
		       third_term_value : out std_logic_vector (18 downto 0));
end component;
--------------------------------------------------------------------------------------------------

---------  defining the module that calculat the over all threshold as a component ---------------
component final_threshold_calculation 
      port ( clk : in std_logic;		
             first_term_value : in std_logic_vector (17 downto 0);
             second_term_value : in std_logic_vector (34 downto 0);
             third_term_value : in std_logic_vector (18 downto 0);				 
		       threshold_vector : out std_logic_vector (34 downto 0));
end component;
--------------------------------------------------------------------------------------------------

-------------------------- signals definition ----------------------------------------------------
signal th_t : STD_LOGIC_VECTOR(18 DOWNTO 0);
signal s_t,thr_vec : STD_LOGIC_VECTOR(34 DOWNTO 0);
signal f_t : STD_LOGIC_VECTOR(17 DOWNTO 0);
signal zero_upper,one_lower: STD_LOGIC_VECTOR(15 DOWNTO 0);
signal f : STD_LOGIC_VECTOR(15 DOWNTO 0);
signal ce1,ce2,ce3 : std_logic;
--------------------------------------------------------------------------------------------------
begin
------------------------------ values provider mapping -------------------------------------------
starting_calculations : values_provider
      port map ( clk => clk,
		      sclr => sclr,		
				zero_upper1 => zero_upper1,
				zero_upper2 => zero_upper2,
				zero_upper3 => zero_upper3,
				one_lower1 =>  one_lower1,
				one_lower2 =>  one_lower2,
				one_lower3 =>  one_lower3,
				one_lower => one_lower,
				zero_upper => zero_upper,
				ce1 => ce1,
				ce2 => ce2,
				ce3 => ce3
				);
--------------------------------------------------------------------------------------------------

-------------------------------- first term mapping ----------------------------------------------
FIRST_MAP : first_term
      port map ( clk => clk,
				zero_upper => zero_upper,
				one_lower => one_lower,
				ce => ce1,
				sclr => sclr,
				fraction => f,
				first_term_value => f_t );
--------------------------------------------------------------------------------------------------

------------------------------- second term mapping ----------------------------------------------				
SECOND_MAP : second_term
      port map ( clk => clk,
		      one_lower => one_lower,
				zero_upper => zero_upper,
				ce => ce2,
				sclr => sclr,
				second_term_value => s_t );
--------------------------------------------------------------------------------------------------

-------------------------------- third term mapping ----------------------------------------------				
THIRD_MAP : third_term 
      port map( clk => clk,
				    fraction => f,
					 ce => ce3,
				    sclr => sclr,
		          third_term_value => th_t);
--------------------------------------------------------------------------------------------------

-------------------------------- final calculation mapping ---------------------------------------				 
final_calculation : final_threshold_calculation 
      port map( clk => clk,
				    first_term_value => f_t,
				    second_term_value => s_t,
					 third_term_value => th_t,
		          threshold_vector => thr_vec);	
--------------------------------------------------------------------------------------------------

------------------ get the threshold in suitable format to be readable  --------------------------
threshold_int <= thr_vec(34 downto 25);					 
threshold_fraction <= thr_vec(24 downto 0);
--------------------------------------------------------------------------------------------------
end Behavioral;
--------------------------------------------------------------------------------------------------
