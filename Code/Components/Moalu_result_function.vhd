library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
          
entity moalu_result_function is 
	generic( 
		Nb	:integer
	);
	port( 		
		C_out, SUB_out, C2_out, SUM_out			:in std_logic_vector(0 to Nb-1);		
		C_ctrl, SUB_ctrl, C2_ctrl, SUM_ctrl		:in std_logic;
		ALU_out						:out std_logic_vector(0 to Nb-1):=(others=>'0')
	);
end moalu_result_function;
   
architecture moalu_result_function_behavior of moalu_result_function is

begin

	ALU_out <= C_out when C_ctrl='1' 
		else SUB_out when SUB_ctrl='1' 
		else C2_out when C2_ctrl='1'
		else SUM_out when SUM_ctrl='1';

end moalu_result_function_behavior;
