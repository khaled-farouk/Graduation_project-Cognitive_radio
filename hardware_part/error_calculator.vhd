----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:48:24 06/13/2019 
-- Design Name: 
-- Module Name:    error_calculator - Behavioral 
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
------------------------------- error calculator entity ----------------------
entity error_calculator is
  PORT (
    clk : IN STD_LOGIC;
	 sclr : in std_logic;
    sig_vector : in std_logic_vector (7 downto 0);
	 orginal_vector : in std_logic_vector (7 downto 0);
    error: OUT STD_LOGIC_VECTOR(19 DOWNTO 0)
  );
end error_calculator;
----------------------------------------------------------------------------------
---------------------------- architecture of the error calculator ----------------
architecture Behavioral of error_calculator is

----------------  subtractor ip core definition ----------------------------------
COMPONENT user_sub
  PORT (
    a : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    b : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    clk : IN STD_LOGIC;
    s : OUT STD_LOGIC_VECTOR(8 DOWNTO 0)
  );
END COMPONENT;
attribute box_type : string;
attribute box_type of user_sub : component is "black_box";
-----------------------------------------------------------------------------------

---  multiplier ip core definition (multiplying a value to itself is squaring -----
COMPONENT user_squaring
  PORT (
    clk : IN STD_LOGIC;
    a : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
    b : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
    p : OUT STD_LOGIC_VECTOR(17 DOWNTO 0)
  );
END COMPONENT;
attribute box_type of user_squaring : component is "black_box";
-----------------------------------------------------------------------------------

--------------------------- accumulator ip core definition  -----------------------
COMPONENT accumulation
  PORT (
    b : IN STD_LOGIC_VECTOR(17 DOWNTO 0);
    clk : IN STD_LOGIC;
    sclr : IN STD_LOGIC;
    q : OUT STD_LOGIC_VECTOR(19 DOWNTO 0)
  );
END COMPONENT;
attribute box_type of accumulation : component is "black_box";
-----------------------------------------------------------------------------------

-- definition of the enabling module that controls the enabling of the accumulator --
COMPONENT enable 
      port (clk : in std_logic;
		      sclr : in std_logic;
		      error_num : in std_logic_vector (17 downto 0);
				error : out std_logic_vector (17 downto 0));
end COMPONENT;
-----------------------------------------------------------------------------------

-------------------------- definition of signals -----------------------------------
signal e : std_logic_vector ( 8 downto 0);
signal e_sq,sample_error  : std_logic_vector ( 17 downto 0);
------------------------------------------------------------------------------------
begin
------------------------------ subtractor mapping ----------------------------------
indicator : user_sub
  PORT MAP (
    a => sig_vector,
    b => orginal_vector,
    clk => clk,
    s => e
  );
-----------------------------------------------------------------------------------

-------------------------- multiplier mapping  -----------------------------------
sample_error_calculation : user_squaring
  PORT MAP (
    clk => clk,
    a => e,
    b => e,
    p => e_sq
  );
-----------------------------------------------------------------------------------

------------------------------ enabler mapping  -----------------------------------
enabling_calculation: enable
  PORT MAP (
    clk => clk,
    sclr => sclr,
    error_num => e_sq,
    error => sample_error
  );
-----------------------------------------------------------------------------------

------------------------------ accumulator mapping  -----------------------------------
get_error : accumulation
  PORT MAP (
    b => sample_error,
    clk => clk,
    sclr => sclr,
    q => error
  );
-----------------------------------------------------------------------------------
end Behavioral;
-----------------------------------------------------------------------------------

