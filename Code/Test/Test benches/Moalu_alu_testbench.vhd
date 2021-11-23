library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
          
entity moalu_alu_testbench is
end moalu_alu_testbench;
   
architecture moalu_alu_testbench_behavior of moalu_alu_testbench is
   
	component moalu_alu is 
		generic(
			Nb	:integer
		);
		port( 
        	 	C_ctrl, SUB_ctrl, C2_ctrl, SUM_ctrl	:in std_logic;
			A,B					:in std_logic_vector(Nb-1 downto 0);
			C					:in std_logic;
			ALU_out					:out std_logic_vector(Nb-1 downto 0):=(others => '0')
		);
	end component;

   	constant numb: integer := 3;

	signal C_ctrl : std_logic:='0';
	signal SUB_ctrl : std_logic:='0';
	signal C2_ctrl : std_logic:='0';
	signal SUM_ctrl : std_logic:='1';

	signal A : std_logic_vector(numb-1 downto 0):="111";
	signal B : std_logic_vector(numb-1 downto 0):="000";

	signal C : std_logic:='1';

	signal ALU_out : std_logic_vector(numb-1 downto 0):="000";
begin

      	moalu_alu_c : moalu_alu 
	generic map (Nb => numb)
	port map (C_ctrl, SUB_ctrl, C2_ctrl, SUM_ctrl, A, B, C, ALU_out);	

end moalu_alu_testbench_behavior;
