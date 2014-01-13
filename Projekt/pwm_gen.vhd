library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pwm_gen is
	port
	(
		clock			: in std_logic := '0';
		reset			: in std_logic := '1';
		drehzahl		: in std_logic_vector (15 downto 0) := "0000000000000000"; -- Range 0 - 65535 
		richtung		: in std_logic := '0';
		pwm			: out std_logic := '0'
		
	);
end entity;

architecture rtl of pwm_gen is
	constant major_cycle_ticks: integer := 65536; --max drehzahl*2 hier anpassen!
	-- constant major_cycle_ticks: integer := 10; --DEBUG
	signal drehzahl_last: std_logic_vector (15 downto 0) := "1010100000000000";
	signal richtung_last: std_logic := '0';
	begin
		process(clock, reset)
			variable tick: integer := 0;
			variable minor_cycle_ticks: integer := 0;
			variable richtung_intern: std_logic := '1';
			variable drehzahl_intern: std_logic_vector (15 downto 0) := "0000000000000000";
		begin
			if(reset = '0') then
				tick := 0;
			elsif(rising_edge(clock)) then
				tick := tick + 1;
				drehzahl_intern := drehzahl;
				drehzahl_last <= drehzahl_intern;
				richtung_intern := richtung;
				richtung_last <= richtung_intern;
				if(drehzahl_intern /= drehzahl_last OR richtung_intern /= richtung_last) then
					minor_cycle_ticks := to_integer(unsigned(drehzahl_intern)/2);
					if(richtung_intern = '0') then
						minor_cycle_ticks := (major_cycle_ticks/2) - minor_cycle_ticks;
					else
						minor_cycle_ticks := (major_cycle_ticks/2) + minor_cycle_ticks;
					end if;
				end if;
				
				if(tick > minor_cycle_ticks) then
					pwm <= '1';
				else
					pwm <= '0';
				end if;
				
				if(tick > major_cycle_ticks) then
					tick := 0;
				end if;
				
			end if;
		end process;
	end rtl;