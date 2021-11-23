library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use work.types.all;
          
entity moalu is 
	generic( 
		Nb	:integer
	);
	port( 
		clk	:in std_logic; 
		X	:in std_logic;
		C	:in std_logic;
		R	:in std_logic; 
		TX_out	:out std_logic:='0'
	);
end moalu;
   
architecture moalu_behavior of moalu is

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

	component moalu_serial_interface is 
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
	end component;

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
          
	component moalu_pipo_register is 
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
	end component;

	component moalu_alu is 
		generic(
			Nb	:integer
		);
		port( 
        	 	C_ctrl, SUB_ctrl, C2_ctrl, SUM_ctrl	:in std_logic;
			A,B					:in std_logic_vector(Nb-1 downto 0);
			C					:in std_logic;
			ALU_out					:out std_logic_vector(Nb-1 downto 0)
		);
	end component;

	signal RX_ctrl, C_ctrl, SUB_ctrl, C2_ctrl, SUM_ctrl, TX_ctrl :std_logic;
	signal signal_one :std_logic:='1';	
	signal si_out :std_logic_vector((Nb*2)-1 downto 0);	
	signal A, B, ALU_out, R_out :std_logic_vector(Nb-1 downto 0);
	signal R_out_enable :std_logic;

begin  

      	moalu_fsm_c : moalu_fsm
	generic map (Nb => Nb)
	port map (clk, X, R, RX_ctrl, C_ctrl, SUB_ctrl, C2_ctrl, SUM_ctrl, TX_ctrl);

	moalu_serial_interface_c : moalu_serial_interface 
	generic map (Nb => Nb*2)
	port map (clk, RX_ctrl, R, X, si_out);

	moalu_pipo_register_a : moalu_pipo_register 
	generic map (Nb => Nb)
	port map (clk, signal_one, R, si_out((Nb*2)-1 downto Nb), A);

	moalu_pipo_register_b : moalu_pipo_register 
	generic map (Nb => Nb)
	port map (clk, signal_one, R, si_out(Nb-1 downto 0), B);

	moalu_inverse_serial_interface_c : moalu_inverse_serial_interface
	generic map (Nb => Nb*2)
	port map (clk, TX_ctrl, A&B, TX_out);

	moalu_alu_c : moalu_alu 
	generic map (Nb => Nb)
	port map (C_ctrl, SUB_ctrl, C2_ctrl, SUM_ctrl, A, B, C, ALU_out);

	R_out_enable <= '1' when C_ctrl='1' or SUB_ctrl='1' or C2_ctrl='1' or SUM_ctrl='1' else '0';

	moalu_pipo_register_out : moalu_pipo_register 
	generic map (Nb => Nb)
	port map (clk, R_out_enable, R, ALU_out, R_out);	


end moalu_behavior;
