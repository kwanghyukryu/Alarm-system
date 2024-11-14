--Daniel Song (301471879) - Kwanghyuk Ryu (301475831)
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity AlarmSystem is
    Port (
        CLOCK_50 : in STD_LOGIC;
        KEY : in STD_LOGIC_VECTOR(0 downto 0);
        SW : in STD_LOGIC_VECTOR(17 downto 0);
        HEX7 : out STD_LOGIC_VECTOR(6 downto 0);
        HEX6 : out STD_LOGIC_VECTOR(6 downto 0);
        HEX5 : out STD_LOGIC_VECTOR(6 downto 0);
        HEX4 : out STD_LOGIC_VECTOR(6 downto 0);
        HEX2 : out STD_LOGIC_VECTOR(6 downto 0);
        HEX1 : out STD_LOGIC_VECTOR(6 downto 0);
        HEX0 : out STD_LOGIC_VECTOR(6 downto 0);
        LEDG : out STD_LOGIC_VECTOR(8 downto 0);
        LEDR : out STD_LOGIC_VECTOR(17 downto 0)
    );
end AlarmSystem;

architecture Behavioral of AlarmSystem is

component BlinkSystem is
    port (
			enable : in std_logic;
			clk : in std_logic;
			seg0, seg1, seg2, seg3 : out std_logic_vector(6 downto 0 );
			ledg : out std_logic_vector(7 downto 0);
			ledr : out std_logic_vector(17 downto 0)
		);
end component;

component DisarmSystem is
    Port (
        clk : in STD_LOGIC;
        w : in STD_LOGIC_VECTOR(1 downto 0);
        seg2, seg1, seg0 : out STD_LOGIC_VECTOR(6 downto 0);
        disarm : out STD_LOGIC
    );
end component;

signal disarm_signal : STD_LOGIC;
signal alarm_enable : STD_LOGIC;
signal enable : std_logic := '0';

begin
alarm_enable <= (SW(17) or SW(16) or SW(15));
LEDG(8) <= disarm_signal;

u1: BlinkSystem port map(enable, CLOCK_50,HEX7,HEX6,HEX5,HEX4,LEDG(7 downto 0),LEDR);
u2: DisarmSystem port map(KEY(0),SW(2 downto 1),HEX2,HEX1,HEX0,disarm_signal);

process(enable,disarm_signal, alarm_enable)
begin
	if SW(0) = '1' and alarm_enable = '1' and disarm_signal = '0' then
		enable <= '1';
	else if disarm_signal = '1' then
		enable <= '0';
	end if;
	end if;
end process;


end Behavioral;