LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity uart_traffic_light  is 
	 port(GReset,  GClock, traffic_clk: IN STD_LOGIC;
		   MSC, SSC: IN STD_LOGIC_VECTOR(3 downto 0);
         SSCS: IN STD_LOGIC;
         MSTL, SSTL: OUT STD_LOGIC_VECTOR (2 downto 0);
         BCD1, BCD2: OUT STD_LOGIC_VECTOR (3 downto 0);
         RxD: IN STD_LOGIC;
         TxD: OUT STD_LOGIC
     );
END uart_traffic_light;

ARCHITECTURE struct OF uart_traffic_light IS
SIGNAL uart_clk, RST: STD_LOGIC;
SIGNAL IRQ: STD_LOGIC;
SIGNAL STATE: STD_LOGIC_VECTOR (1 downto 0);
SIGNAL DATA_BUS: STD_LOGIC_VECTOR (7 downto 0);
SIGNAL ADDR: STD_LOGIC_VECTOR(1 downto 0);
SIGNAL R_WBar, UART_SEL: STD_LOGIC;
begin
    uart_fsm: entity work.control PORT MAP (CLK => GClock,
                                         RST => GReset,
                                         IRQ => IRQ,
                                         TRAFFIC_STATE => STATE,
                                         DATA_BUS => DATA_BUS,
                                         ADDR => ADDR,
                                         R_WBar => R_WBAR,
                                         UART_SEL => UART_SEL);

    uart:  entity work.uart port map (clk => GClock,
    									        rst => GReset,
    									        RxD => RxD, 
    									        TxD => TxD, 
    									        Data_Bus => DATA_BUS, 
    									        addr => ADDR, 
    									        R_WBar => R_WBAR, 
    									        UART_SEL => UART_SEL, 
    									        IRQ => IRQ);

    traffic: entity work.traffic_light_controller  PORT map(GClock => traffic_clk, 
                                                            GReset => GReset,
                                                            MSC => MSC, SSC => SSC,
                                                            SSCS => SSCS,
                                                            MSTL => MSTL, SSTL => SSTL,
                                                            BCD1 => BCD1, BCD2 => BCD2,
                                                            STATE => STATE);

 
end struct;