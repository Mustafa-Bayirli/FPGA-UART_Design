LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY buffer_t IS
  GENERIC (N: INTEGER);
     PORT (X: IN STD_LOGIC_VECTOR (N-1 downto 0);
  		     Y: OUT STD_LOGIC_VECTOR (N-1 downto 0);
  		     EN: IN STD_LOGIC);
end buffer_t;

architecture behav of buffer_t is
BEGIN
	Y <= X when EN = '1' else (others => 'Z');
end behav;