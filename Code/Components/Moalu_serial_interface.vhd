library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
          
entity moalu_serial_interface is 
	generic( 
		Nb	:integer
	);
	port( 
		clk		:in std_logic; 
		enable		:in std_logic;
		reset		:in std_logic;
		serial_in	:in std_logic;
		parallel_out	:out std_logic_vector(Nb-1 downto 0)
	);
end moalu_serial_interface;
   
architecture moalu_serial_interface_behavior of moalu_serial_interface is

	component moalu_pulse_generator is 
		generic( 
			pulse_period	:integer
		);
		port( 
			clk		:in std_logic; 
			enable		:in std_logic;
			pulse_out	:out std_logic
		);
	end component;

	component moalu_sipo_register is
		generic( 
			Nb : integer
		);
    		port( 
			clk      :in std_logic;
			enable   :in std_logic;  
			reset	 :in std_logic; 
			data_in  :in std_logic;
			data_out :out std_logic_vector(Nb-1 downto 0)
    		);
	end component;
    
	component moalu_pipo_register is 
		generic( 
			Nb	:integer
		);
		port( 
			clk		:in std_logic; 
			enable		:in std_logic;
			reset	 	:in std_logic; 
			data_in		:in std_logic_vector(Nb-1 downto 0);
			data_out	:out std_logic_vector(Nb-1 downto 0)
		);
	end component;

	signal pipo_enable	: std_logic:='0';	
	signal data_out_sipo	: std_logic_vector(Nb-1 downto 0);

begin
	
	moalu_pulse_generator_c: moalu_pulse_generator
	generic map (pulse_period => Nb)
	port map (clk, enable, pipo_enable);

	moalu_sipo_register_c: moalu_sipo_register
	generic map (Nb => Nb)
	port map (clk, enable, reset, serial_in, data_out_sipo);

	moalu_pipo_register_c: moalu_pipo_register
	generic map (Nb => Nb)
	port map (clk, pipo_enable, reset, data_out_sipo, parallel_out);

end moalu_serial_interface_behavior;