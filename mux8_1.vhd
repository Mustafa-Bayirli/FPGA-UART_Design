LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

entity mux8_1 is generic (N: integer);
                port (A7, A6, A5, A4, A3, A2, A1, A0: in STD_LOGIC_VECTOR (N-1 downto 0);
                      S: in STD_LOGIC_VECTOR (2 downto 0);
                      Y: out STD_LOGIC_VECTOR (N-1 downto 0));
end mux8_1;

architecture rtl of mux8_1 is
signal s2_Bar_out, s2_out:STD_LOGIC_VECTOR(N-1 downto 0);

begin
    mux_S2_Bar: entity work.mux4_1 generic map (N => N)
                                      port map (A3 => A3,
                                                A2 => A2,
                                                A1 => A1,
                                                A0 => A0,
                                                S1 => S(1),
                                                S0 => S(0),
                                                Y => s2_Bar_out);

    mux_S2    : entity work.mux4_1 generic map (N => N)
                                      port map (A3 => A7,
                                                A2 => A6,
                                                A1 => A5,
                                                A0 => A4,
                                                S1 => S(1),
                                                S0 => S(0),
                                                Y => s2_out);

   mux:       entity work.mux2_1 generic map (N => N)
                                    port map (A1 => s2_out,
                                              A0 => s2_Bar_out,
                                              S0  => S(2),
                                              Y  => Y);
end  rtl;