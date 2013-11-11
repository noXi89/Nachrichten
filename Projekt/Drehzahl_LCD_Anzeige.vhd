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
		begin
			-- int_val := conv_integer(drehzahl);
			
			write_enable <= '0';
			if(reset = '0') then
				
			elsif()
				
			end if;
		end process;
	end rtl;