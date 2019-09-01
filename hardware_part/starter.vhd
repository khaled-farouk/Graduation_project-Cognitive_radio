----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:32:07 06/15/2019 
-- Design Name: 
-- Module Name:    starter - Behavioral 
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
use ieee.std_logic_unsigned.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity starter is
      port (clk : in std_logic;
		      en1 : in std_logic;
				en2 : in std_logic;
				en3 : in std_logic;
				en4 : in std_logic;
				en5 : in std_logic;
				selection_finish : in std_logic;
				period : in std_logic_vector ( 10 downto 0);
				zero_lower1 : out std_logic_vector ( 15 downto 0);
				zero_lower2 : out std_logic_vector ( 15 downto 0);
				zero_lower3 : out std_logic_vector ( 15 downto 0);
				zero_upper1 : out std_logic_vector ( 15 downto 0);
				zero_upper2 : out std_logic_vector ( 15 downto 0);
				zero_upper3 : out std_logic_vector ( 15 downto 0);
				one_lower1 : out std_logic_vector ( 15 downto 0);
				one_lower2 : out std_logic_vector ( 15 downto 0);
				one_lower3 : out std_logic_vector ( 15 downto 0);
				one_upper1 : out std_logic_vector ( 15 downto 0);
				one_upper2 : out std_logic_vector ( 15 downto 0);
				one_upper3 : out std_logic_vector ( 15 downto 0);
				sclr : out std_logic;
				enable : out std_logic
				);
end starter;

architecture Behavioral of starter is
signal count : std_logic_vector ( 2 downto 0 ) := "000" ;
signal samples : std_logic_vector ( 10 downto 0 ) := "00000000000" ;
constant zl1 : std_logic_vector( 15 downto 0 ) := std_logic_vector(to_unsigned(2880, 16));
constant zl2 : std_logic_vector( 15 downto 0 ) := std_logic_vector(to_unsigned(3500, 16));
constant zl3 : std_logic_vector( 15 downto 0 ) := std_logic_vector(to_unsigned(3782, 16));
constant zl4 : std_logic_vector( 15 downto 0 ) := std_logic_vector(to_unsigned(3921, 16));
constant zl5 : std_logic_vector( 15 downto 0 ) := std_logic_vector(to_unsigned(4025, 16));

constant zu1 : std_logic_vector( 15 downto 0 ) := std_logic_vector(to_unsigned(4884, 16));
constant zu2 : std_logic_vector( 15 downto 0 ) := std_logic_vector(to_unsigned(6252, 16));
constant zu3 : std_logic_vector( 15 downto 0 ) := std_logic_vector(to_unsigned(6863, 16));
constant zu4 : std_logic_vector( 15 downto 0 ) := std_logic_vector(to_unsigned(6995, 16));
constant zu5 : std_logic_vector( 15 downto 0 ) := std_logic_vector(to_unsigned(7107, 16));

constant ol1 : std_logic_vector( 15 downto 0 ) := std_logic_vector(to_unsigned(11099, 16));
constant ol2 : std_logic_vector( 15 downto 0 ) := std_logic_vector(to_unsigned(11307, 16));
constant ol3 : std_logic_vector( 15 downto 0 ) := std_logic_vector(to_unsigned(9846, 16));
constant ol4 : std_logic_vector( 15 downto 0 ) := std_logic_vector(to_unsigned(11570, 16));
constant ol5 : std_logic_vector( 15 downto 0 ) := std_logic_vector(to_unsigned(11201, 16));

constant ou1 : std_logic_vector( 15 downto 0 ) := std_logic_vector(to_unsigned(13055, 16));
constant ou2 : std_logic_vector( 15 downto 0 ) := std_logic_vector(to_unsigned(13553, 16));
constant ou3 : std_logic_vector( 15 downto 0 ) := std_logic_vector(to_unsigned(13374, 16));
constant ou4 : std_logic_vector( 15 downto 0 ) := std_logic_vector(to_unsigned(13306, 16));
constant ou5 : std_logic_vector( 15 downto 0 ) := std_logic_vector(to_unsigned(13901, 16));

