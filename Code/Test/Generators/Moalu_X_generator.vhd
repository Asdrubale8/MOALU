library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity moalu_X_generator is 
	generic(
		Nb	: integer
	); 
	port( 
		selection	:in integer;
		X		:out std_logic
	);
end moalu_X_generator;

architecture moalu_X_generator_behavior of moalu_X_generator is

	component moalu_X_generator_1 is 
		generic(  
        		Nb	: integer
    		);
		port(  
        		X	:out std_logic
    		);
	end component;

	component moalu_X_generator_2 is 
		generic(  
        		Nb	: integer
    		);
		port(  
        		X	:out std_logic
    		);
	end component;

	component moalu_X_generator_3 is 
		generic(  
        		Nb	: integer
    		);
		port(  
        		X	:out std_logic
    		);
	end component;

	signal X1,X2,X3 :std_logic;

begin
	
	moalu_X_generator_c1 : moalu_X_generator_1 generic map (Nb => Nb) port map (X1); 
	moalu_X_generator_c2 : moalu_X_generator_2 generic map (Nb => Nb) port map (X2); 
	moalu_X_generator_c3 : moalu_X_generator_3 generic map (Nb => Nb) port map (X3);   

	process(selection, X1, X2, X3)
	begin
		case selection is
			when 1 => X<=X1;
			when 2 => X<=X2;
			when 3 => X<=X3;
			when others => X<='0';
		end case;
    	end process;
end moalu_X_generator_behavior;
