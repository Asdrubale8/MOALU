library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
          
entity moalu_sub is 
	generic( 
		Nb	:integer
	);
	port( 
		enable	:in std_logic;
		A	:in std_logic_vector(Nb-1 downto 0);
		B	:in std_logic_vector(Nb-1 downto 0);
		sub	:out std_logic_vector(Nb-1 downto 0)
	);
end moalu_sub;
  
architecture moalu_sub_behavior of moalu_sub is

	component moalu_c2 is 
    		generic( 
			Nb : integer
		);
		port( 
        		enable	:in std_logic; 
			A	:in std_logic_vector(Nb-1 downto 0);
        		C2	:out std_logic_vector(Nb-1 downto 0)
    		);
	end component;

	component moalu_sum is 
    		generic( 
			Nb : integer
		);
		port( 
        		enable	:in std_logic; 
			A	:in std_logic_vector(Nb-1 downto 0);
        		B	:in std_logic_vector(Nb-1 downto 0); 
        		sum	:out std_logic_vector(Nb-1 downto 0)
    		);
	end component;

	signal B_C2 : std_logic_vector(Nb-1 downto 0);	
	signal signal_one : std_logic:='1';

begin

moalu_c2_c: moalu_c2 generic map(Nb => Nb) port map (enable, B, B_C2); 
moalu_sum_c: moalu_sum generic map(Nb => Nb) port map (enable, A, B_C2, sub); 
      	
end moalu_sub_behavior;
