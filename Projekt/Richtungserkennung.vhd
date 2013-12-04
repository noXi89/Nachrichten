library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;

entity richtungserkennung is
	port
	(
		clock			: in std_logic := '0';
		reset			: in std_logic := '1';
		
		sig1			: in std_logic := '1';
		sig2			: in std_logic := '1';
		
		error			: out std_logic := '1';
		richtung		: out std_logic := '0'
	);
end entity;

architecture rtl of richtungserkennung is
--	constant MAX_ROW: integer := 7;
	constant ERRORCOUNTER_MAX: integer := 9999999;
	signal errorcounter: integer := 0;
	begin
		process(clock, reset, sig1, sig2)
			--variable current_row: integer := 1;
			variable last_sig1: std_logic := '1';
					
		begin
			if(reset = '0') then
				last_sig1 := '1';
				error <= '1';
				-- row <= conv_std_logic_vector(0, 4);
			elsif(rising_edge(clock)) then
				if(last_sig1 = '0' AND sig1 = '1') then
					-- Steigende Flanke sig1
					error <= '0';
					errorcounter <= 0;
					if(sig2 = '0') then
						-- Richtung 1
						richtung <= '0';
					else
						-- Richtung 2
						richtung <= '1';
					end if;
				else
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