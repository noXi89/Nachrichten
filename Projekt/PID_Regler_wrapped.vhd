-- used and modifyed code from http://www.mikrocontroller.net/topic/186326
-- thanks

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use ieee.std_logic_arith.conv_std_logic_vector;


entity PID_Regler_wrapped is
generic(
	constant data_width: integer := 16;
	constant intern_data_width: integer  := 18
);
port(
	i_clk        : in  std_logic := '0';
	i_rst        : in  std_logic := '0';
	i_data_soll  : in  std_logic_vector(data_width-1 downto 0) := (others => '0');
	i_data_ist   : in  std_logic_vector(data_width-1 downto 0) := (others => '0');
	o_data_y     : out std_logic_vector(data_width-1 downto 0) := (others => '0')
  );
end entity PID_Regler_wrapped;

architecture Behavioral of PID_Regler_wrapped is
  constant c_kp : std_logic_vector(intern_data_width-1 downto 0) := std_logic_vector(to_unsigned(10, 18));
  constant c_ki : std_logic_vector(intern_data_width-1 downto 0) := std_logic_vector(to_unsigned(1, 18));
  constant c_kd : std_logic_vector(intern_data_width-1 downto 0) := std_logic_vector(to_unsigned(1, 18));
  component PID_Regler is
    generic(
      constant data_width: integer := 16;
      constant intern_data_width: integer  := 18
    );
    port(
      i_clk        : in  std_logic;
      i_rst        : in  std_logic;
      i_kp         : in  std_logic_vector(intern_data_width-1 downto 0);
      i_ki         : in  std_logic_vector(intern_data_width-1 downto 0);
      i_kd         : in  std_logic_vector(intern_data_width-1 downto 0);
      i_data_soll  : in  std_logic_vector(data_width-1 downto 0);
      i_data_ist   : in  std_logic_vector(data_width-1 downto 0);
      o_data_y     : out std_logic_vector(data_width-1 downto 0)
    );
  end component;

	signal w      :  std_logic_vector(data_width-1 downto 0);
	signal x      :  std_logic_vector(data_width-1 downto 0);
	signal e      :  std_logic_vector(data_width-1 downto 0);

begin
-- just map ... nothing more ... no process ... 
-- simple as that ... you are just a wrapper
PID_Regler_instance: PID_Regler port map(
	   i_clk,
      i_rst,
      c_kp, -- constant from line 25 -- this comment will maybe become obsolete.
      c_ki, -- constant from line 26 -- this comment will maybe become obsolete.
      c_kd, -- constant from line 27 -- this comment will maybe become obsolete.
      i_data_soll,
      i_data_ist,
      o_data_y
	);
end architecture Behavioral;