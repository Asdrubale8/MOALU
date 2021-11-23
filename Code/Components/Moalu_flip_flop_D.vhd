library ieee;
use ieee.std_logic_1164.all;

entity moalu_flip_flop_D is
	port(
         	clk	:in  std_logic;
         	enable	:in  std_logic;
         	reset	:in  std_logic;
		D  	:in  std_logic; 
         	Q  	:out std_logic:='0'
	);
end moalu_flip_flop_D;
    
architecture moalu_flip_flop_D_behavior of moalu_flip_flop_D is
	
	signal qtemp:std_logic:='0';
begin
   
	process(clk, reset)
	variable qvar:std_logic:='0';
	--variable d_master:std_logic:='0';
	--variable d_slave:std_logic:='0';

	begin
		if reset = '0' then
			qvar:='0';
		elsif rising_edge(clk) then
			if enable='1' then
				qvar:=D;
			end if;
		end if;
		qtemp<=qvar;
		--if enable ='1' then
    			--if clk='0' then 
       		--		d_master:=D;
		--end if;
		--if clk='1' then
		--	d_slave:=d_master;
		--end if;
		--Q<=d_slave;
	end process;
	Q<=qtemp;
 
end moalu_flip_flop_D_behavior;
