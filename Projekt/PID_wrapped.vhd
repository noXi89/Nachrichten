-- used and modifyed code from http://www.mikrocontroller.net/topic/186326
-- thanks

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity PID_Regler_wrapped is
generic(
	constant data_width: integer := 16;
	constant intern_data_width: integer  := 18
	
	constant c_kp : integer := 1;
	constant c_ki : integer := 1;
	constant c_kd : integer := 1;
);
port(
	i_clk        : in  std_logic;
	i_rst        : in  std_logic;
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
begin
	Regler: process(i_clk)
		begin
		--Mappen der Eingeänge
		w  <= i_data_soll;
		x  <= i_data_ist;
		  
		--Regeldifferenz
		e  <= std_logic_vector(signed(w) - signed(x));  


		if rising_edge(i_clk) then
		  if i_rst = '1' then
			 yp <= (others => '0');
			 yi <= (others => '0');
			 yd <= (others => '0');
			 ealt <= (others => '0');
			 y <= (others => '0');
		  else
			 --e  <= (w-x);
			 e  <= std_logic_vector(signed(w) - signed(x)); 
			 yp <= std_logic_vector(c_kp*signed(e));
			 yi <= std_logic_vector(signed(yi_alt)+c_ki*signed(e)/10)); --yi_alt=yi
			 yd <= std_logic_vector(c_kd*((signed(e)-signed(ealt))*10)); -- ealt=e

			 y <= std_logic_vector(signed(yp)+signed(yi)+signed(yd));
			 --y <= resize((yp + yi + yd));
			 ealt <= e;
			 yi_alt <= yi;
		  end if;
		end if;
	end process Regler;
	o_data_y  <= y;
end architecture Behavioral;