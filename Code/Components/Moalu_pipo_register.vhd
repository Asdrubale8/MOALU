library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
          
entity moalu_pipo_register is 
	generic( 
		Nb	:integer
	);
	port( 
		clk		:in std_logic; 
		enable		:in std_logic;
		reset		:in std_logic;
		data_in		:in std_logic_vector(Nb-1 downto 0);
		data_out	:out std_logic_vector(Nb-1 downto 0)
	);
end moalu_pipo_register;
   
architecture moalu_pipo_register_behavior of moalu_pipo_register is

	component moalu_flip_flop_D is
    		port(
         		clk	:in std_logic;
         		enable	:in std_logic;
			reset	:in std_logic;
			D  	:in std_logic; 
         		Q  	:out std_logic
		);
	end component;

   	signal support_signal1, support_signal2 : std_logic_vector(Nb-1 downto 0);
   	signal signal_one : std_logic:='1';
	
begin
    
    	data_out <= support_signal1;
    	support_signal2 <= data_in;
    
    	g1 : for k in Nb-1 downto 0 generate
      		ni : moalu_flip_flop_D port map(clk, enable, reset, support_signal2(k), support_signal1(k));
    	end generate;
	   
end moalu_pipo_register_behavior;