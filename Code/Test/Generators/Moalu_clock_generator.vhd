library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity moalu_clock_generator is 
	port( 
		clk	:out std_logic
	);
end moalu_clock_generator;

architecture moalu_clock_generator_behavior of moalu_clock_generator is
begin
	process
	begin
            	clk <= '1'; wait for 1 ns;
            	clk <= '0'; wait for 1 ns;
    	end process;
end moalu_clock_generator_behavior;