--Daniel Song (301471879) - Kwanghyuk Ryu (301475831)
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity BlinkSystem is 
	port (enable : in std_logic;
			clk : in std_logic;
			seg0, seg1, seg2, seg3 : out std_logic_vector(6 downto 0 );
			ledg : out std_logic_vector(7 downto 0);
			ledr : out std_logic_vector(17 downto 0));
end BlinkSystem;

architecture behavioural of BlinkSystem is
	component Prescale is 
		port ( clk_in: in std_logic;
			clk_out: out std_logic);
	end component;
	
	constant sigseg0 : std_logic_vector(6 downto 0) := "0001001"; --"0110111"
	constant sigseg1 : std_logic_vector(6 downto 0) := "0000110"; --"1001111"
	constant sigseg2 : std_logic_vector(6 downto 0) := "1000111"; --"0001110"
	constant sigseg3 : std_logic_vector(6 downto 0) := "0001100"; --"1100111"
	constant off : std_logic_vector(6 downto 0) := "1111111";
	signal clock : std_logic;
	signal final_clock : std_logic := '1';
	
begin
	u1 : Prescale port map(clk, clock);
	
	process(enable,clock)
	begin 
		if rising_edge(clock) then
			if enable = '1' then
				final_clock <= not final_clock;
			else
				final_clock <= '1';
			end if;
		end if;
	end process;
	
	process(final_clock)
	begin
		if (final_clock <= '0') then
				seg0 <= sigseg0;
				seg1 <= sigseg1;
				seg2 <= sigseg2;
				seg3 <= sigseg3;
				ledg <= (others => '1');
				ledr <= (others => '1');
		else
				seg0 <= off;
				seg1 <= off;
				seg2 <= off;
				seg3 <= off;
				ledg <= (others => '0');
				ledr <= (others => '0');
		end if;
	end process;
	
end behavioural;
	
			
			
			
			
			