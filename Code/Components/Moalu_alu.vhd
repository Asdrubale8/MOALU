library ieee;
use ieee.std_logic_1164.all;

entity moalu_alu is
	generic(
		Nb	:integer
	);
	port( 
         	C_ctrl, SUB_ctrl, C2_ctrl, SUM_ctrl	:in std_logic;
		A,B					:in std_logic_vector(Nb-1 downto 0);
		C					:in std_logic;
		ALU_out					:out std_logic_vector(Nb-1 downto 0):=(others => '0')
	);
end moalu_alu;
    
architecture moalu_alu_behavior of moalu_alu is
	
	component moalu_invert_function is 
		generic( 
			Nb	:integer
		);
		port( 
			enable			:in std_logic;
			A, B			:in std_logic_vector(0 to Nb-1);
			C			:in std_logic;
			SUB1_in, SUB2_in	:out std_logic_vector(0 to Nb-1)
		);
	end component;

	component moalu_compare is 
		generic( 
			Nb	:integer
		);
		port( 
			enable	:in std_logic;
			A	:in std_logic_vector(Nb-1 downto 0); 
			B	:in std_logic_vector(Nb-1 downto 0); 
			equal	:out std_logic_vector(Nb-1 downto 0)
		);
	end component;
	     
	component moalu_sub is 
			generic( 
			Nb	:integer
		);
		port( 
			enable	:in std_logic;
			A	:in std_logic_vector(Nb-1 downto 0);
			B	:in std_logic_vector(Nb-1 downto 0);
			sub	:out std_logic_vector(Nb-1 downto 0)
		);
	end component;

	component moalu_c2 is 
		generic( 
			Nb	:integer
		);
		port( 
			enable	:in std_logic;
			A	:in std_logic_vector(Nb-1 downto 0);
			C2	:out std_logic_vector(Nb-1 downto 0)
		);
	end component;

	component moalu_sum is 
		generic( 
			Nb	:integer
		);
		port( 
			enable	:in std_logic;
			A	:in std_logic_vector(Nb-1 downto 0); 
			B	:in std_logic_vector(Nb-1 downto 0); 
			sum	:out std_logic_vector(Nb-1 downto 0)
		);
	end component;

	component moalu_result_function is 
		generic( 
			Nb	:integer
		);
		port( 		
			C_out, SUB_out, C2_out, SUM_out			:in std_logic_vector(0 to Nb-1);		
			C_ctrl, SUB_ctrl, C2_ctrl, SUM_ctrl		:in std_logic;
			ALU_out						:out std_logic_vector(0 to Nb-1):=(others=>'0')
		);
	end component;

	signal C_out, SUB_out, C2_out, SUM_out :std_logic_vector(Nb-1 downto 0);	
	signal SUB1_in, SUB2_in, C2_in :std_logic_vector(Nb-1 downto 0);

begin

	moalu_invert_function_c : moalu_invert_function
	generic map (Nb => Nb)
	port map(SUB_ctrl, A, B, C, SUB1_in, SUB2_in);

	-- Mux
	C2_in <= A when C = '0' else B;
	
	moalu_compare_c : moalu_compare
	generic map (Nb => Nb)
	port map(C_ctrl, A, B, C_out);

	moalu_sub_c : moalu_sub
	generic map (Nb => Nb)
	port map(SUB_ctrl, SUB1_in, SUB2_in, SUB_out);

	moalu_c2_c : moalu_c2
	generic map (Nb => Nb)
	port map(C2_ctrl, C2_in, C2_out);

	moalu_sum_c : moalu_sum
	generic map (Nb => Nb)
	port map(SUM_ctrl, A, B, SUM_out);

	moalu_result_function_c : moalu_result_function
	generic map (Nb => Nb)
	port map(C_out, SUB_out, C2_out, SUM_out, C_ctrl, SUB_ctrl, C2_ctrl, SUM_ctrl, ALU_out);

end moalu_alu_behavior;