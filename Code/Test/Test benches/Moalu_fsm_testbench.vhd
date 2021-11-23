library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use work.types.all;
          
entity moalu_fsm_testbench is
end moalu_fsm_testbench;
   
architecture moalu_fsm_testbench_behavior of moalu_fsm_testbench is
   
	component moalu_fsm is 
		generic(
			Nb	: integer
		);
		port( 
			clk	:in std_logic; 
			X	:in std_logic;
        		R	:in std_logic; 
        		RX_ctrl, C_ctrl, SUB_ctrl, C2_ctrl, SUM_ctrl, TX_ctrl	:out std_logic
		);
	end component;

	component moalu_clock_generator is 
		port(  
        		clk	:out std_logic
    		);
	end component;

	component moalu_X_generator is 
		generic(  
        		Nb	: integer
    		);
		port(  
			selection	:in integer;
        		X		:out std_logic
    		);
	end component;
  
   	constant numb: integer := 2;  
   	signal clk: std_logic; 
   	signal X: std_logic;
   	signal R: std_logic := '1';
	constant selection: integer := 1;
        signal RX_ctrl, C_ctrl, SUB_ctrl, C2_ctrl, SUM_ctrl, TX_ctrl :std_logic:='0';
begin

      	moalu_clock_generator_c : moalu_clock_generator	port map (clk); 
      	moalu_X_generator_c : moalu_X_generator	generic map (Nb => numb) port map (selection, X);    

      	moalu_fsm_c : moalu_fsm
	generic map (Nb => numb)
	port map (clk, X, R, RX_ctrl, C_ctrl, SUB_ctrl, C2_ctrl, SUM_ctrl, TX_ctrl);

end moalu_fsm_testbench_behavior;