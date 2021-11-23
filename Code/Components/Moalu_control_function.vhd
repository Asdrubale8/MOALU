library ieee;
use ieee.std_logic_1164.all;
use work.types.all;

entity moalu_control_function is
	port(
		state  							:in  statetype; 
         	RX_ctrl, C_ctrl, SUB_ctrl, C2_ctrl, SUM_ctrl, TX_ctrl	:out std_logic:='0'
	);
end moalu_control_function;
    
architecture moalu_control_function_behavior of moalu_control_function is
	
begin
   
	process(state)
		variable control :std_logic_vector(0 to 5):="000000";

	begin
		case state is
			when SB | S1 | S0 | S11 | S10 | S01 | S00 =>
				control:="000000";
			when RX =>
				control:="100000";
			when C =>
				control:="010000";
			when SUB =>
				control:="001000";
			when C2 =>
				control:="000100";
			when SUM =>
				control:="000010";
			when TX =>
				control:="000001";
		end case;
		
		RX_ctrl<=control(0);
		C_ctrl<=control(1);
		SUB_ctrl<=control(2);
		C2_ctrl<=control(3); 
		SUM_ctrl<=control(4);
		TX_ctrl<=control(5);
	end process;

end moalu_control_function_behavior;