signal zero_lower_t1 : std_logic_vector( 15 downto 0 ) ;
signal zero_lower_t2 : std_logic_vector( 15 downto 0 ) ;
signal zero_lower_t3 : std_logic_vector( 15 downto 0 ) ;
signal zero_upper_t1 : std_logic_vector( 15 downto 0 ) ;
signal zero_upper_t2 : std_logic_vector( 15 downto 0 ) ;
signal zero_upper_t3 : std_logic_vector( 15 downto 0 ) ;
signal one_lower_t1 : std_logic_vector( 15 downto 0 ) ;
signal one_lower_t2 : std_logic_vector( 15 downto 0 ) ;
signal one_lower_t3 : std_logic_vector( 15 downto 0 ) ;
signal one_upper_t1 : std_logic_vector( 15 downto 0 ) ;
signal one_upper_t2 : std_logic_vector( 15 downto 0 ) ;
signal one_upper_t3 : std_logic_vector( 15 downto 0 ) ;

begin
process (clk,en1,en2,en3,en4,en5,selection_finish,period)
begin
if clk'event and clk = '1' then 
   samples <= samples + 1 ;
if samples < period then 
    enable <= '1' ;
	 sclr <= '0' ;
	 count <= "000" ;
else
    count <= count +1 ;
    enable <= '0' ;
	 sclr <= '1' ;
	 if count >= "100" then
       samples <= "00000000000" ;
    end if;
	       zero_lower1 <= zero_lower_t1;
			 zero_lower2 <= zero_lower_t2;
			 zero_lower3 <= zero_lower_t3;
			 zero_upper1 <= zero_upper_t1;
			 zero_upper2 <= zero_upper_t2;
			 zero_upper3 <= zero_upper_t3;
			 one_lower1 <= one_lower_t1;
			 one_lower2 <= one_lower_t2;
			 one_lower3 <= one_lower_t3;
			 one_upper1 <= one_upper_t1;
			 one_upper2 <= one_upper_t2;
			 one_upper3 <= one_upper_t3;
end if;	 
	 
