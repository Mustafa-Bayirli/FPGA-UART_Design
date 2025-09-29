LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity full_adder is
	port ( i_bit1, i_bit2, i_carry: IN STD_LOGIC;
		    o_sum, o_carry: OUT STD_LOGIC
		  );
end full_adder;

architecture gate_level of full_adder is 
signal w_WIRE_1, w_WIRE_2, w_WIRE_3 : std_logic;

BEGIN
    w_WIRE_1 <= i_bit1 xor i_bit2;
    w_WIRE_2 <= w_WIRE_1 and i_carry;
    w_WIRE_3 <= i_bit1 and i_bit2;
 
    o_sum   <= w_WIRE_1 xor i_carry;
    o_carry <= w_WIRE_2 or w_WIRE_3;
	
end gate_level;