library ieee;
use ieee.std_logic_1164.all;

entity moalu_sipo_register is
	generic( 
		Nb : integer
	);
    	port( 
		clk      :in std_logic;
		enable   :in std_logic;
		reset   :in std_logic; 
		data_in  :in std_logic;
		data_out :out std_logic_vector(Nb-1 downto 0)
    	);
end moalu_sipo_register;
    
architecture moalu_sipo_register_behavior of moalu_sipo_register is
		
	component moalu_flip_flop_D is
    		port(
         		clk	:in std_logic;
         		enable	:in std_logic;
         		reset	:in std_logic;
			D  	:in std_logic; 
         		Q  	:out std_logic
		);
	end component;
	
	signal signal_one: std_logic:='1';
   	signal Din: std_logic;
   	signal support_signal: std_logic_vector(Nb-1 downto 0);
	  
begin
    
    	data_out <= support_signal;
    
    	n1 : moalu_flip_flop_D port map(clk, enable, reset, data_in, support_signal(0));
      
    	g1 : for k in Nb-1 downto 1 generate
      		ni : moalu_flip_flop_D port map(clk, enable, reset, support_signal(k-1), support_signal(k));
    	end generate;
   
end moalu_sipo_register_behavior;