if selection_finish = '1' then
   if (en3 = '1')  and (en4 = '1') and (en5 = '1') then
			 zero_lower_t1 <= zl3;
			 zero_lower_t2 <= zl4;
			 zero_lower_t3 <= zl5;
			 zero_upper_t1 <= zu3;
			 zero_upper_t2 <= zu4;
			 zero_upper_t3 <= zu5;
			 one_lower_t1 <= ol3;
			 one_lower_t2 <= ol4;
			 one_lower_t3 <= ol5;
			 one_upper_t1 <= ou3;
			 one_upper_t2 <= ou4;
			 one_upper_t3 <= ou5;
    elsif (en2 = '1')  and (en4 = '1') and (en5 = '1') then
			 zero_lower_t1 <= zl2;
			 zero_lower_t2 <= zl4;
			 zero_lower_t3 <= zl5;
			 zero_upper_t1 <= zu2;
			 zero_upper_t2 <= zu4;
			 zero_upper_t3 <= zu5;
			 one_lower_t1 <= ol2;
			 one_lower_t2 <= ol4;
			 one_lower_t3 <= ol5;
			 one_upper_t1 <= ou2;
			 one_upper_t2 <= ou4;
			 one_upper_t3 <= ou5;
    elsif (en2 = '1')  and (en3 = '1') and (en5 = '1') then
			 zero_lower_t1 <= zl2;
			 zero_lower_t2 <= zl3;
			 zero_lower_t3 <= zl5;
			 zero_upper_t1 <= zu2;
			 zero_upper_t2 <= zu3;
			 zero_upper_t3 <= zu5;
			 one_lower_t1 <= ol2;
			 one_lower_t2 <= ol3;
			 one_lower_t3 <= ol5;
			 one_upper_t1 <= ou2;
			 one_upper_t2 <= ou3;
			 one_upper_t3 <= ou5;
    elsif (en3 = '1')  and (en4 = '1') and (en2 = '1') then
			 zero_lower_t1 <= zl2;
			 zero_lower_t2 <= zl3;
			 zero_lower_t3 <= zl4;
			 zero_upper_t1 <= zu2;
			 zero_upper_t2 <= zu3;
			 zero_upper_t3 <= zu4;
			 one_lower_t1 <= ol2;
			 one_lower_t2 <= ol3;
			 one_lower_t3 <= ol4;
			 one_upper_t1 <= ou2;
			 one_upper_t2 <= ou3;
			 one_upper_t3 <= ou4;
    elsif (en1 = '1')  and (en4 = '1') and (en5 = '1') then
			 zero_lower_t1 <= zl1;
			 zero_lower_t2 <= zl4;
			 zero_lower_t3 <= zl5;
			 zero_upper_t1 <= zu1;
			 zero_upper_t2 <= zu4;
			 zero_upper_t3 <= zu5;
			 one_lower_t1 <= ol1;
			 one_lower_t2 <= ol4;
			 one_lower_t3 <= ol5;
			 one_upper_t1 <= ou1;
			 one_upper_t2 <= ou4;
			 one_upper_t3 <= ou5;
    elsif (en3 = '1')  and (en1 = '1') and (en5 = '1') then
			 zero_lower_t1 <= zl1;
			 zero_lower_t2 <= zl3;
			 zero_lower_t3 <= zl5;
			 zero_upper_t1 <= zu1;
			 zero_upper_t2 <= zu3;
			 zero_upper_t3 <= zu5;
			 one_lower_t1 <= ol1;
			 one_lower_t2 <= ol3;
			 one_lower_t3 <= ol5;
			 one_upper_t1 <= ou1;
			 one_upper_t2 <= ou3;
			 one_upper_t3 <= ou5;
    elsif (en3 = '1')  and (en4 = '1') and (en1 = '1') then
			 zero_lower_t1 <= zl1;
			 zero_lower_t2 <= zl3;
			 zero_lower_t3 <= zl4;
			 zero_upper_t1 <= zu1;
			 zero_upper_t2 <= zu3;
			 zero_upper_t3 <= zu4;
			 one_lower_t1 <= ol1;
			 one_lower_t2 <= ol3;
			 one_lower_t3 <= ol4;
			 one_upper_t1 <= ou1;
			 one_upper_t2 <= ou3;
			 one_upper_t3 <= ou4;
    elsif (en1 = '1')  and (en2 = '1') and (en5 = '1') then
			 zero_lower_t1 <= zl1;
			 zero_lower_t2 <= zl2;
			 zero_lower_t3 <= zl5;
			 zero_upper_t1 <= zu1;
			 zero_upper_t2 <= zu2;
			 zero_upper_t3 <= zu5;
			 one_lower_t1 <= ol1;
			 one_lower_t2 <= ol2;
			 one_lower_t3 <= ol5;
			 one_upper_t1 <= ou1;
			 one_upper_t2 <= ou2;
			 one_upper_t3 <= ou5;
    elsif (en1 = '1')  and (en4 = '1') and (en2 = '1') then
			 zero_lower_t1 <= zl1;
			 zero_lower_t2 <= zl2;
			 zero_lower_t3 <= zl4;
			 zero_upper_t1 <= zu1;
			 zero_upper_t2 <= zu2;
			 zero_upper_t3 <= zu4;
			 one_lower_t1 <= ol1;
			 one_lower_t2 <= ol2;
			 one_lower_t3 <= ol4;
			 one_upper_t1 <= ou1;
			 one_upper_t2 <= ou2;
			 one_upper_t3 <= ou4;
    else
			 zero_lower_t1 <= zl1;
			 zero_lower_t2 <= zl2;
			 zero_lower_t3 <= zl3;
			 zero_upper_t1 <= zu1;
			 zero_upper_t2 <= zu2;
			 zero_upper_t3 <= zu3;
			 one_lower_t1 <= ol1;
			 one_lower_t2 <= ol2;
			 one_lower_t3 <= ol3;
			 one_upper_t1 <= ou1;
			 one_upper_t2 <= ou2;
			 one_upper_t3 <= ou3;
    end if;
end if;
end if;
end process;


end Behavioral;

