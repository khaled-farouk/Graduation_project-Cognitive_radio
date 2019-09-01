----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:14:23 06/18/2019 
-- Design Name: 
-- Module Name:    special_controller - Behavioral 
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

entity special_controller is
port( 
     clk : in std_logic;
	  sclr : in std_logic;
	  edone : in std_logic;
	  ed : in std_logic_vector (15 downto 0);
	  first_real : in std_logic_vector (7 downto 0);
	  second_real : in std_logic_vector (7 downto 0);
	  third_real : in std_logic_vector (7 downto 0);
	  first_imag : in std_logic_vector (7 downto 0);
	  second_imag : in std_logic_vector (7 downto 0);
	  third_imag : in std_logic_vector (7 downto 0);
	  wr_en2 : out std_logic;
	  wr_en3 : out std_logic;	  
	  rd_en2 : out std_logic;
	  rd_en3 : out std_logic;
	  ce : out std_logic;
	  real_signal : out std_logic_vector (7 downto 0);
	  imag_signal : out std_logic_vector (7 downto 0);
	  clr : out std_logic;
	  x : out std_logic_vector (15 downto 0);
	  rdy1 : out std_logic;
	  rdy2 : out std_logic;
	  rdy3 : out std_logic
	  );
end special_controller;

architecture Behavioral of special_controller is
signal count : std_logic_vector (6 downto 0) := "0000000";
signal start : std_logic := '0' ;
begin
process(clk,edone,start,sclr,first_real,second_real,third_real,first_imag,second_imag,third_imag,ed)
begin
if clk'event and clk = '1' then
if sclr = '1' then
   start <= '0';
	count <= "0000000";
	real_signal <= "00000000";
	imag_signal <= "00000000";
	rd_en2 <= '0';
	rd_en3 <= '0';
	wr_en2 <= '0';
	wr_en3 <= '0';
	clr <= '1';
else
if edone = '1' then
  start <= '1';
end if; 
if start = '1' then
  count <= count + 1;
  if (count < "0100000") then 
     ce <= '1';
	  clr <= '0';
	  rd_en2 <= '0';
	  rd_en3 <= '0';
	  wr_en2 <= '0';
	  wr_en3 <= '0';
	  real_signal <= first_real;
	  imag_signal <= first_imag;
  end if;
  ----------------------- clk enable and clr for accumulator --------------------------
  if (count >= "0100000") and ( count < "0100110")  then
	  ce <= '0';
	  real_signal <= "00000000";
	  imag_signal <= "00000000";
  end if;
  if (count = "0100101") or (count = "1001011") then
     clr <= '1';
  end if;
  if (count >= "0100110") and ( count < "1000110")  then
	  ce <= '1';
	  clr<= '0';
	  real_signal <= second_real;
	  imag_signal <= second_imag;
  end if;
  if (count >= "1000110") and ( count < "1001100")  then
	  ce <= '0';
	  real_signal <= "00000000";
	  imag_signal <= "00000000";
  end if;
  if (count >= "1001100") and ( count < "1101100")  then
	  ce <= '1';
	  clr<= '0';
	  real_signal <= third_real;
	  imag_signal <= third_imag;
  end if;
  if (count >= "1101100")  then
	  ce <= '0';
	  real_signal <= "00000000";
	  imag_signal <= "00000000";
  end if;
  ------------------------------------------------------------------------------
  ------------------------ write enable for fifo generator ---------------------
  if (count >= "0011111") and ( count < "0111111") then
	  wr_en2 <= '1';
  end if;
  if (count >= "0111111") and ( count < "1011111") then
	  wr_en2 <= '0';
	  wr_en3 <= '1';
  end if;
  if (count >= "1011111") then
	  wr_en3 <= '0';
  end if;
  --------------------------------------------------------------------------------
  ------------------------- read enable for fifo generator -----------------------
  if (count >= "0100100") and ( count < "1000100")  then
	  rd_en2 <= '1';
  end if; 
  if (count >= "1000100") and ( count < "1001100")  then
	  rd_en2 <= '0';
  end if;
  if (count >= "1001010") and ( count < "1101010")  then
	  rd_en3 <= '1';
  end if;
  if (count >= "1101010")  then
	  rd_en3 <= '0';
  end if;
  ---------------------------------------------------------------------------------
  ---------------------------- energy value ---------------------------------------
  if (count >= "0100010") and (count < "0100100") then
     x <= ed;
	  rdy1 <= '1';
	  rdy2 <= '0';
	  rdy3 <= '0';
  end if;
  if (count >= "1001000") and (count < "1001010") then
     x <= ed;
	  rdy1 <= '0';
	  rdy2 <= '1';
	  rdy3 <= '0';
  end if;
  if (count >= "1101101") and (count < "1101111") then
     x <= ed;
	  rdy1 <= '0';
	  rdy2 <= '0';
	  rdy3 <= '1';
  end if;
  if (count >= "1101111") then
     count <= "1111000";
  end if;
  --------------------------------------------------------------------------------
end if;
end if;
end if;
end process;
end Behavioral;

