library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
          
entity moalu_pulse_generator is 
	generic( 
		pulse_period	:integer
	);
	port( 
		clk		:in std_logic; 
		enable		:in std_logic;
		pulse_out	:out std_logic:='0'
	);
end moalu_pulse_generator;
   
architecture moalu_pulse_generator_behavior of moalu_pulse_generator is

begin
	
	process(clk)	
		variable count		: integer range 0 to pulse_period-1:=0;
		variable pulse_var 	: std_logic:='0';

	begin
		if rising_edge(clk) and enable='1' then
			if count=pulse_period-1 then
				count:=0;
				pulse_var := '1';
			else 
				pulse_var := '0';
				count:=count+1;
			end if;
		elsif enable = '0' then
			count:=0;
			pulse_var := '0';
		end if;

		pulse_out<=pulse_var;
		
	end process;

end moalu_pulse_generator_behavior;
