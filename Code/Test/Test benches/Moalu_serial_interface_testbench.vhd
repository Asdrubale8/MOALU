library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
          
entity moalu_serial_interface_testbench is
end moalu_serial_interface_testbench;
   
architecture moalu_serial_interface_testbench_behavior of moalu_serial_interface_testbench is
   
	component moalu_serial_interface is 
		generic(
			Nb	: integer
		);
		port(  		
			clk		:in std_logic; 
			enable		:in std_logic;
			reset		:in std_logic;
			serial_in	:in std_logic;
			parallel_out	:out std_logic_vector(Nb-1 downto 0)
    		);
	end component;

	component moalu_clock_generator is 
		port(  
        		clk	:out std_logic
    		);
	end component;
  
   	constant numb: integer := 2;  
   	signal clk: std_logic; 
   	signal X: std_logic;
	signal p_out: std_logic_vector(numb-1 downto 0);
	signal signal_one: std_logic:='1';
         
begin

    	process
        	begin
            	X <= '0'; wait for 2 ns;
            	X <= '0'; wait for 2 ns;
            	X <= '1'; wait for 2 ns;
            	X <= '1'; wait for 2 ns;
    	end process;

    	process
        	begin
            	signal_one <= '1'; wait for 5 ns;
    	end process;

      	moalu_clock_generator_c : moalu_clock_generator	port map (clk); 

      	moalu_serial_interface_c : moalu_serial_interface 
	generic map (Nb => numb)
	port map (clk, signal_one, signal_one, X, p_out);

end moalu_serial_interface_testbench_behavior;
