library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Drehregler is
	port
	(
		clock		: in std_logic := '0';
		reset		: in std_logic := '1';
		signal_a	: in std_logic := '0';
		signal_b	: in std_logic := '0';
		
		error				: out std_logic := '1';
		soll_drehzahl	: out std_logic_vector(15 downto 0) := "0000000000000000"
	);
end entity;

architecture rtl of Drehregler is
	constant MIN_SOLL_DREHZAHL: integer := 0;
	constant MAX_SOLL_DREHZAHL: integer := 800;
	
	signal last_signal_a: std_logic := '0';
	signal last_signal_b: std_logic := '0';
	
	begin
		process(clock, reset, signal_a, signal_b)
			variable current_status: std_logic_vector(3 downto 0) := "0000";
			variable current_direction: integer := 0; -- 0 = keine Richtung, 1 = links, 2 = rechts
			variable last_drehzahl: integer := 0;
		begin
			if(reset = '0') then
				soll_drehzahl <= "0000000000000000";
				last_signal_a <= '0';
				last_signal_b <= '0';
				
				last_drehzahl := 0;
			elsif(rising_edge(clock)) then
				current_status := signal_a & signal_b & last_signal_a & last_signal_b;
				
				case current_status is
					when "0000" => current_direction := 0; error <= '0';
					when "0001" => current_direction := 1; error <= '0';
					when "0010" => current_direction := 2; error <= '0';
					when "0011" => current_direction := 0; error <= '1';
					when "0100" => current_direction := 2; error <= '0';
					when "0101" => current_direction := 0; error <= '0';
					when "0110" => current_direction := 0; error <= '1';
					when "0111" => current_direction := 1; error <= '0';
					when "1000" => current_direction := 1; error <= '0';
					when "1001" => current_direction := 0; error <= '1';
					when "1010" => current_direction := 0; error <= '0';
					when "1011" => current_direction := 2; error <= '0';
					when "1100" => current_direction := 0; error <= '1';
					when "1101" => current_direction := 2; error <= '0';
					when "1110" => current_direction := 1; error <= '0';
					when "1111" => current_direction := 0; error <= '0';
					when others => null;
				end case;
				
				if(current_direction = 1 AND last_drehzahl > MIN_SOLL_DREHZAHL) then -- links
					last_drehzahl := last_drehzahl - 1;
				elsif(current_direction = 2 AND last_drehzahl < MAX_SOLL_DREHZAHL) then -- rechts
					last_drehzahl := last_drehzahl + 1;
				elsif(last_drehzahl < MIN_SOLL_DREHZAHL) then
					last_drehzahl := MIN_SOLL_DREHZAHL;
				elsif(last_drehzahl > MAX_SOLL_DREHZAHL) then
					last_drehzahl := MAX_SOLL_DREHZAHL;
				end if;
				
				last_signal_a <= signal_a;
				last_signal_b <= signal_b;
				soll_drehzahl <= std_logic_vector(to_unsigned(last_drehzahl, 16));
			end if;
		end process;
	end architecture;
