library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;

entity entprell is
	port
	(
		fast_clk			: in std_logic;
--		reset			: in std_logic;
		i				: in std_logic;
		o				: out std_logic := '0'
	);
end entity;

architecture rtl of entprell is
		signal onoff: integer := 0;
		signal count: integer := 0;
		constant MIN_COUNT: integer := 8;
	begin
		process(fast_clk, i)
		begin
			if(rising_edge(fast_clk)) then
--				if(reset = '1') then
--					o <= '0';
--					count <= 0;
--					onoff <= 0;
--				else
			
					if(onoff = 0) then -- will an gehen 
						if(i = '1') then
							count <= count + 1;
						else
							count <= 0;
						end if; 
						-- check if count reached min
						if( count > (MIN_COUNT) ) then
							count <= 0;
							o <= '1';
							onoff <= 1;
						end if;
						
					else -- onoff = 1 -- will aus gehen
						if(i = '0') then
							count <= count + 1;
						else
							count <= 0;
						end if;
						-- check if count reached max
						if( count > (MIN_COUNT) ) then
							count <= 0;
							o <= '0';
							onoff <= 0;
						end if;
					end if;
					
--				end if; --reset
			end if; --rising_edge
		end process;		
	end rtl;
			