library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
          
entity moalu_c2 is 
	generic( 
		Nb	:integer
	);
	port( 
		enable	:in std_logic;
		A	:in std_logic_vector(Nb-1 downto 0);
		C2	:out std_logic_vector(Nb-1 downto 0)
	);
end moalu_c2;

architecture moalu_c2_behavior of moalu_c2 is

begin

	process(A, enable)
	variable invA: std_logic_vector(Nb-1 downto 0);
	begin
		if enable='1' then
            		for k in Nb-1 downto 0 loop
				invA(k):=not A(k);
			end loop;
			C2 <= invA+'1';
		end if;
	end process;
      	
end moalu_c2_behavior;
