-- used and modifyed code from http://www.mikrocontroller.net/topic/186326
-- thanks

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use ieee.std_logic_arith.conv_std_logic_vector;


entity PID_Regler is
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
end entity PID_Regler;

architecture Behavioral of PID_Regler is
	signal w      :  std_logic_vector(data_width-1 downto 0);
	signal x      :  std_logic_vector(data_width-1 downto 0);
	signal e      :  std_logic_vector(data_width-1 downto 0);

	signal y      : std_logic_vector(data_width-1 downto 0);
	signal yp     : std_logic_vector(intern_data_width-1 downto 0) := (others => '0');
	signal yi     : std_logic_vector(intern_data_width-1 downto 0) := (others => '0');
	signal yd     : std_logic_vector(intern_data_width-1 downto 0) := (others => '0');
	signal ealt   : std_logic_vector(intern_data_width-1 downto 0) := (others => '0');
	signal yi_alt : std_logic_vector(intern_data_width-1 downto 0) := (others => '0');
	
	constant magic_constant_1 : integer := 10;
	
	
begin
	Regler: process(i_clk, i_data_soll, i_data_ist, i_kp, i_ki, i_kd)
	variable v_i_kp         : integer := 0;
	variable v_i_ki         : integer := 0;
	variable v_i_kd         : integer := 0;
	variable v_e				: integer := 0;
	variable v_w				: integer := 0;
	variable v_x				: integer := 0;
	variable v_yi_alt			: integer := 0;
	variable v_yi				: integer := 0;
	variable v_ealt			: integer := 0;
	variable v_yp				: integer := 0;
	variable v_yd				: integer := 0;
		begin
		--Mappen der Eingeänge
		w  <= i_data_soll;
		x  <= i_data_ist;
		  
		--Regeldifferenz
		-- e  <= std_logic_vector(signed(w) - signed(x));  

		if rising_edge(i_clk) then
		  if i_rst = '1' then
			 yp <= (others => '0');
			 yi <= (others => '0');
			 yd <= (others => '0');
			 ealt <= (others => '0');
			 y <= (others => '0');
		  else
			v_i_kp         := to_integer(signed(i_kp));
			v_i_ki         := to_integer(signed(i_ki));
			v_i_kd         := to_integer(signed(i_kd));
			v_e				:= to_integer(signed(e));
			v_w				:= to_integer(signed(w));
			v_x				:= to_integer(signed(x));
			v_yi_alt			:= to_integer(signed(yi_alt));
			v_yi				:= to_integer(signed(yi));
			v_ealt			:= to_integer(signed(ealt));
			v_yp				:= to_integer(signed(yp));
			v_yd				:= to_integer(signed(yd));
			
			 
			 --e  <= (w-x);
			 e  <= conv_std_logic_vector((v_w - v_x), e'length); 
			 yp <= conv_std_logic_vector((v_i_kp * v_e), yp'length);
			 yi <= conv_std_logic_vector((v_yi_alt + (v_i_ki * v_e / magic_constant_1)), yi'length); --yi_alt=yi
			 yd <= conv_std_logic_vector((v_i_kd * ((v_e - v_ealt) * magic_constant_1)), yd'length); -- ealt=e

			 y <= conv_std_logic_vector(v_yp+v_yi+v_yd, y'length);
			 --y <= resize((yp + yi + yd));
			 ealt <= conv_std_logic_vector(v_e,ealt'length);
			 yi_alt <= yi;
		  end if;
		end if;
	end process Regler;
	o_data_y  <= y;
end architecture Behavioral;