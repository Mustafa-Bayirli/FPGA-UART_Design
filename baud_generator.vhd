LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

entity baud_generator is
                port (rst,clk: in STD_LOGIC;
                      sel: in STD_LOGIC_VECTOR (2 downto 0);
                      Bclkx8, Bclk: out STD_LOGIC);
end baud_generator;

architecture struct of baud_generator is
SIGNAL clk_25, clk_div41: STD_LOGIC;
SIGNAL clk_div_temp: STD_LOGIC_VECTOR (7 downto 0);
SIGNAL Bclkx8_temp: STD_LOGIC_VECTOR (0 downto 0);
begin

  div_2_25: ENTITY work.single_freq_div port map (i_resetBar => rst,
                                                  i_clk => clk,
                                                  o_clk2 => clk_25);
  div41: entity work.freq_div41 port map (i_resetBar => rst,
                                          i_clk => clk_25,
                                          o_clkdiv => clk_div41);
  clkdiv: entity work.freq_div port map  (i_resetBar => rst,
  		                                    i_clk => clk_div41,
  		                                    o_clkdiv => clk_div_temp);
  mux:    entity work.mux8_1 generic map (N => 1)
                                port map (A7 => clk_div_temp(7 downto 7),
                                          A6 => clk_div_temp(6 downto 6),
                                          A5 => clk_div_temp(5 downto 5),
                                          A4 => clk_div_temp(4 downto 4),
                                          A3 => clk_div_temp(3 downto 3),
                                          A2 => clk_div_temp(2 downto 2),
                                          A1 => clk_div_temp(1 downto 1),
                                          A0 => clk_div_temp(0 downto 0),
                                          S  => sel,
                                          Y  => Bclkx8_temp);
  Bclkx8 <= Bclkx8_temp(0);
  div8: entity work.freq_div8 port map (i_resetBar => rst,
                                        i_clk => Bclkx8_temp(0),
                                         o_clkdiv => Bclk);
end struct;