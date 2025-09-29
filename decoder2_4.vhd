LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY decoder2_4 IS
  PORT (EN: IN STD_LOGIC;
  		A: IN STD_LOGIC_VECTOR (1 downto 0);
  		Y0, Y1, Y2, Y3: OUT STD_LOGIC);
END decoder2_4;

ARCHITECTURE struct of decoder2_4 IS
BEGIN
	Y0 <= EN and (not A(1) and not A(0));
	Y1 <= EN and (not A(1) and     A(0));
	Y2 <= EN and (    A(1) and not A(0));
	Y3 <= EN and (    A(1) and     A(0));
END ARCHITECTURE struct;