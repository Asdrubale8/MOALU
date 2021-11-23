library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
          
entity moalu_inverse_serial_interface is 
	generic( 
		Nb	:integer
	);
	port( 
		clk		:in std_logic; 
		enable		:in std_logic;
		parallel_in	:in std_logic_vector(0 to Nb-1);
		serial_out	:out std_logic:='0'
	);
end moalu_inverse_serial_interface;
   
architecture moalu_inverse_serial_interface_behavior of moalu_inverse_serial_interface is

begin
	
	process(clk, enable)
		variable count: integer range 0 to Nb:=0;		
		variable serial_out_var: std_logic;
	begin

		if clk='1' then
			if enable='1' and count/=Nb then
				serial_out_var:=parallel_in(count);
				count:=count+1;
			else
				if enable='0' then
					count:=0;
				end if;
				serial_out_var:='0';
			end if;
			serial_out<=serial_out_var;
		end if;			
		
	end process;	

end moalu_inverse_serial_interface_behavior;
