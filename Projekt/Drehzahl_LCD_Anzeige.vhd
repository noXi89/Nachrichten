library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--use ieee.std_logic_arith.all;

entity Drehzahl_LCD_Anzeige is
	port
	(
		clock			: in std_logic := '0';
		reset			: in std_logic := '1';
		error_drehzahl: in std_logic := '1';
		error_richtung: in std_logic := '1';
		charposition: in std_logic_vector(7 downto 0) := "00000000";
		drehzahl		: in std_logic_vector(15 downto 0) := "0000000000000000";
		richtung		: in std_logic := '0';
		
		ascii_out	: out std_logic_vector(7 downto 0) := "00100000";
		write_enable: out std_logic := '0'
	);
end entity;

architecture rtl of Drehzahl_LCD_Anzeige is
	signal current_drehzahl: std_logic_vector(15 downto 0) := "0000000000000000";
	
	signal value_position_1: std_logic_vector(3 downto 0) := "0000";
	signal value_position_10: std_logic_vector(3 downto 0) := "0000";
	signal value_position_100: std_logic_vector(3 downto 0) := "0000";
	signal value_position_1000: std_logic_vector(3 downto 0) := "0000";
	signal value_position_10000: std_logic_vector(3 downto 0) := "0000";
	
	begin
		process(clock, reset, drehzahl)
			variable int_val: integer := 0;
			variable temp_val: integer := 0;
			variable counter: integer := 0;
		begin
			if(reset = '0') then
				current_drehzahl <= "0000000000000000";
			elsif(rising_edge(clock)) then
				if(drehzahl /= current_drehzahl) then
					int_val := to_integer(unsigned(drehzahl));
					current_drehzahl <= drehzahl;
					
					temp_val := int_val mod 10;
					value_position_1 <= std_logic_vector(to_unsigned(temp_val, 4));
					
					int_val := int_val / 10;
					temp_val := int_val mod 10;
					value_position_10 <= std_logic_vector(to_unsigned(temp_val, 4));
					
					int_val := int_val / 10;
					temp_val := int_val mod 10;
					value_position_100 <= std_logic_vector(to_unsigned(temp_val, 4));
					
					int_val := int_val / 10;
					temp_val := int_val mod 10;
					value_position_1000 <= std_logic_vector(to_unsigned(temp_val, 4));
					
					int_val := int_val / 10;
					value_position_10000 <= std_logic_vector(to_unsigned(int_val, 4));
				end if;
			end if;
		end process;
	
		process(clock, reset, error_drehzahl, error_richtung, charposition, drehzahl, richtung)
			variable int_val: integer := 0;
		begin
			if(reset = '0') then
				if(charposition >= x"00" AND charposition <= x"9F") then
					write_enable <= '1';
				else
					write_enable <= '0';
				end if;
				
				-- Gibt nur noch das Wort "RESET" aus
				case charposition is
					when x"01" => ascii_out <= x"52"; -- R
					when x"02" => ascii_out <= x"45"; -- E
					when x"03" => ascii_out <= x"53"; -- S
					when x"04" => ascii_out <= x"45"; -- E
					when x"05" => ascii_out <= x"54"; -- T
					when others => ascii_out <= x"20"; -- Leerzeichen;
				end case;
			elsif(rising_edge(clock)) then
				ascii_out <= x"20"; -- Leerzeichen
				
				if(charposition >= x"00" AND charposition <= x"9F") then
					write_enable <= '1';
				else
					write_enable <= '0';
				end if;
				
				if(error_drehzahl = '1') then
					-- Bei Fehler -> Ersetze Drehzahlausgabe durch Sternchen
					if(charposition >= x"01" AND charposition <= x"05") then
						ascii_out <= x"2A"; -- *
					end if;
				else
					-- Ausgabe der einzelnen ermittelten Ziffern
					case charposition is
						when x"01" =>
							int_val := to_integer(unsigned(drehzahl));
							if(int_val < 10000) then
								ascii_out <= x"20";
							else
								ascii_out <= std_logic_vector("00110000" + unsigned(value_position_10000)); -- ASCII-Null + Ziffer
							end if;
						when x"02" =>
							int_val := to_integer(unsigned(drehzahl));
							if(int_val < 1000) then
								ascii_out <= x"20";
							else
								ascii_out <= std_logic_vector("00110000" + unsigned(value_position_1000)); -- ASCII-Null + Ziffer
							end if;
						when x"03" =>
							int_val := to_integer(unsigned(drehzahl));
							if(int_val < 100) then
								ascii_out <= x"20";
							else
								ascii_out <= std_logic_vector("00110000" + unsigned(value_position_100)); -- ASCII-Null + Ziffer
							end if;
						when x"04" =>
							int_val := to_integer(unsigned(drehzahl));
							if(int_val < 10) then
								ascii_out <= x"20";
							else
								ascii_out <= std_logic_vector("00110000" + unsigned(value_position_10)); -- ASCII-Null + Ziffer
							end if;
						when x"05" =>
							ascii_out <= std_logic_vector("00110000" + unsigned(value_position_1)); -- ASCII-Null + Ziffer
						when others =>
							null;
					end case;
				end if;
				
				if(error_richtung = '1') then
					-- Bei Fehler -> Ersetze Richtungsausgabe durch Sternchen
					if(charposition >= x"28" AND charposition <= x"2D") then
						ascii_out <= x"2A"; -- *
					end if;
				else
					-- Ausgabe der Richtung
					if(richtung = '0') then
						case charposition is
							when x"29" => ascii_out <= x"6C"; -- l
							when x"2A" => ascii_out <= x"69"; -- i
							when x"2B" => ascii_out <= x"6E"; -- n
							when x"2C" => ascii_out <= x"6B"; -- k
							when x"2D" => ascii_out <= x"73"; -- s
							when others => null;
						end case;
					else
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
