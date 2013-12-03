library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--use ieee.std_logic_arith.all;

entity anzeige_drehzahl_splitter is
	port
	(
		clock			: in std_logic := '0';
		reset			: in std_logic := '1';

		drehzahl		: in std_logic_vector (15 downto 0) := "0000000000000000"; -- Range 0 - 65535 
		
		seg1			: out std_logic_vector(3 downto 0) := "0000";
		seg2			: out std_logic_vector(3 downto 0) := "0000";
		seg3			: out std_logic_vector(3 downto 0) := "0000";
		seg4			: out std_logic_vector(3 downto 0) := "0000";
		seg5			: out std_logic_vector(3 downto 0) := "0000";
		seg6			: out std_logic_vector(3 downto 0) := "0000"
		
	);
end entity;

architecture rtl of anzeige_drehzahl_splitter is
	constant ani_delta: integer := 1; -- aendern zu -1, wenn Richtung falsch
	begin
		process(clock, reset)
			variable drehzahl_i: integer := 0;
			variable digit: integer := 0;
		begin
			if(reset = '0') then
				drehzahl_i := 0;
			elsif(rising_edge(clock)) then
				drehzahl_i := to_integer(unsigned(drehzahl));
				
				digit := drehzahl_i mod 10;
				seg1 <= std_logic_vector(to_unsigned(digit, 16));
				drehzahl_i := drehzahl_i / 10;

				digit := drehzahl_i mod 10;
				seg2 <= std_logic_vector(to_unsigned(digit, 16));
				drehzahl_i := drehzahl_i / 10;
				
				digit := drehzahl_i mod 10;
				seg3 <= std_logic_vector(to_unsigned(digit, 16));
				drehzahl_i := drehzahl_i / 10;
				
				digit := drehzahl_i mod 10;
				seg4 <= std_logic_vector(to_unsigned(digit, 16));
				drehzahl_i := drehzahl_i / 10;
				
				digit := drehzahl_i mod 10;
				seg5 <= std_logic_vector(to_unsigned(digit, 16));
				drehzahl_i := drehzahl_i / 10;
				
				digit := drehzahl_i mod 10;
				seg6 <= std_logic_vector(to_unsigned(digit, 16));
			end if;
		end process;

  end rtl;