library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Konzept_AllInOne is
	port
	(
		-- "i_" input										  -- Portmapping
		i_dreh_signal_a		: in std_logic := '0'; -- AD15
		i_dreh_signal_b		: in std_logic := '0'; -- AE15
		
		i_sig1					: in std_logic := '0'; -- AB22
		i_sig2					: in std_logic := '0'; -- AC15
		
		i_reset					: in std_logic := '0'; -- M23
		i_clock					: in std_logic := '0'; -- Y2
		i_output_zero			: in std_logic := '0'; -- M21
		i_richtung				: in std_logic := '0'; -- Y23
		
		-- "od_" output debug
		od_add					: in std_logic := '0'; -- E25
		od_error_drehzal		: in std_logic := '0'; -- G22
		od_error_richtung		: in std_logic := '0'; -- G21
		od_debug_1				: in std_logic := '0'; -- E21
		od_debug_2				: in std_logic := '0'; -- E22
		od_dreh_error			: in std_logic := '0'; -- H21
		
		-- "o_" output
		o_lcdData				: out std_logic_vector (7 downto 0) := "00000000"; -- L3 L1 L2 K7 K1 K2 M3 M5
		o_lcdRS					: out std_logic := '0'; -- M2
		o_lcdRW					: out std_logic := '0'; -- M1
		o_lcdE1					: out std_logic := '0'; -- L4
		o_lcdE2					: out std_logic := '0'; -- L5
		
		o_seg1					: out std_logic := '0';
		
	
		clock			: in std_logic := '0';
		reset			: in std_logic := '1';
		drehzahl		: in std_logic_vector (15 downto 0) := "0000000000000000"; -- Range 0 - 65535 
		richtung		: in std_logic := '0';
		pwm			: out std_logic := '0'
	);
end entity;

architecture rtl of Konzept_AllInOne is
	signal drehzahl_last: std_logic_vector (15 downto 0) := "0000000000000000";
	signal richtung_last: std_logic := '0';
	begin
		process(clock, reset)
		begin
		end process;
	end rtl;