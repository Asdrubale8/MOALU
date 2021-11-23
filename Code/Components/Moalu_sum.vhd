library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
          
entity moalu_sum is 
	generic( 
		Nb	:integer
	);
	port( 
		enable	:in std_logic;
		A	:in std_logic_vector(Nb-1 downto 0); 
		B	:in std_logic_vector(Nb-1 downto 0); 
		sum	:out std_logic_vector(Nb-1 downto 0)
	);
end moalu_sum;
   
architecture moalu_sum_behavior of moalu_sum is

begin

      	sum <= A+B when enable='1';

end moalu_sum_behavior;
