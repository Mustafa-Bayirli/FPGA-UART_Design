LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity uart_bus_decoder is
  PORT (ADDR: IN STD_LOGIC_VECTOR (1 downto 0);
  		  R: IN STD_LOGIC;
  		  UART_SEL: IN STD_LOGIC;
  		  DATA_BUS: INOUT STD_LOGIC_VECTOR (7 downto 0);
  	     LD_TDR, LD_SCCR, RD_RDR: OUT STD_LOGIC;
  	     DATA_OUT: OUT STD_LOGIC_VECTOR(7 downto 0);
  	     DATA_IN_SCCR, DATA_IN_RDR, DATA_IN_SCSR: IN STD_LOGIC_VECTOR (7 downto 0));
end uart_bus_decoder;

architecture struct of uart_bus_decoder is
SIGNAL LD_SCCR2, LD_SCCR3: STD_LOGIC;
SIGNAL OUT_TEMP: STD_LOGIC_VECTOR (7 downto 0);
SIGNAL WRITE, READ: STD_LOGIC;

BEGIN
	WRITE <= not R and UART_SEL;
	READ  <= R and UART_SEL;
	in_decoder: entity work.decoder2_4 port map (EN => WRITE,
	                                             A => ADDR,
	                                             Y0 => LD_TDR,
	                                             Y2 => LD_SCCR2,
	                                             Y3 => LD_SCCR3);
	LD_SCCR <= LD_SCCR2 or LD_SCCR3;
	
	in_t: entity work.buffer_t generic map(N => 8)
	                                    port map(EN => WRITE,
	                                             X => DATA_BUS,
	                                             Y => DATA_OUT);
	                                            

	out_mux: entity work.mux4_1 GENERIC MAP (N => 8)
								              PORT MAP (A0 => DATA_IN_RDR,
								  		                  A1 => DATA_IN_SCSR,
							              	  		      A2 => DATA_IN_SCCR,
								  		                  A3 => DATA_IN_SCCR,
								  		                  S1 => ADDR(1),
								  		                  S0 => ADDR(0),
								  		                  Y => OUT_TEMP);

	out_t: ENTITY work.buffer_t GENERIC MAP (N => 8)
												  PORT MAP (EN => READ,
												 	         X => OUT_TEMP,
												 	         Y => DATA_BUS);

	RD_RDR <= READ and not ADDR(0) and not ADDR(1);
	
end struct;