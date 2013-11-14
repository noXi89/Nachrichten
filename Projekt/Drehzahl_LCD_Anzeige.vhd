library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;

entity Drehzahl_LCD_Anzeige is
	port
	(
		clock			: in std_logic := '0';
		reset			: in std_logic := '1';
		error			: in std_logic := '1';
		-- charposition: in integer range 0 to 159;
		charposition: in std_logic_vector(7 downto 0) := "00000000";
		drehzahl		: in std_logic_vector(15 downto 0) := "0000000000000000";
		richtung		: in std_logic := '0';
		
		ascii_out	: out std_logic_vector(7 downto 0) := x"20";
		write_enable: out std_logic := '0'
	);
end entity;

architecture rtl of Drehzahl_LCD_Anzeige is
	signal current_drehzahl: std_logic_vector(15 downto 0) := "0000000000000000";
	begin
		process(clock, reset, error, charposition, drehzahl, richtung)
			variable counter: integer := 0;
			variable int_val: integer := 0;
			variable int_charposition: integer := 0;
			
			variable value_position_1: integer := 0;
			variable value_position_10: integer := 0;
			variable value_position_100: integer := 0;
			variable value_position_1000: integer := 0;
			variable value_position_10000: integer := 0;
			
		begin
			if(reset = '0') then
				int_charposition := to_integer(ieee.numeric_std.unsigned(charposition));
				current_drehzahl <= "0000000000000000";
				
				if(int_charposition >= 0 AND int_charposition <= 159) then
				-- if(charposition >= 0 AND charposition <= 159) then
					write_enable <= '1';
				else
					write_enable <= '0';
				end if;
				
				-- Gibt nur noch das Wort "RESET" aus
				case int_charposition is
				-- case charposition is
					when 1 => ascii_out <= x"52"; -- R
					when 2 => ascii_out <= x"45"; -- E
					when 3 => ascii_out <= x"53"; -- S
					when 4 => ascii_out <= x"45"; -- E
					when 5 => ascii_out <= x"54"; -- T
					when others => ascii_out <= x"20"; -- Leerzeichen;
				end case;
			elsif(rising_edge(clock)) then
				int_charposition := to_integer(ieee.numeric_std.unsigned(charposition));
				ascii_out <= x"20"; -- Leerzeichen
				
				if(int_charposition >= 0 AND int_charposition <= 159) then
				-- if(charposition >= 0 AND charposition <= 159) then
					write_enable <= '1';
				else
					write_enable <= '0';
				end if;
				
				if(error = '1') then
					-- Bei Fehler -> Ersetze Drehzahl- und Richtungsausgabe durch Sternchen
					if(int_charposition >= 1 AND int_charposition <= 5) then
					-- if(charposition >= 1 AND charposition <= 5) then
						ascii_out <= x"2A"; -- *
					elsif(int_charposition >= 40 AND int_charposition <= 45) then
					-- elsif(charposition >= 40 AND charposition <= 45) then
						ascii_out <= x"2A"; -- *
					end if;
				else
					if(drehzahl /= current_drehzahl) then
						-- Die Drehzahl hat sich geaendert -> Berechne alle Ziffern neu
						current_drehzahl <= drehzahl;
						int_val := to_integer(ieee.numeric_std.unsigned(drehzahl));
						
						counter := 0;
						while int_val >= 10000 loop
							int_val := int_val - 10000;
							counter := counter + 1;
							exit when counter >= 9;
						end loop;
						value_position_10000 := counter;
						
						counter := 0;
						while int_val >= 1000 loop
							int_val := int_val - 1000;
							counter := counter + 1;
							exit when counter >= 9;
						end loop;
						value_position_1000 := counter;
						
						counter := 0;
						while int_val >= 100 loop
							int_val := int_val - 100;
							counter := counter + 1;
							exit when counter >= 9;
						end loop;
						value_position_100 := counter;
						
						counter := 0;
						while int_val >= 10 loop
							int_val := int_val - 10;
							counter := counter + 1;
							exit when counter >= 9;
						end loop;
						value_position_10 := counter;
						
						counter := 0;
						while int_val > 1 loop
							int_val := int_val - 1;
							counter := counter + 1;
							exit when counter >= 9;
						end loop;
						value_position_1 := counter;
					end if;
					
					-- Ausgabe der einzelnen ermittelten Ziffern
					case int_charposition is
					-- case charposition is
						when 1 =>
							if(value_position_10000 = 0) then
								ascii_out <= x"20";
							else
								ascii_out <= conv_std_logic_vector(48 + value_position_10000, 8); -- ASCII-Null + Ziffer
							end if;
						when 2 =>
							if(value_position_1000 = 0) then
								ascii_out <= x"20";
							else
								ascii_out <= conv_std_logic_vector(48 + value_position_1000, 8); -- ASCII-Null + Ziffer
							end if;
						when 3 =>
							if(value_position_100 = 0) then
								ascii_out <= x"20";
							else
								ascii_out <= conv_std_logic_vector(48 + value_position_100, 8); -- ASCII-Null + Ziffer
							end if;
						when 4 =>
							if(value_position_10 = 0) then
								ascii_out <= x"20";
							else
								ascii_out <= conv_std_logic_vector(48 + value_position_10, 8); -- ASCII-Null + Ziffer
							end if;
						when 5 =>
							ascii_out <= conv_std_logic_vector(48 + value_position_1, 8); -- ASCII-Null + Ziffer
						when others =>
							null;
					end case;
					
					-- Ausgabe der Richtung
					if(richtung = '0') then
						case int_charposition is
						-- case charposition is
							when 41 => ascii_out <= x"6C"; -- l
							when 42 => ascii_out <= x"69"; -- i
							when 43 => ascii_out <= x"6E"; -- n
							when 44 => ascii_out <= x"6B"; -- k
							when 45 => ascii_out <= x"73"; -- s
							when others => null;
						end case;
					else
						case int_charposition is
						-- case charposition is
							when 40 => ascii_out <= x"72"; -- r
							when 41 => ascii_out <= x"65"; -- e
							when 42 => ascii_out <= x"63"; -- c
							when 43 => ascii_out <= x"68"; -- h
							when 44 => ascii_out <= x"74"; -- t
							when 45 => ascii_out <= x"73"; -- s
							when others => null;
						end case;
					end if;
				end if; -- end if error
				
				-- Ausgabe der Masseinheit
				case int_charposition is
				-- case charposition is
					when 7  => ascii_out <= x"55"; -- U
					when 8  => ascii_out <= x"2F"; -- /
					when 9  => ascii_out <= x"4D"; -- M
					when 10 => ascii_out <= x"69"; -- i
					when 11 => ascii_out <= x"6E"; -- n
					when others => null;
				end case;
			end if;
		end process;
	end rtl;