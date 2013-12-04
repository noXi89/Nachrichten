library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;
use IEEE.MATH_REAL.ALL;

entity drehzahlmessung is
	port
	(
		clock			: in std_logic := '0'; -- 1MHz
		reset			: in std_logic := '1';
		
		sig1			: in std_logic := '1';
		
		error			: out std_logic := '1';
		drehzahl		: out std_logic_vector (15 downto 0) := "0000000000000000" -- Range 0 - 65535 
	);
end entity;

architecture rtl of drehzahlmessung is
--	constant MAX_ROW: integer := 7;
	constant FACTOR: ieee.numeric_std.unsigned(35 downto 0) := "110111111000010001110101100000000000";--"00100011110000110100011000000000"; -- 600000000 orig:"00000011100100111000011100000000"; --60000000
--	constant FACTOR: integer := 60000000;
	constant CLOCK_TIME_US: ieee.numeric_std.unsigned(7 downto 0) := "00010100"; -- 20ns;
	-- 0,00000002 Sekunden | 20 ns | 50Mhz
	-- 0,00002 Sekunden | 20 us | 50 kHz
	constant PULSES_PER_ROUND: integer := 1024;
	constant ERRORCOUNTER_MAX: integer := 9999999;
	signal errorcounter: integer := 0;
	begin
		process(clock, reset, sig1)
			--variable current_row: integer := 1;
			variable last_sig1: std_logic := '1';
			variable counter: ieee.numeric_std.unsigned(23 downto 0) := "000000000000000000000000";
			--variable counter: integer := 0;
			variable us_per_round: ieee.numeric_std.unsigned(63 downto 0) := "0000000000000000000000000000000000000000000000000000000000000000";
			--variable us_per_round: integer := 0;
			variable rpm : ieee.numeric_std.unsigned(35 downto 0) := "000000000000000000000000000000000000";
			--variable rpm: integer := 0;
			
		begin
			if(reset = '0') then
				last_sig1 := '1';
				error <= '1';
				-- row <= conv_std_logic_vector(0, 4);
			elsif(rising_edge(clock)) then
				--error <= '0';
				--drehzahl(0) <= '1'; --sig1
				if(last_sig1 = '0' AND sig1 = '1') then
					-- Steigende Flanke sig1
					error <= '0';
					errorcounter <= 0;
					if(counter > 0) then
						us_per_round := counter * CLOCK_TIME_US * PULSES_PER_ROUND;
						-- drehzahl <= conv_std_logic_vector(FACTOR* 60 / (us_per_round),16);
						-- ns in min : ns*1.66E-11
						-- 
						rpm := FACTOR / us_per_round;
						--drehzahl <= conv_unsigned(rpm, 16);
						--drehzahl <= conv_std_logic_vector(rpm, 16);
						for i in 0 to drehzahl'LENGTH-1 loop 
							drehzahl(i) <= rpm(i);
						end loop; 
					end if;
					counter := "000000000000000000000000";
				else
					counter := counter + 1;
					errorcounter <= errorcounter + 1;
				end if;
				last_sig1 := sig1;
				
				--error check
				if(errorcounter > ERRORCOUNTER_MAX) then
					error <= '1';
				end if;
				
			end if;
		end process;
	end rtl;