library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;

entity freq_gen is
	port
	(
		clk50mhz		: in std_logic;
		reset			: in std_logic;
		clk20Hz		: out std_logic := '0';
		clk1MHz		: out std_logic := '0'; --/50
		clkLCD		: out std_logic := '0'
	);
end entity;

architecture rtl of freq_gen is
		-- für Simulation: 10, für Board: 50000000
		constant FPGA_freq: integer := 50000000; --range
		
		constant FPGA_dest_freq: integer := 20;
		constant FPGA_dest_freq_1mhz: integer := 1000000;
		constant FPGA_dest_freq_LCD: integer := 31250; -- entspricht 50.000.000 / 1600 -> 10 mal 160 Zeichen auf der LCD-Anzeige
		
		signal count1: integer := 0; -- Sekundentakt
		signal count2: integer := 0; -- Sekundentakt
		signal count3: integer := 0; -- Sekundentakt
		
	begin
		process(clk50mhz, reset)
		begin
--			if (reset = '0') then
--				clk20Hz <= '0';
--				clk1MHz <= '0';
--				clkLCD <= '0';
--				count1 <= 0;
--				count2 <= 0;
--				count3 <= 0;
--			else
				if(rising_edge(clk50mhz)) then
						-- clock 1
						if(count1 < FPGA_freq / FPGA_dest_freq / 2) then
							clk20Hz <= '0';
							count1 <= count1 + 1;
						elsif(count1 < ((FPGA_freq / FPGA_dest_freq) - 1)) then
							clk20Hz <= '1';
							count1 <= count1 + 1;
						else
							count1 <= 0;
						end if;
						
						-- clock 2
						if(count2 < FPGA_freq / FPGA_dest_freq_1mhz / 2) then -- 25
							clk1MHz <= '0';
							count2 <= count2 + 1;
						elsif(count2 < ((FPGA_freq / FPGA_dest_freq_1mhz) - 1)) then -- 50
							clk1MHz <= '1';
							count2 <= count2 + 1;
						else
							count2 <= 0;
						end if;
						
						-- clock 3
						if(count3 < FPGA_freq / FPGA_dest_freq_LCD / 2) then
							clkLCD <= '0';
							count3 <= count3 + 1;
						elsif(count3 < ((FPGA_freq / FPGA_dest_freq_LCD) - 1)) then
							clkLCD <= '1';
							count3 <= count3 + 1;
						else
							count3 <= 0;
						end if;
				end if;
--			end if;
		end process;
	end rtl;
			