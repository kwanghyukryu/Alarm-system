--Daniel Song (301471879) - Kwanghyuk Ryu (301475831)
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TestDisarmSystem is
    Port (
        KEY : in STD_LOGIC_VECTOR(0 downto 0);
        SW : in STD_LOGIC_VECTOR(1 downto 0);
        HEX2 : out STD_LOGIC_VECTOR(6 downto 0);
        HEX1 : out STD_LOGIC_VECTOR(6 downto 0);
        HEX0 : out STD_LOGIC_VECTOR(6 downto 0);
        LEDG : out STD_LOGIC_VECTOR(8 downto 8)
    );
end TestDisarmSystem;

architecture Behavioral of TestDisarmSystem is

component DisarmSystem is
    Port (
        clk : in STD_LOGIC;
        w : in STD_LOGIC_VECTOR(1 downto 0);
        seg2 : out STD_LOGIC_VECTOR(6 downto 0);
        seg1 : out STD_LOGIC_VECTOR(6 downto 0);
        seg0 : out STD_LOGIC_VECTOR(6 downto 0);
        disarm : out STD_LOGIC
    );
end component;

signal disarm_signal : STD_LOGIC;

begin

	LEDG(8) <= disarm_signal;
	u1: DisarmSystem Port map (KEY(0),SW,HEX2,HEX1,HEX0,disarm_signal);



end Behavioral;