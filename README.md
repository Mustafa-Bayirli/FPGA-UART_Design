# UART Design - CEG 3155 Digital Systems II Project

---

## Project Overview
This project implements a complete UART (Universal Asynchronous Receiver-Transmitter) in VHDL for the CEG 3155 Digital Systems II course. The UART is integrated with a traffic light controller to provide real-time debug messaging capabilities.

---

## Features
- **Full UART Implementation**: Transmitter, receiver, baud rate generator, and control registers
- **Programmable Baud Rates**: 300 to 38400 baud using SEL[2:0] control bits
- **Traffic Light Integration**: Debug messages for traffic light state changes
- **Interrupt Support**: TIE and RIE for transmit/receive interrupts
- **Polling Mode**: Alternative implementation for interrupt handling
- **BCD Display**: Bonus feature for counter value display (optional)

--- 

## Key Components

### UART Modules
- **Transmitter**: Handles parallel-to-serial conversion with start/stop bits
- **Receiver**: Manages serial-to-parallel conversion with clock synchronization
- **Baud Rate Generator**: Programmable clock divider for different baud rates
- **UART Registers**: RDR, TDR, SCCR, SCSR
- **Address Decoder**: Memory-mapped interface for microcontroller communication

### Traffic Light Controller
- **Four States**: 
  - Mg_Sr: Main green / Side red
  - My_Sr: Main yellow / Side red  
  - Mr_Sg: Main red / Side green
  - Mr_Sy: Main red / Side yellow
- **Debug Messages**: Serial output of state information
- **Car Sensor Input**: SSCS for side street vehicle detection

--- 

## Design Specifications

### Inputs/Outputs
| Signal | Type | Description |
|--------|------|-------------|
| GClock | Input | Global clock (25.175 MHz) |
| GReset | Input | Global reset |
| SSCS | Input | Side street car sensor |
| SW1[3:0] | Input | Main street DIP switches |
| SW2[3:0] | Input | Side street DIP switches |
| RxD | Input | Serial receive data |
| TxD | Output | Serial transmit data |
| MSTL[2:0] | Output | Main street traffic lights |
| SSTL[2:0] | Output | Side street traffic lights |

### Baud Rates
| SEL[2:0] | Baud Rate |
|----------|-----------|
| 000 | 38377 |
| 001 | 19188 |
| 010 | 9594 |
| 011 | 4797 |
| 100 | 2398 |
| 101 | 1199 |
| 110 | 600 |
| 111 | 300 |

---

## Implementation Details

### Technology
- **Language**: VHDL (Structural/RTL level)
- **Tools**: Quartus II, ModelSim
- **Board**: Altera DE-2 with Cyclone FPGA
- **Clock**: 25.175 MHz system clock

### Design Constraints
- Structural VHDL implementation only (no behavioral)
- RTL design methodology
- Synchronous design with global reset
- No core instantiations (custom implementation)

---

## Usage

### Simulation
1. Open project in Quartus II
2. Compile all VHDL files
3. Run timing simulations in ModelSim
4. Verify UART functionality and debug messages

### Hardware Deployment
1. Program DE-2 board with generated .sof file
2. Connect serial port to PC (TxD, RxD, GND)
3. Use terminal program (HyperTerminal, Minicom) at matching baud rate
4. Observe debug messages on state changes

### Configuration
1. Set baud rate using SEL[2:0] bits in SCCR register
2. Configure interrupt enables (TIE, RIE) as needed
3. Set DIP switches for timing parameters

---

## Testing
The design includes:
- Loopback test verification
- State transition testing
- Baud rate accuracy validation
- Interrupt/polling mode operation
- Error condition handling (framing, overrun)
