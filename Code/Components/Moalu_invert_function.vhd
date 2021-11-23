library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
          
entity moalu_invert_function is 
	generic( 
		Nb	:integer
	);
	port( 
		enable			:in std_logic;
		A, B			:in std_logic_vector(0 to Nb-1);
		C			:in std_logic;
		SUB1_in, SUB2_in	:out std_logic_vector(0 to Nb-1)
	);
end moalu_invert_function;
   
architecture moalu_invert_function_behavior of moalu_invert_function is

begin
	
   	SUB1_in <= A when C = '1' else B;
   	SUB2_in <= B when C = '1' else A;

end moalu_invert_function_behavior;
