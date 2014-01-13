library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--use ieee.std_logic_arith.all;

entity anzeige_richtung is
	port
	(
		clock			: in std_logic := '0';
		reset			: in std_logic := '1';
		
		error			: in std_logic := '1';
		richtung		: in std_logic := '1';
		drehzahl_ist: in  std_logic_vector(15 downto 0) := (others => '0');
		
		seg1			: out std_logic_vector(7 downto 0) := "00000000";
		seg2			: out std_logic_vector(7 downto 0) := "00000000";
		leds			: out std_logic_vector(17 downto 0) := "000000000000000000"
	);
end entity;

architecture rtl of anzeige_richtung is
	type map_type is array (0 to 7) of std_logic_vector(7 downto 0);									
	constant map_seg2: map_type := (
												0 => (0 => '1', others => '0'),
												1 => (others => '0'),
												2 => (others => '0'),
												3 => (others => '0'),
												4 => (others => '0'),
												5 => (3 => '1', others => '0'),
												6 => (4 => '1', others => '0'),
												7 => (5 => '1', others => '0')
											);

	constant map_seg1: map_type := (
												0 => (others => '0'),
												1 => (0 => '1', others => '0'),
												2 => (1 => '1', others => '0'),
												3 => (2 => '1', others => '0'),
												4 => (3 => '1', others => '0'),
												5 => (others => '0'),
												6 => (others => '0'),
												7 => (others => '0')
											);
	constant ani_delta: integer := 1; -- aendern zu -1, wenn Richtung falsch
	
	constant MAX_RPM: integer := 1100;
	constant MIN_RPM: integer := 300;
	
	begin
		process(clock, reset, error, richtung)
		variable ani_counter: integer := 0;
		variable threshold_counter: integer := 0;
		variable threshold: integer := 0;

		begin
			if(reset = '0') then
				seg1 <= "00000000";
				seg2 <= "00000000";
			elsif(rising_edge(clock)) then
				threshold := (MAX_RPM - to_integer(unsigned(drehzahl_ist))) /MIN_RPM;
				threshold_counter := threshold_counter + 1;
				if(threshold_counter >= threshold) then
					threshold_counter := 0;
					
					if(error = '0') then
						-- Signal korrekt, auswerten!
						if(richtung = '0') then
							-- Richtung 1
							ani_counter := ani_counter + ani_delta;
						else
							-- Richtung 2
							ani_counter := ani_counter - ani_delta;
						end if;
						-- counter korrigieren
						ani_counter := ani_counter mod 8;
						
						-- Ausgabe
						seg1 <= NOT map_seg1(7 - ani_counter);
						seg2 <= NOT map_seg2(7 - ani_counter);
						
					end if;
				end if;
			end if;
		end process;

    process(clock, reset, error, richtung)
		variable ani_counter: integer := 0;
		variable threshold_counter: integer := 0;
		variable threshold: integer := 0;
		begin
			if(reset = '0') then
			elsif(rising_edge(clock)) then
				threshold := (MAX_RPM - to_integer(unsigned(drehzahl_ist))) /MIN_RPM;
				threshold_counter := threshold_counter + 1;
				if(threshold_counter >= threshold) then
					threshold_counter := 0;
					
					if(error = '0') then
						-- Signal korrekt, auswerten!
						if(richtung = '0') then
							-- Richtung 1
							ani_counter := ani_counter + ani_delta;
						else
							-- Richtung 2
							ani_counter := ani_counter - ani_delta;
						end if;
						-- counter korrigieren
						ani_counter := ani_counter mod 18;
						
						-- Ausgabe
						leds <= (others => '0');
						leds(ani_counter) <= '1';
					end if;
				end if;
			end if;
		end process;

  end rtl;