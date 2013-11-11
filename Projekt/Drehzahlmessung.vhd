library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;
use IEEE.MATH_REAL.ALL;

entity drehzahlmessung is
	port
	(
		clock			: in std_logic := '0'; -- 50kHz
		reset			: in std_logic := '1';
		
		sig1			: in std_logic := '1';
		
		error			: out std_logic := '1';
		drehzahl		: out std_logic_vector (15 downto 0) := "0000000000000000" -- Range 0 - 65535 
	);
end entity;

architecture rtl of drehzahlmessung is
--	constant MAX_ROW: integer := 7;
	constant FACTOR: integer := 100000;
	constant CLOCK_TIME_US: integer := 20; -- 50kHz
	-- 0,00000002 Sekunden | 20 ns | 50Mhz
	-- 0,00002 Sekunden | 20 us | 50 kHz
	begin
		process(clock, reset, sig1)
			--variable current_row: integer := 1;
			variable last_sig1: std_logic := '1';
			variable counter: integer := 0;
			variable us_per_round: integer := 0;
			variable rpm: integer := 0;
		begin
			if(reset = '0') then
				last_sig1 := '1';
				error <= '1';
				-- row <= conv_std_logic_vector(0, 4);
			elsif(rising_edge(clock)) then
				if(last_sig1 = '0' AND sig1 = '1') then
					-- Steigende Flanke sig1
					error <= '0';
					if(counter > 0) then
						us_per_round := counter * CLOCK_TIME_US ;
						-- drehzahl <= conv_std_logic_vector(FACTOR* 60 / (us_per_round),16);
						rpm := (FACTOR * 60) / (us_per_round);
						drehzahl <= conv_std_logic_vector(rpm, 16);
					end if;
					counter := 0;
				else
					counter := counter + 1;
				end if;
				last_sig1 := sig1;
			end if;
		end process;
	end rtl;