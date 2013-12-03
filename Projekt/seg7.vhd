library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
-- use ieee.std_logic_arith.all;

entity seg7 is
	port
	(
		clk			: in std_logic;
		i				: in std_logic_vector (3 downto 0);
		seg			: out std_logic_vector (6 downto 0)
	);
end entity;

architecture rtl of seg7 is
		signal last: std_logic_vector (3 downto 0);
		type outdb_type is array (0 to 9) of std_logic_vector(6 downto 0);
	begin
		process(i, clk)
			variable outdb: outdb_type :=
												(
													1 => (1 => '1', 2 => '1', others => '0'),
													2 => (2 => '0', 5 => '0', others => '1'),
													3 => (5 => '0', 4 => '0', others => '1'),
													4 => (0 => '0', 4 => '0', 3 => '0', others => '1'),
													5 => (1 => '0', 4 => '0', others => '1'),
													6 => (1 => '0', others => '1'),
													7 => (0 => '1', 1=> '1', 2 => '1', others => '0'),
													8 => (others => '1'),
													9 => (4 => '0', others => '1'),
													0 => (6 => '0', others => '1'),
													others => (others => '0')
												);
			variable i_i: INTeger := -1;
		begin
			if(rising_edge(clk)) then
--				if (i_i = -1) then
--					last <= i;
--					i_i := 0;
--				end if;

					i_i := to_integer(ieee.numeric_std.unsigned(i));
					seg <= not outdb(i_i);
			end if;
		end process;
	end rtl;
