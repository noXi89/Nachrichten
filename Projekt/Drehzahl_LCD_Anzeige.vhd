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
	
	signal value_position_1: integer range 0 to 9 := 0;
	signal value_position_10: integer range 0 to 9 := 0;
	signal value_position_100: integer range 0 to 9 := 0;
	signal value_position_1000: integer range 0 to 9 := 0;
	signal value_position_10000: integer range 0 to 9 := 0;
	
	begin
		process(clock, drehzahl)
			variable int_val: integer := 0;
			variable counter: integer := 0;
		begin
			if(reset = '0') then
				current_drehzahl <= "0000000000000000";
			elsif(rising_edge(clock)) then
				if(drehzahl /= current_drehzahl) then
					int_val := to_integer(ieee.numeric_std.unsigned(drehzahl));
					current_drehzahl <= drehzahl;
					
					value_position_1 <= int_val mod 10;
					int_val := int_val / 10;
					value_position_10 <= int_val mod 10;
					int_val := int_val / 10;
					value_position_100 <= int_val mod 10;
					int_val := int_val / 10;
					value_position_1000 <= int_val mod 10;
					int_val := int_val / 10;
					value_position_10000 <= int_val;
--					counter := 0;
--					while int_val >= 10000 loop
--						int_val := int_val - 10000;
--						counter := counter + 1;
--						exit when counter >= 9;
--					end loop;
--					value_position_10000 <= counter;
--					
--					counter := 0;
--					while int_val >= 1000 loop
--						int_val := int_val - 1000;
--						counter := counter + 1;
--						exit when counter >= 9;
--					end loop;
--					value_position_1000 <= counter;
--					
--					counter := 0;
--					while int_val >= 100 loop
--						int_val := int_val - 100;
--						counter := counter + 1;
--						exit when counter >= 9;
--					end loop;
--					value_position_100 <= counter;
--					
--					counter := 0;
--					while int_val >= 10 loop
--						int_val := int_val - 10;
--						counter := counter + 1;
--						exit when counter >= 9;
--					end loop;
--					value_position_10 <= counter;
--					
--					if(int_val >= 0) then
--						value_position_1 <= int_val;
--					end if;
				end if;
			end if;
		end process;
	
		process(clock, reset, error, charposition, drehzahl, richtung)
			-- variable counter: integer := 0;
			-- variable int_val: integer := 0;
			-- variable int_charposition: integer range 0 to 159 := 0;
			
			-- variable value_position_1: integer := 0;
			-- variable value_position_10: integer := 0;
			-- variable value_position_100: integer := 0;
			-- variable value_position_1000: integer := 0;
			-- variable value_position_10000: integer := 0;
			
		begin
			if(reset = '0') then
				-- int_charposition := to_integer(ieee.numeric_std.unsigned(charposition));
				-- current_drehzahl <= "0000000000000000";
				
				-- if(charposition >= 0 AND int_charposition <= 159) then
				if(charposition >= x"00" AND charposition <= x"9F") then
					write_enable <= '1';
				else
					write_enable <= '0';
				end if;
				
				-- Gibt nur noch das Wort "RESET" aus
				-- case int_charposition is
				case charposition is
					when x"01" => ascii_out <= x"52"; -- R
					when x"02" => ascii_out <= x"45"; -- E
					when x"03" => ascii_out <= x"53"; -- S
					when x"04" => ascii_out <= x"45"; -- E
					when x"05" => ascii_out <= x"54"; -- T
					when others => ascii_out <= x"20"; -- Leerzeichen;
				end case;
			elsif(rising_edge(clock)) then
				-- int_charposition := to_integer(ieee.numeric_std.unsigned(charposition));
				ascii_out <= x"20"; -- Leerzeichen
				
				-- if(int_charposition >= 0 AND int_charposition <= 159) then
				if(charposition >= x"00" AND charposition <= x"9F") then
					write_enable <= '1';
				else
					write_enable <= '0';
				end if;
				
				if(error = '1') then
					-- Bei Fehler -> Ersetze Drehzahl- und Richtungsausgabe durch Sternchen
					-- if(int_charposition >= 1 AND int_charposition <= 5) then
					if(charposition >= x"01" AND charposition <= x"05") then
						ascii_out <= x"2A"; -- *
					-- elsif(int_charposition >= 40 AND int_charposition <= 45) then
					elsif(charposition >= x"28" AND charposition <= x"2D") then
						ascii_out <= x"2A"; -- *
					end if;
				else
					-- if(drehzahl /= current_drehzahl) then
						-- Die Drehzahl hat sich geaendert -> Berechne alle Ziffern neu
						-- current_drehzahl <= drehzahl;
						-- int_val := to_integer(ieee.numeric_std.unsigned(drehzahl));
						
						-- counter := 0;
						-- while int_val >= 10000 loop
						-- 	int_val := int_val - 10000;
						-- 	counter := counter + 1;
						-- 	exit when counter >= 9;
						-- end loop;
						-- value_position_10000 := counter;
						
						-- counter := 0;
						-- while int_val >= 1000 loop
						-- 	int_val := int_val - 1000;
						-- 	counter := counter + 1;
						-- 	exit when counter >= 9;
						-- end loop;
						-- value_position_1000 := counter;
						
						-- counter := 0;
						-- while int_val >= 100 loop
						-- 	int_val := int_val - 100;
						-- 	counter := counter + 1;
						-- 	exit when counter >= 9;
						-- end loop;
						-- value_position_100 := counter;
						
						-- counter := 0;
						-- while int_val >= 10 loop
						-- 	int_val := int_val - 10;
						-- 	counter := counter + 1;
						-- 	exit when counter >= 9;
						-- end loop;
						-- value_position_10 := counter;
						
						-- counter := 0;
						-- while int_val > 1 loop
						-- 	int_val := int_val - 1;
						-- 	counter := counter + 1;
						-- 	exit when counter >= 9;
						-- end loop;
						-- value_position_1 := counter;
					-- end if;
					
					-- Ausgabe der einzelnen ermittelten Ziffern
					-- case int_charposition is
					case charposition is
						when x"01" =>
							if(value_position_10000 = 0) then
								ascii_out <= x"20";
							else
								ascii_out <= conv_std_logic_vector(48 + value_position_10000, 8); -- ASCII-Null + Ziffer
							end if;
						when x"02" =>
							if(value_position_1000 = 0) then
								ascii_out <= x"20";
							else
								ascii_out <= conv_std_logic_vector(48 + value_position_1000, 8); -- ASCII-Null + Ziffer
							end if;
						when x"03" =>
							if(value_position_100 = 0) then
								ascii_out <= x"20";
							else
								ascii_out <= conv_std_logic_vector(48 + value_position_100, 8); -- ASCII-Null + Ziffer
							end if;
						when x"04" =>
							if(value_position_10 = 0) then
								ascii_out <= x"20";
							else
								ascii_out <= conv_std_logic_vector(48 + value_position_10, 8); -- ASCII-Null + Ziffer
							end if;
						when x"05" =>
							ascii_out <= conv_std_logic_vector(48 + value_position_1, 8); -- ASCII-Null + Ziffer
						when others =>
							null;
					end case;
					
					-- Ausgabe der Richtung
					if(richtung = '0') then
						-- case int_charposition is
						case charposition is
							when x"29" => ascii_out <= x"6C"; -- l
							when x"2A" => ascii_out <= x"69"; -- i
							when x"2B" => ascii_out <= x"6E"; -- n
							when x"2C" => ascii_out <= x"6B"; -- k
							when x"2D" => ascii_out <= x"73"; -- s
							when others => null;
						end case;
					else
						-- case int_charposition is
						case charposition is
							when x"28" => ascii_out <= x"72"; -- r
							when x"29" => ascii_out <= x"65"; -- e
							when x"2A" => ascii_out <= x"63"; -- c
							when x"2B" => ascii_out <= x"68"; -- h
							when x"2C" => ascii_out <= x"74"; -- t
							when x"2D" => ascii_out <= x"73"; -- s
							when others => null;
						end case;
					end if;
				end if; -- end if error
				
				-- Ausgabe der Masseinheit
				-- case int_charposition is
				case charposition is
					when x"07" => ascii_out <= x"55"; -- U
					when x"08" => ascii_out <= x"2F"; -- /
					when x"09" => ascii_out <= x"4D"; -- M
					when x"0A" => ascii_out <= x"69"; -- i
					when x"0B" => ascii_out <= x"6E"; -- n
					when others => null;
				end case;
			end if;
		end process;
	end rtl;