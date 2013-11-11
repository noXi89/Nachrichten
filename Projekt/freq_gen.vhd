library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;

entity freq_gen is
	port
	(
		clk50mhz		: in std_logic;
		reset			: in std_logic;
		clk20Hz			: out std_logic
	);
end entity;

architecture rtl of freq_gen is
		-- für Simulation: 10, für Board: 50000000
		constant FPGA_freq: integer := 50000000; --range
		constant FPGA_dest_freq: integer := 20;
		
		signal count1: integer := 0; -- Sekundentakt
		
	begin
		process(clk50mhz, reset)
		begin
			if (reset = '1') then
				clk20Hz <= '0';
				count1 <= 0;
			else
				if(rising_edge(clk50mhz)) then
						if(count1 < FPGA_freq/FPGA_dest_freq/2) then
							clk20Hz <= '0';
							count1 <= count1+1;
						elsif(count1 < ((FPGA_freq/FPGA_dest_freq) - 1)) then
							clk20Hz <= '1';
							count1 <= count1+1;
						else
							count1 <= 0;
						end if;
				end if;
			end if;
		end process;
	end rtl;
			