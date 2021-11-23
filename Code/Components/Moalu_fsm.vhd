library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
use work.types.all;
              
entity moalu_fsm is 
	generic(
		Nb	: integer
	);
	port( 
		clk	:in std_logic; 
		X	:in std_logic;
        	R	:in std_logic; 
        	RX_ctrl, C_ctrl, SUB_ctrl, C2_ctrl, SUM_ctrl, TX_ctrl	:out std_logic
	);
end moalu_fsm;
  
architecture moalu_fsm_behavior of moalu_fsm is
    
	component moalu_state_function is 
		generic(
			Nb	: integer
		);
		port( 
			clk	:in std_logic; 
			X	:in std_logic;
        		R	:in std_logic; 
        		state	:out statetype
		);
	end component;

	component moalu_control_function is
		port(
			state  							:in  statetype; 
         		RX_ctrl, C_ctrl, SUB_ctrl, C2_ctrl, SUM_ctrl, TX_ctrl	:out std_logic
		);
	end component;

	signal state : statetype:=SB;

begin

	moalu_state_function_c: moalu_state_function
	generic map (Nb => Nb)
	port map (clk, X, R, state); 

	moalu_control_function_c: moalu_control_function
	port map (state, RX_ctrl, C_ctrl, SUB_ctrl, C2_ctrl, SUM_ctrl, TX_ctrl); 
      	
end moalu_fsm_behavior;