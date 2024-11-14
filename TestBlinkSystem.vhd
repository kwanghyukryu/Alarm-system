--Daniel Song (301471879) - Kwanghyuk Ryu (301475831)
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity TestBlinkSystem is
	port( SW : in std_logic_vector(0 downto 0);
			Clock_50 : in std_logic;
			HEX7, HEX6, HEX5, HEX4 : out std_logic_vector(6 downto 0);
			LEDG : out std_logic_vector(7 downto 0);
			LEDR : out std_logic_vector(17 downto 0));
end TestBlinkSystem;

architecture behavioural of TestBlinkSystem is
	signal enable : std_logic;
	component BlinkSystem is
		port (enable : in std_logic;
			clk : in std_logic;
			seg0, seg1, seg2, seg3 : out std_logic_vector(6 downto 0 );
			ledg : out std_logic_vector(7 downto 0);
			ledr : out std_logic_vector(17 downto 0));
	end component;

begin
	enable <= SW(0);
	u1 : BlinkSystem port map(enable, Clock_50, HEX7, HEX6, HEX5, HEX4, LEDG, LEDR);
	
end behavioural;