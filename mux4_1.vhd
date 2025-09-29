LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

entity mux4_1 is generic (N: integer);
                port (A3, A2, A1, A0: in STD_LOGIC_VECTOR (N-1 downto 0);
                      S1, S0: in STD_LOGIC;
                      Y: out STD_LOGIC_VECTOR (N-1 downto 0));
end mux4_1;

architecture rtl of mux4_1 is
signal s1_bar, s0_bar: STD_LOGIC;
signal s_A3, s_A2, s_A1, s_A0: STD_LOGIC_VECTOR(N-1 downto 0);

begin
    s1_bar <= not s1;
    s0_bar <= not s0;

    mux: for i in 0 to N-1 generate
      s_A1(i) <= s1 and s0 and A3(i);
      s_A2(i) <= s1 and s0_bar and A2(i);
      s_A1(i) <= s1_bar and s0 and A1(i);
      s_A0(i) <= s1_bar and s0_bar and A0(i);

      Y(i) <= s_A3(i) or s_A2(i) or s_A1(i) or s_A0(i);
    end generate;
end  rtl;