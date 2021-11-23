library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
          
entity moalu_compare is 
	generic( 
		Nb	:integer
	);
	port( 
		enable	:in std_logic;
		A	:in std_logic_vector(Nb-1 downto 0); 
		B	:in std_logic_vector(Nb-1 downto 0); 
		equal	:out std_logic_vector(Nb-1 downto 0)
	);
end moalu_compare;
  


architecture moalu_compare_behavior of moalu_compare is

constant equal_true	:std_logic_vector(Nb-1 downto 0):=(0 => '1', others => '0');
constant equal_false	:std_logic_vector(Nb-1 downto 0):=(others => '0');

begin

	equal <= equal_true when A=B else equal_false when enable='1';
      	
end moalu_compare_behavior;
