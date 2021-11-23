library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity moalu_X_generator_3 is 
	generic(
		Nb	: integer
	); 
	port( 
		X	:out std_logic
	);
end moalu_X_generator_3;

architecture moalu_X_generator_3_behavior of moalu_X_generator_3 is
begin
	process
		variable b :std_logic;

	begin
		-- STANDBY transition
            	X <= '0'; wait for 2 ns;
            	X <= '0'; wait for 2 ns;
            	X <= '0'; wait for 2 ns;

		-- RX transition
            	X <= '1'; wait for 2 ns;
            	X <= '1'; wait for 2 ns;
            	X <= '1'; wait for 2 ns;

		-- XA vector
		b:='1';
            	for k in Nb-1 downto 0 loop
			X<=b; wait for 2 ns;
			b:=not b;
		end loop;

		-- XB vector
		b:='0';
            	for k in Nb-1 downto 0 loop
			X<=b; wait for 2 ns;
			b:=not b;
		end loop;

		-- C transition
   		X <= '1'; wait for 2 ns;
            	X <= '0'; wait for 2 ns;
            	X <= '1'; wait for 2 ns;

		-- TX transition
            	X <= '0'; wait for 2 ns;
            	X <= '0'; wait for 2 ns;
            	X <= '1'; wait for 2 ns;

		-- XA vector
		b:='0';
            	for k in Nb-1 downto 0 loop
			X<='1'; wait for 2 ns;
			b:=not b;
		end loop;

		-- XB vector
		b:='1';
            	for k in Nb-1 downto 0 loop
			X<=b; wait for 2 ns;
			b:=not b;
		end loop;
    	end process;
end moalu_X_generator_3_behavior;
