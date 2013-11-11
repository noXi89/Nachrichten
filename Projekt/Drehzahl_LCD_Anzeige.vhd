library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;

entity Drehzahl_LCD_Anzeige is
	port
	(
		reset			: in std_logic := '1';
		charposition: in integer range 0 to 159;
		drehzahl		: in std_logic_vector(15 downto 0) := "0000000000000000";
		ascii_out	: out std_logic_vector(7 downto 0);
		write_enable: out std_logic
	);
end entity;

architecture rtl of Drehzahl_LCD_Anzeige is
	begin
		process(charposition, drehzahl)
			signal current_drehzahl: std_logic_vector(15 downto 0) := "0000000000000000";
			
			variable int_val: integer := 0;
			
			variable value_position_1: integer := 0;
			variable value_position_10: integer := 0;
			variable value_position_100: integer := 0;
			variable value_position_1000: integer := 0;
			variable value_position_10000: integer := 0;
			
			function value_at_
		begin
			write_enable <= '0';
			if(reset = '0') then
				
			else
				if(drehzahl /= current_drehzahl)
					current_drehzahl <= drehzahl;
					int_val := conv_integer(drehzahl);
					
					counter := 0;
					while int_val >= 10000 loop
						int_val := int_val - 10000;
						counter := counter + 1;
					end loop;
					value_position_10000 := counter;
					
					counter := 0;
					while int_val >= 1000 loop
						int_val := int_val - 1000;
						counter := counter + 1;
					end loop;
					value_position_1000 := counter;
					
					counter := 0;
					while int_val >= 100 loop
						int_val := int_val - 100;
						counter := counter + 1;
					end loop;
					value_position_100 := counter;
					
					counter := 0;
					while int_val >= 10 loop
						int_val := int_val - 10;
						counter := counter + 1;
					end loop;
					value_position_10 := counter;
					
					counter := 0;
					while int_val > 1 loop
						int_val := int_val - 1;
						counter := counter + 1;
					end loop;
					value_position_1 := counter;
				end if;
			end if;
		end process;
	end rtl;