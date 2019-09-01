----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:00:33 06/27/2019 
-- Design Name: 
-- Module Name:    fft_memory - Behavioral 
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

entity fft_memory is
  PORT (
    clk : IN STD_LOGIC;
    e : IN STD_LOGIC;
    real_fft: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	 imag_fft: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    wr2 : IN STD_LOGIC;
	 wr3 : IN STD_LOGIC;
    rd_en2 : IN STD_LOGIC;
	 rd_en3 : IN STD_LOGIC;
    r_fft2 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
	 i_fft2 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
	 r_fft3 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
	 i_fft3 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
  );
end fft_memory;

architecture Behavioral of fft_memory is
COMPONENT fifo_memory
  PORT (
    clk : IN STD_LOGIC;
    srst : IN STD_LOGIC;
    din : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    wr_en : IN STD_LOGIC;
    rd_en : IN STD_LOGIC;
    dout : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
    full : OUT STD_LOGIC;
    empty : OUT STD_LOGIC
  );
END COMPONENT;
attribute box_type : string;
attribute box_type of fifo_memory : component is "black_box";


signal f1,f2,f3,f4,e1,e2,e3,e4 : std_logic;
begin
second_fft_real : fifo_memory
  PORT MAP (
    clk => clk,
    srst => e,
    din => real_fft,
    wr_en => wr2,
    rd_en => rd_en2,
    dout => r_fft2,
    full => f1,
    empty => e1
  );

second_fft_imaginary : fifo_memory
  PORT MAP (
    clk => clk,
    srst => e,
    din => imag_fft,
    wr_en => wr2,
    rd_en => rd_en2,
    dout => i_fft2,
    full => f2,
    empty => e2
  );
  
third_fft_real : fifo_memory
  PORT MAP (
    clk => clk,
    srst => e,
    din => real_fft,
    wr_en => wr3,
    rd_en => rd_en3,
    dout => r_fft3,
    full => f3,
    empty => e3
	 ); 

third_fft_imaginary : fifo_memory
  PORT MAP (
    clk => clk,
    srst => e,
    din => imag_fft,
    wr_en => wr3,
    rd_en => rd_en3,
    dout => i_fft3,
    full => f4,
    empty => e4
	 ); 

end Behavioral;

