
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
--use ieee.std_logic_arith.conv_std_logic_vector;


entity Regler_simple is
generic(
	constant data_width: integer := 16;
	constant intern_data_width: integer  := 18
);
port(
	i_clk        : in  std_logic := '0';
	i_rst        : in  std_logic := '0';
	i_data_soll  : in  std_logic_vector(data_width-1 downto 0) := (others => '0');
	i_data_ist   : in  std_logic_vector(data_width-1 downto 0) := (others => '0');
	o_data_y     : out std_logic_vector(data_width-1 downto 0) := (others => '0');
	add	       : out std_logic:= '1'
  );
end entity Regler_simple;

architecture Behavioral of Regler_simple is
  constant p : integer := 100;
  signal debug_diff: integer := 0;
begin
process(i_clk, i_rst, i_data_soll, i_data_ist)
			variable p_sum: integer := 0;
			variable i_diff: integer := 0;
			variable u_i_data_soll: integer := 0;
			variable u_i_data_ist: integer := 0;
		begin
			if(i_rst = '0') then
				p_sum := 0;
			elsif(rising_edge(i_clk)) then
				u_i_data_soll := to_integer(unsigned(i_data_soll));
				u_i_data_ist := to_integer(unsigned(i_data_ist));
				i_diff := u_i_data_soll - u_i_data_ist;
				debug_diff <= i_diff;
				
				--if(i_diff > 100) then
				--	p_sum := p_sum + (i_diff/p);
				--	o_data_y <= std_logic_vector(to_unsigned(p_sum,o_data_y'length));
				--end if;
				
				if(i_diff > 100) then
					add <= '1';
					p_sum := p_sum + (i_diff)/p;
				elsif(i_diff < -100) then
					add <= '0';
					p_sum := p_sum - (i_diff)/p;
				end if;
				o_data_y <= std_logic_vector(to_unsigned(p_sum,o_data_y'length));
				
			end if;
		end process;
end architecture Behavioral;