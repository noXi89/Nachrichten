library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;

entity anzeige_drehzahl is
	port
	(
		clock			: in std_logic := '0';
		reset			: in std_logic := '1';
		
		error			: in std_logic := '1';
		drehzahl		: in std_logic_vector (15 downto 0) := "0000000000000000"; -- Range 0 - 65535 
		
		seg1			: out std_logic_vector(7 downto 0) := "00000000";
		seg2			: out std_logic_vector(7 downto 0) := "00000000";
		seg3			: out std_logic_vector(7 downto 0) := "00000000";
		seg4			: out std_logic_vector(7 downto 0) := "00000000";
		seg5			: out std_logic_vector(7 downto 0) := "00000000";
		seg6			: out std_logic_vector(7 downto 0) := "00000000"
		
	);
end entity;

architecture rtl of anzeige_drehzahl is
	type map_type is array (0 to 7) of std_logic_vector(7 downto 0);									
	constant map_seg1: map_type := (
												0 => (0 => '1', others => '0'),
												1 => (others => '0'),
												2 => (others => '0'),
												3 => (others => '0'),
												4 => (others => '0'),
												5 => (3 => '1', others => '0'),
												6 => (4 => '1', others => '0'),
												7 => (5 => '1', others => '0')
											);

	constant map_seg2: map_type := (
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
	begin
		process(clock, reset, error)
			variable ani_counter: integer := 0;
		begin
	
		end process;

  end rtl;