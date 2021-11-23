library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use work.types.all;
          
entity moalu_state_function is 
	generic(
		Nb	: integer
	);
	port( 
		clk	:in std_logic; 
		X	:in std_logic;
        	R	:in std_logic; 
        	state	:out statetype
	);
end moalu_state_function;
   
architecture moalu_state_function_behavior of moalu_state_function is
	signal currentstate, nextstate 	: statetype:=SB;

begin

	state <= currentstate;

	current_state_function: process(clk, R)
	begin
		if R='0' then
			currentstate <= SB;
		end if;
		if rising_edge(clk) then
			currentstate <= nextstate;
		end if;	
	end process;

	next_state_function: process(clk, X)
	constant rx_tx_size: integer:= 2*Nb;
	variable count : integer range 0 to rx_tx_size:=0;

	begin
		if clk = '0' then
		case currentstate is
			when SB =>
				case X is
					when '0' => nextstate <= S0;
					when '1' => nextstate <= S1;
					when others => nextstate <= SB;
				end case;
			when S0 => 
				case X is
					when '0' => nextstate <= S00;
					when '1' => nextstate <= S01;
					when others => nextstate <= SB;
				end case;
			when S1 =>
				case X is
					when '0' => nextstate <= S10;
					when '1' => nextstate <= S11;
					when others => nextstate <= SB;
				end case;
		
			when S00 =>
				case X is
					when '0' => nextstate <= SB;
					when '1' => nextstate <= TX; count := 0;
					when others => nextstate <= SB;
				end case;
		
			when S01 =>
				case X is
					when '0' => nextstate <= SUM;
					when '1' => nextstate <= C2;
					when others => nextstate <= SB;
				end case;
		
			when S10 =>
				case X is
					when '0' => nextstate <= SUB;
					when '1' => nextstate <= C;
					when others => nextstate <= SB;
				end case;
		
			when S11 =>
				case X is
					when '0' => nextstate <= SB;
					when '1' => nextstate <= RX; count := 0;
					when others => nextstate <= SB;
				end case;
		
			when RX | TX =>			
				if count=rx_tx_size then
					case X is
						when '0' => nextstate <= S0;
						when '1' => nextstate <= S1;
						when others => nextstate <= SB;
					end case;
				else
					count := count + 1;
				end if;

			when others =>
				case X is
					when '1' => nextstate <= S1;
					when '0' => nextstate <= S0;
					when others => nextstate <= SB;
				end case;
		
		end case;
		end if;
	end process;		

end moalu_state_function_behavior;
