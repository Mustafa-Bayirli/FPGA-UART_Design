library ieee ;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity char_out_mux is
    Port (Char_sel : in STD_LOGIC_VECTOR (2 downto 0);
          Word_sel : in STD_LOGIC_VECTOR (1 downto 0);
          Char_out : out  STD_LOGIC_VECTOR (7 downto 0));
end char_out_mux;

architecture struct of char_out_mux is
SIGNAL output1, output2, output3, output4: STD_LOGIC_VECTOR (7 downto 0);

BEGIN
    mux1:    entity work.mux8_1 generic map (N => 8)
                                  port map (A7 => (others => '0'),
                                            A6 => (others => '0'),
                                            A5 => x"0d",
                                            A4 => x"72",
                                            A3 => x"53",
                                            A2 => x"5F",
                                            A1 => x"67",
                                            A0 => x"4D",
                                            S  => Char_sel,
                                            Y  => output1);

    mux2:    entity work.mux8_1 generic map (N => 8)
                                   port map (A7 => (others => '0'),
                                             A6 => (others => '0'),
                                             A5 => x"0d",
                                             A4 => x"72",
                                             A3 => x"53",
                                             A2 => x"5F",
                                             A1 => x"79",
                                             A0 => x"4D",
                                             S  => Char_sel,
                                             Y  => output2);
                                         
    mux3:    entity work.mux8_1 generic map (N => 8)
                                   port map (A7 => (others => '0'),
                                             A6 => (others => '0'),
                                             A5 => x"0d",
                                             A4 => x"67",
                                             A3 => x"53",
                                             A2 => x"5F",
                                             A1 => x"72",
                                             A0 => x"4D",
                                             S  => Char_sel,
                                             Y  => output3);

    mux4:    entity work.mux8_1 generic map (N => 8)
                                   port map (A7 => (others => '0'),
                                             A6 => (others => '0'),
                                             A5 => x"0d",
                                             A4 => x"79",
                                             A3 => x"53",
                                             A2 => x"5F",
                                             A1 => x"72",
                                             A0 => x"4D",
                                             S  => Char_sel,
                                             Y  => output4);
    out_mux: ENTITY work.mux4_1 GENERIC MAP (N => 8)
								           port map (A0 => output1,
                                             A1 => output2,
                                             A2 => output3,
                                             A3 => output4,
                                             S1 => Word_sel(1),
                                             S0 => Word_sel(0),
                                             Y => Char_out);
end struct;