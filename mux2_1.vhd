LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

entity mux2_1 is generic (N: integer);
                port (A1, A0: in STD_LOGIC_VECTOR (N-1 downto 0);
                      S0: in STD_LOGIC;
                      Y: out STD_LOGIC_VECTOR (N-1 downto 0));
end mux2_1;

architecture rtl of mux2_1 is
  signal s0_bar: STD_LOGIC;
  signal s_A1, s_A0: STD_LOGIC_VECTOR(N-1 downto 0);
  begin
    s0_bar <= not s0;

    mux: for i in 0 to N-1 generate
      s_A1(i) <= s0 and A1(i);
      s_A0(i) <= s0_bar and A0(i);

      Y(i) <= s_A1(i) or s_A0(i);
    end generate;
end architecture rtl;