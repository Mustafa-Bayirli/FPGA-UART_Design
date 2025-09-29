LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity nbit_carry_reg is 
	generic ( N : Integer:= 4);
	   PORT ( x, y: IN STD_LOGIC_VECTOR(n-1 downto 0);
		       c_i : IN STD_LOGIC;
		       s_o : OUT STD_LOGIC_VECTOR(n-1 downto 0);
		       c_o, overflow: OUT STD_LOGIC
		      );
END nbit_carry_reg;

architecture struct of nbit_carry_reg is
signal c : STD_LOGIC_VECTOR (n-1 downto 0);

begin
	fa0: entity work.full_adder port map (i_bit1 => x(0),
										           i_bit2 => y(0),
										           i_carry => c_i,
										           o_sum => s_o(0),
										           o_carry => c(0));

	adders: for i in 1 to n-1 generate
		fa: entity work.full_adder port map(i_bit1 => x(i),
											         i_bit2 => y(i),
											         i_carry => c(i-1),
											         o_sum => s_o(i),
											         o_carry => c(i));
	end generate adders;

	c_o <= c(n-1);
	overflow <= c(n-1) xor c(n-2);
end  struct;