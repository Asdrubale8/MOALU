library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
          
entity moalu_inverse_serial_interface_testbench is
end moalu_inverse_serial_interface_testbench;
   
architecture moalu_inverse_serial_interface_testbench_behavior of moalu_inverse_serial_interface_testbench is
   
	component moalu_inverse_serial_interface is 
		generic( 
			Nb	:integer
		);
		port( 
			clk		:in std_logic; 
			enable		:in std_logic;
			parallel_in	:in std_logic_vector(Nb-1 downto 0);
			serial_out	:out std_logic
		);
	end component;

	component moalu_clock_generator is 
		port(  
        		clk	:out std_logic
    		);
	end component;
  
   	constant numb: integer := 3;  
   	signal clk: std_logic; 
	signal parallel_in: std_logic_vector(numb-1 downto 0):="101";
   	signal serial_out: std_logic:='0';
	signal signal_one: std_logic:='1';
         
begin

      	moalu_clock_generator_c : moalu_clock_generator	port map (clk); 

	moalu_inverse_serial_interface_c : moalu_inverse_serial_interface
	generic map (Nb => numb)
	port map (clk, signal_one, parallel_in, serial_out);

end moalu_inverse_serial_interface_testbench_behavior;
