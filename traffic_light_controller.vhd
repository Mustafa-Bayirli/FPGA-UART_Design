LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity traffic_light_controller is
  PORT (GClock, GReset: in STD_LOGIC;
        MSC, SSC : in STD_LOGIC_VECTOR(3 downto 0);
        SSCS: in STD_LOGIC;
        MSTL, SSTL: out STD_LOGIC_VECTOR (2 downto 0);
        BCD1, BCD2: out STD_LOGIC_VECTOR (3 downto 0);
        STATE: out STD_LOGIC_VECTOR (1 downto 0));
end traffic_light_controller;

architecture traffic_light of traffic_light_controller is
signal MT, ST: STD_LOGIC_VECTOR (3 downto 0);
signal MSC_load, MT_load, SSC_load, SST_load: STD_LOGIC;
signal MSC_enable, MT_enable, SSC_enable, SST_enable: STD_LOGIC;
signal MSC_done, MT_done, SSC_done, SST_done: STD_LOGIC;
signal MSC_count, MT_count, SSC_count, SST_count, TIMER_out: STD_LOGIC_VECTOR (3 downto 0);
signal TIMER_SELECT: STD_LOGIC_VECTOR (1 downto 0);

begin
     traffic_light_fsm: entity work.traffic_light_fsm(traffic_light_cont)
	                                        PORT MAP (CLK => GClock,
                                                     RST => GReset,
                                                     SSCS => SSCS,
                                                     MSC_DONE => MSC_DONE,
                                                     MSC_ENABLE => MSC_ENABLE,
                                                     MSC_LOAD => MSC_LOAD,
                                                     MT_DONE => MT_DONE,
                                                     MT_ENABLE => MT_ENABLE,
                                                     MT_LOAD => MT_LOAD,
                                                     SSC_DONE => SSC_DONE,
                                                     SSC_ENABLE => SSC_ENABLE,
                                                     SSC_LOAD => SSC_LOAD,
                                                     SST_DONE => SST_DONE,
                                                     SST_ENABLE => SST_ENABLE,
                                                     SST_LOAD => SST_LOAD,
                                                     TIMER_SELECT => TIMER_SELECT,
                                                     MSTL => MSTL,
                                                     SSTL => SSTL,
                                                     STATE => STATE
                                                     );

    timer_mst: entity work.nbit_timer GENERIC MAP (N => 4)
                                           PORT MAP (i_loadValue => MSC,
                                                     i_load => MSC_load,
                                                     i_enable => MSC_enable,
                                                     i_clk => GClock,
                                                     i_rst => GReset,
                                                     o_value => MSC_count,
                                                     o_done => MSC_done);

    timer_mt: entity work.nbit_timer GENERIC MAP (N => 4)
                                          PORT MAP (i_loadValue => MT,
                                                    i_load => MT_load,
                                                    i_enable => MT_enable,
                                                    i_clk => GClock,
                                                    i_rst => GReset,
                                                    o_value => MT_count,
                                                    o_done => MT_done);

    timer_ssc: entity work.nbit_timer GENERIC MAP (N => 4)
                                           PORT MAP (i_loadValue => SSC,
                                                     i_load => SSC_load,
                                                     i_enable => SSC_enable,
                                                     i_clk => GClock,
                                                     i_rst => GReset,
                                                     o_value => SSC_count,
                                                     o_done => SSC_done);

    timer_sst: entity work.nbit_timer GENERIC MAP (N => 4)
                                           PORT MAP (i_loadValue => ST,
                                                     i_load => SST_load,
                                                     i_enable => SST_enable,
                                                     i_clk => GClock,
                                                     i_rst => GReset,
                                                     o_value => SST_count,
                                                     o_done => SST_done);

   timer_mux: entity work.mux4_1 GENERIC MAP (N => 4)
                                          PORT MAP (A0 => MSC_count,
                                                    A1 => MT_count,
                                                    A2 => SSC_count,
                                                    A3 => SST_count,
                                                    S0 => timer_select(0),
                                                    S1 => timer_select(1),
                                                    Y  => timer_out);

    bcd: entity work.bcd_decoder PORT MAP (i_hex => timer_out,
                                           o_bcd0 => BCD1,
                                           o_bcd1 => BCD2);

  ST <= "0011";
  MT <= "0110";
end traffic_light;