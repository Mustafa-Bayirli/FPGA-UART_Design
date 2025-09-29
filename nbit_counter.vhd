LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity nbit_counter IS
   GENERIC (N: INTEGER);
      PORT (i_loadValue: IN STD_LOGIC_VECTOR(N-1 downto 0);
            i_load, i_enable: IN STD_LOGIC;
            i_clk, i_rst: IN STD_LOGIC;
            o_value: OUT STD_LOGIC_VECTOR(N-1 downto 0));
            
end nbit_counter;

architecture struct of nbit_counter is
SIGNAL reg_in, reg_out, adder_out: STD_LOGIC_VECTOR (N-1 downto 0);
SIGNAL reg_enable: STD_LOGIC;

begin
  mux: entity work.mux2_1 GENERIC MAP (N => N)
                            PORT MAP (A0 => adder_out,
                                      A1 => i_loadValue,
                                      S0 => i_load,
                                      Y  => reg_in);

  reg: entity work.nbit_reg GENERIC MAP (N => N)
                               PORT MAP (i_resetBar => i_rst,
                                         i_load => reg_enable,
                                         i_clock => i_clk,
                                         i_value => reg_in,
                                         o_value => reg_out);

  add: entity work.nbit_carry_reg GENERIC MAP (N => N)
                               PORT MAP (x => reg_out,
                                         y => (others => '0'), 
                                         c_i => '1',
                                         s_o => adder_out);

  o_value <= reg_out;
  reg_enable <= i_enable or i_load;

 
 end struct;