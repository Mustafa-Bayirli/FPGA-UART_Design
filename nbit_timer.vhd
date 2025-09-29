LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity nbit_timer is
  GENERIC (N: INTEGER);
     PORT (i_loadValue: IN STD_LOGIC_VECTOR(N-1 downto 0);
           i_load, i_enable: IN STD_LOGIC;
           i_clk, i_rst: IN STD_LOGIC;
           o_value: OUT STD_LOGIC_VECTOR(N-1 downto 0);
           o_done: OUT STD_LOGIC);
end nbit_timer;

architecture struct of nbit_timer is
SIGNAL reg_in, reg_out, adder_out: STD_LOGIC_VECTOR (N-1 downto 0);
SIGNAL or_tmp: STD_LOGIC_VECTOR (N-1 downto 0);
SIGNAL zero: STD_LOGIC;
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
                                          y => (others => '1'), 
                                          c_i => '0',
                                          s_o => adder_out);

  o_Value <= reg_out;
  reg_enable <= (i_enable and not zero) or i_load;

  or_tmp(0) <= reg_out(0); 
  or_loop : for i in 1 to n-1 generate
  or_tmp(i) <= reg_out(i) or or_tmp(i-1); 
  end generate or_loop;
  zero <= not or_tmp(n-1);
  o_done <= zero;
end  struct;