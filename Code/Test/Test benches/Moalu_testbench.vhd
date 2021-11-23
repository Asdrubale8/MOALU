library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use work.types.all;
          
entity moalu_testbench is
end moalu_testbench;
   
architecture moalu_testbench_behavior of moalu_testbench is
  
	component moalu is 
    		generic( 
			Nb : integer
		);
		port( 
        		clk	:in std_logic; 
			X	:in std_logic;
			C	:in std_logic;
        		R	:in std_logic; 
        		TX_out	:out std_logic
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
         
   	constant numb: integer := 3;  
   	signal clk: std_logic; 
   	signal X: std_logic;
   	signal C: std_logic := '1';
   	signal R: std_logic := '1';
   	signal TX_out: std_logic := '0';
	constant selection: integer := 2;

begin
	moalu_clock_generator_c : moalu_clock_generator	
	port map (clk); 

      	moalu_X_generator_c : moalu_X_generator	
	generic map (Nb => numb) 
	port map (selection, X);    

      	moalu_c : moalu 
	generic map (Nb => numb)
	port map (clk, X, C, R, TX_out);

end moalu_testbench_behavior;