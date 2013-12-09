library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.conv_std_logic_vector;

entity display is
	port
	(
		clk			: in		std_logic := '0';
		dIn			: in		std_logic_vector(7 downto 0) := (others => '0');
		wEn			: in		std_logic := '0';
		lcdData		: out		std_logic_vector(7 downto 0) := (others => '0');
		lcdRS			: out		std_logic := '0';
		lcdRW			: out		std_logic := '0';
		lcdE1			: out		std_logic := '0'; --buffer
		lcdE2			: out		std_logic := '0'; --buffer
		charposition: out		std_logic_vector(7 downto 0) := (others => '0') --integer range 0 to 159 --buffer
	);
end entity;

architecture Structural of display is
	constant tickNum	: integer 	:= 252;	-- muss mindestens Ozilatorfrequenz*10 groesser sein (252)
	constant LCD_READ	: std_logic := '1';
	constant LCD_WRITE: std_logic := '0';
	constant DATA_CODE: std_logic := '1';
	constant INSN_CODE: std_logic := '0';
	
	constant WARMUP_DELAY: integer := 2000;	-- 2000	:20ms
	constant INIT_DELAY	: integer := 500;		-- 500	:5ms
	constant CHAR_DELAY	: integer := 10;		-- 100	:100us

	subtype DELAY_TYPE is integer range 0 to WARMUP_DELAY;
	signal timer: DELAY_TYPE;

	--Statusdef.
	type STATE_TYPE is (WARMUP, STAGE1, STAGE2, STAGE3, DELAY);
	signal state				: STATE_TYPE;
	
	-- Tick Generation
	subtype TICK_COUNTER_TYPE is integer range 0 to tickNum;
	signal tick					: std_logic;
	
	type INIT_ROM_TYPE is array (0 to 6) of std_logic_vector(7 downto 0);
	constant initROM			: INIT_ROM_TYPE := (	b"0011_0000",	-- Init
																b"0011_0000",	-- Init
																b"0011_0000",	-- Init
																b"0011_1000",	-- Function Set: 8 bit, 2 lines, 5x7 characters
																b"0000_1100",	-- display On/Off Control: display on, Cursor off, Blink off
																b"0000_0001",	-- Clear display: Move cursor to home
																b"0000_0110");	-- Entry Mode Set: Auto increment cursor, don't shift display
	
	type CHAR_RAM_TYPE is array(0 to 159) of std_logic_vector(7 downto 0);
	signal charRAM			: CHAR_RAM_TYPE := (others => x"A0");
																
	
	signal initialising	: std_logic;
	signal initROMPointer: integer range 0 to INIT_ROM_TYPE'high;
	signal charRAMPointer: integer range 0 to CHAR_RAM_TYPE'high;
	signal setLine			: std_logic;
	signal lineNum			: integer range 0 to 1;
	signal speicher		: std_logic;

	begin
	lcdRW <= '0';
	
	TickGen : process(clk)
		variable tickCounter : TICK_COUNTER_TYPE;
		begin
			if (clk'event and clk = '1') then
				if (tickCounter = 0) then
					tickCounter := TICK_COUNTER_TYPE'high - 1;
					tick <= '1';
				else
					tickCounter := tickCounter - 1;
					tick <= '0';
				end if;
			end if;
		end process;
	
	Controller : process (clk)
		function BitInt(b:std_logic_vector) return Integer is
			variable value1: integer;
			
			begin
				value1 := to_integer(unsigned(b));
				return value1;
			end BitInt;
--------------------------------------------------------------------------------------------------------------
		begin
			if (clk'event and clk = '1') then
				if (tick = '1') then
					case state is 
					when WARMUP =>
						if (timer = 0) then
							charRAMPointer <= 0;
							lcde1 <= '0';
							lcde2 <= '0';
							initialising <= '1';
							timer <= WARMUP_DELAY;
							state <= STAGE1;
						else
							timer <= timer - 1;
						end if;
					when STAGE1 =>
						if (initialising = '1') then
							timer <= INIT_DELAY;
							lcdRS <= INSN_CODE;
							lcdData <= initROM(initROMPointer);
							lcde1 <= '1';  
							lcde2 <= '1';
						elsif (setLine = '1') then
							timer <= CHAR_DELAY;
							lcdRS <= INSN_CODE;
							
							case lineNum is
								when 0 => lcdData	<= b"1000_0000";	-- x00
								when 1 => lcdData	<= b"1100_0000";	-- x40
							end case;
						else
							timer <= CHAR_DELAY;
							lcdRS <= DATA_CODE;
							
							if(wen = '1')then
								lcdData <= din;
							else
								lcdData <= charRAM(charRAMPointer);
							end if;
						end if;
						
						state	<= STAGE2;
					when STAGE2 =>
						if (initialising = '1') then
							if (initROMPointer = INIT_ROM_TYPE'high) then
								initialising <= '0';
							else
								initROMPointer	<= initROMPointer + 1;
							end if;
						elsif (setLine = '1') then
							setLine <= '0';
							
							if (charRAMPointer = 14) then			-- 39 fuer 4 x 40
								setLine <= '1';
								lineNum <= 1;
							elsif (charRAMPointer = 31) then		-- 79 fuer 4 x 40
								setLine <= '1';
								lineNum <= 0; -- original 0 
								lcde1	<='0';
								lcde2	<= '1';
							--elsif (charRAMPointer = 119) then
								--setLine <= '1';
								--lineNum <= 1;
							--elsif (charRAMPointer = 159) then
								--setLine <= '1';
								--lineNum <= 0;
								--lcde1 <= '1';
								--lcde2 <= '0';
							end if;
						elsif (charRAMPointer = CHAR_RAM_TYPE'high) then -- change CHAR_RAM_TYPE back to charRAMPointer
							charRAMPointer <= 0;
						else
							charRAMPointer <= charRAMPointer + 1;
						end if;
						
						if(charRAMPointer >= 80)then	-- Umschaltung auf Zeile 2 und 3 beim Display 4 x 40 
							lcdE1	<= '0';
							lcde2	<= '1';
						else
							lcde1	<= '1';
							lcde2	<= '0';
						end if;
						state	<= STAGE3;
					when STAGE3 =>
						lcde1<='0';
						lcde2<='0';							
						state	<= DELAY;
					when DELAY =>
						if (timer = 0) then
							state <= Stage1;   
						else
							timer <= timer - 1;
						end if;					
					end case;
				end if;
				
				charposition <= conv_std_logic_vector(charRAMPointer,8);
			end if;
		end process;
	end architecture;