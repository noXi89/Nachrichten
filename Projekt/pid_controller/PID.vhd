library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity PID_Wrapper is
port(
	i_clk :	in std_logic;
	i_rst :	in std_logic;	-- reset when high

	-- Wishbone Slave port
	i_wb_cyc  :	in std_logic; --const
	i_wb_stb  :	in std_logic; --const
	i_wb_we   :	in std_logic; --const
	i_wb_adr  :	in std_logic_vector(3 downto 0); --range 0 to 15; --const
	i_wb_data :	in std_logic_vector(4 downto 0); --range 0 to 31;
	o_wb_ack  :	out std_logic;
	o_wb_data :	out std_logic_vector(4 downto 0); --range 0 to 31;

	-- u(n) output
	o_un	  :	out std_logic_vector(4 downto 0); --range 0 to 31;
	o_valid :	out std_logic
);
end entity PID_Wrapper;

architecture Verhalten of PID_Wrapper is
-- Deklarierung der internen Signale
signal y: std_logic; -- y  wird nur intern zur Verdrahtung benötigt.

-- Deklarierung der vorhandenen Komponenten
component PID
port (
	i_clk :	in std_logic;
	i_rst :	in std_logic;	-- reset when high

	-- Wishbone Slave port
	i_wb_cyc  :	in std_logic; --const
	i_wb_stb  :	in std_logic; --const
	i_wb_we   :	in std_logic; --const
	i_wb_adr  :	in std_logic_vector(3 downto 0); --range 0 to 15; --const
	i_wb_data :	in std_logic_vector(4 downto 0); --range 0 to 31;
	o_wb_ack  :	out std_logic;
	o_wb_data :	out std_logic_vector(4 downto 0); --range 0 to 31;

	-- u(n) output
	o_un	  :	out std_logic_vector(4 downto 0); --range 0 to 31;
	o_valid :	out std_logic
  );
end component;

begin
	-- Deklarierung der internen Signale für die einzelnen Komponenten
	pidcontroller : PID port map(
			i_clk => i_clk,
			i_rst => i_rst,

			-- Wishbone Slave port
			i_wb_cyc => i_wb_cyc,
			i_wb_stb => i_wb_stb,
			i_wb_we => i_wb_we,
			i_wb_adr => i_wb_adr,
			i_wb_data => i_wb_data,
			o_wb_ack => o_wb_ack,
			o_wb_data => o_wb_data,

			-- u(n) output
			o_un => o_un,
			o_valid => o_valid);
end architecture;