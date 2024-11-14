--Daniel Song (301471879) - Kwanghyuk Ryu (301475831)
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity DisarmSystem is
    Port (
        clk : in STD_LOGIC;
        w : in STD_LOGIC_VECTOR(1 downto 0);
        seg2, seg1, seg0 : out STD_LOGIC_VECTOR(6 downto 0);
        disarm : out STD_LOGIC
    );
end DisarmSystem;

architecture Behavioral of DisarmSystem is

type state_type is (off, State1, State2, State3);
signal state, next_state : state_type;

constant seg_3 : STD_LOGIC_VECTOR(6 downto 0) := "0110000"; 
constant seg_1 : STD_LOGIC_VECTOR(6 downto 0) := "1111001"; 
constant seg_2 : STD_LOGIC_VECTOR(6 downto 0) := "0100100"; 
constant seg_off : STD_LOGIC_VECTOR(6 downto 0) := "1111111"; 

begin

process (clk)
begin
    if rising_edge(clk) then
        state <= next_state;
    end if;
end process;

process (state, w)
begin
    case state is
        when off =>
            if w = "11" then
                next_state <= State1;
            else
                next_state <= off;
            end if;
        when State1 =>
            if w = "01" then
                next_state <= State2;
            else
                next_state <= off;
            end if;
        when State2 =>
            if w = "10" then
                next_state <= State3;
            else
                next_state <= off;
            end if;
        when State3 =>
            next_state <= off;
    end case;
end process;

process (state)
begin
    case state is
        when off =>
            seg2 <= seg_off;
            seg1 <= seg_off;
            seg0 <= seg_off;
            disarm <= '0';
        when State1 =>
            seg2 <= seg_3;
            seg1 <= seg_OFF;
            seg0 <= seg_OFF;
            disarm <= '0';
        when State2 =>
            seg2 <= seg_3;
            seg1 <= seg_1;
            seg0 <= seg_OFF;
            disarm <= '0';
        when State3 =>
            seg2 <= seg_3;
            seg1 <= seg_1;
            seg0 <= seg_2;
            disarm <= '1';
    end case;
end process;

end Behavioral;