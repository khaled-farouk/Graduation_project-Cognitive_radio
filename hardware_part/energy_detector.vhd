----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    06:34:29 06/13/2019 
-- Design Name: 
-- Module Name:    energy_detector - Behavioral 
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

entity energy_detector is
     port( clk : in std_logic;
	        start : in std_logic;
			  sclr : in std_logic;
	        user : in std_logic_vector ( 7 downto 0);
			  x : out std_logic_vector ( 15 downto 0);
			  rdy1 : out std_logic;
			  rdy2 : out std_logic;
			  rdy3 : out std_logic
			  );
end energy_detector;

architecture Behavioral of energy_detector is
COMPONENT fft_new_ed
  PORT (
    clk : IN STD_LOGIC;
    ce : IN STD_LOGIC;
    sclr : IN STD_LOGIC;
    start : IN STD_LOGIC;
    xn_re : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    xn_im : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    fwd_inv : IN STD_LOGIC;
    fwd_inv_we : IN STD_LOGIC;
    scale_sch : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
    scale_sch_we : IN STD_LOGIC;
    rfd : OUT STD_LOGIC;
    xn_index : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
    busy : OUT STD_LOGIC;
    edone : OUT STD_LOGIC;
    done : OUT STD_LOGIC;
    dv : OUT STD_LOGIC;
    xk_index : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
    xk_re : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
    xk_im : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
  );
END COMPONENT;

attribute box_type : string;
attribute box_type of fft_new_ed : component is "black_box";

COMPONENT special_controller 
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
end COMPONENT;

COMPONENT fft_memory 
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
end COMPONENT;

COMPONENT energy_calculator 
  PORT (
    clk : IN STD_LOGIC;
    en : IN STD_LOGIC;
    clr : IN STD_LOGIC;
    actual_real : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    actual_imag: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    ed : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
  );
end COMPONENT;


constant I0 : STD_LOGIC_VECTOR (7 downto 0):= "00000000" ;
constant scaling_factor : STD_LOGIC_VECTOR (5 downto 0):= "011010" ;
CONSTANT I1 : STD_LOGIC := '1' ;
signal b,e,d,dv,wr2,wr3,rd_en2,rd_en3,en,clr,rfd : std_logic;
signal n_index,k_index : STD_LOGIC_VECTOR (4 downto 0);
signal imag_fft,real_fft,actual_real,actual_imag,r_fft2,i_fft2,r_fft3,i_fft3 : STD_LOGIC_VECTOR (7 downto 0);
signal ed : STD_LOGIC_VECTOR (15 downto 0);
begin

FFT_MAPING : fft_new_ed
  PORT MAP (
    clk => clk,
	 ce => start,
	 sclr => sclr,
    start => start,
    xn_re => user,
    xn_im => I0,
    fwd_inv => I1,
    fwd_inv_we => I1,
    scale_sch => scaling_factor,
    scale_sch_we => I1,
    rfd => rfd,
    xn_index => n_index,
    busy => b,
    edone => e,
    done => d,
    dv => dv,
    xk_index => k_index,
    xk_re => real_fft,
    xk_im => imag_fft
  );
  
controlling_unit : special_controller
  PORT MAP (
    clk => clk,
    sclr => sclr,
    edone => e,
	 ed => ed,
    wr_en2 => wr2,
    rd_en2 => rd_en2,
	 wr_en3 => wr3,
    rd_en3 => rd_en3,
	 first_real => real_fft,
	 second_real => r_fft2,
	 third_real => r_fft3,
	 first_imag => imag_fft,
	 second_imag => i_fft2,
	 third_imag => i_fft3,
	 real_signal => actual_real,
	 imag_signal => actual_imag,
	 clr => clr,
	 ce => en,
	 x => x,
	 rdy1 => rdy1,
	 rdy2 => rdy2,
	 rdy3 => rdy3
  );
  

memory : fft_memory
  PORT MAP (
    clk => clk,
    e => e,
	 real_fft => real_fft,
    imag_fft => imag_fft,
    wr2 => wr2,
	 wr3 => wr3,
	 rd_en2 => rd_en2,
    rd_en3 => rd_en3,
    r_fft2 => r_fft2,
	 i_fft2 => i_fft2,
	 r_fft3 => r_fft3,
	 i_fft3 => i_fft3
	 ); 

  
calculation : energy_calculator
  PORT MAP (
    clk => clk,
    en => en,
    clr => clr,
	 actual_real => actual_real,
	 actual_imag => actual_imag,
    ed => ed
  );	 	 

end Behavioral;

