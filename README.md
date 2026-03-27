# Hexadecimal to Binary Encoder | Verilog

![Language](https://img.shields.io/badge/Language-Verilog-blue)
![Tool](https://img.shields.io/badge/Tool-Xilinx%20Vivado-red)
![Type](https://img.shields.io/badge/Type-Combinational%20Logic-green)
![Status](https://img.shields.io/badge/Simulation-Passing-brightgreen)

A Verilog implementation of a **16-input Hexadecimal to Binary Encoder**, designed and simulated in **Xilinx Vivado**.

This document explains:
- What a hexadecimal to binary encoder is
- How the number of output bits is derived
- The truth table, boolean expressions, implementation details, and simulation results

The project includes the RTL design, testbench, and console-style output verifying correct behavior.

---

## Table of Contents

1. [What Is a Hexadecimal to Binary Encoder?](#what-is-a-hexadecimal-to-binary-encoder)
2. [How the Encoder Works](#how-the-encoder-works)
3. [Truth Table](#truth-table)
4. [Boolean Expressions](#boolean-expressions)
5. [Verilog Implementation](#verilog-implementation)
6. [Testbench](#testbench)
7. [Testbench Output](#testbench-output)
8. [Circuit Diagram](#circuit-diagram)
9. [Waveform Diagram](#waveform-diagram)
10. [Running the Project in Vivado](#running-the-project-in-vivado)
11. [Project Files](#project-files)

---

## What Is a Hexadecimal to Binary Encoder?

A **hexadecimal to binary encoder** is a combinational logic circuit that takes **sixteen mutually exclusive inputs** — one for each hexadecimal digit (`0`–`F`) — and produces a **4-bit binary output** (`B3`, `B2`, `B1`, `B0`).

Each input line represents a single hex digit. When asserted, the circuit encodes that digit into its equivalent 4-bit binary representation.

> **Assumption:** Exactly one input is active at a time (mutually exclusive inputs).

---

## How the Encoder Works

To determine the number of output bits required for 16 inputs, we apply the standard encoder formula:

```
N = 2^m
16 = 2^m
m = 4
```

Since hexadecimal digits range from `0` to `F` (0–15 in decimal), any hex digit can be represented exactly using **four binary bits**. The encoder maps each of the 16 hex inputs to a unique 4-bit output:

| Active Input | B3 | B2 | B1 | B0 | Binary Value |
|:---:|:---:|:---:|:---:|:---:|:---:|
| `zero`  | 0 | 0 | 0 | 0 | `0000` |
| `one`   | 0 | 0 | 0 | 1 | `0001` |
| `two`   | 0 | 0 | 1 | 0 | `0010` |
| `three` | 0 | 0 | 1 | 1 | `0011` |
| `four`  | 0 | 1 | 0 | 0 | `0100` |
| `five`  | 0 | 1 | 0 | 1 | `0101` |
| `six`   | 0 | 1 | 1 | 0 | `0110` |
| `seven` | 0 | 1 | 1 | 1 | `0111` |
| `eight` | 1 | 0 | 0 | 0 | `1000` |
| `nine`  | 1 | 0 | 0 | 1 | `1001` |
| `a`     | 1 | 0 | 1 | 0 | `1010` |
| `b`     | 1 | 0 | 1 | 1 | `1011` |
| `c`     | 1 | 1 | 0 | 0 | `1100` |
| `d`     | 1 | 1 | 0 | 1 | `1101` |
| `e`     | 1 | 1 | 1 | 0 | `1110` |
| `f`     | 1 | 1 | 1 | 1 | `1111` |

---

## Truth Table

| Input   | B3 | B2 | B1 | B0 |
|:-------:|:--:|:--:|:--:|:--:|
| `zero`  | 0  | 0  | 0  | 0  |
| `one`   | 0  | 0  | 0  | 1  |
| `two`   | 0  | 0  | 1  | 0  |
| `three` | 0  | 0  | 1  | 1  |
| `four`  | 0  | 1  | 0  | 0  |
| `five`  | 0  | 1  | 0  | 1  |
| `six`   | 0  | 1  | 1  | 0  |
| `seven` | 0  | 1  | 1  | 1  |
| `eight` | 1  | 0  | 0  | 0  |
| `nine`  | 1  | 0  | 0  | 1  |
| `a`     | 1  | 0  | 1  | 0  |
| `b`     | 1  | 0  | 1  | 1  |
| `c`     | 1  | 1  | 0  | 0  |
| `d`     | 1  | 1  | 0  | 1  |
| `e`     | 1  | 1  | 1  | 0  |
| `f`     | 1  | 1  | 1  | 1  |

---

## Boolean Expressions

Each output bit is high for the hex inputs where that bit equals `1` in the corresponding binary value:

```
B3 = eight | nine | a | b | c | d | e | f
B2 = four  | five | six | seven | c | d | e | f
B1 = two   | three | six | seven | a | b | e | f
B0 = one   | three | five | seven | nine | b | d | f
```

These expressions are read directly from the truth table:
- **`B3`** is the MSB — high only for inputs `8` through `F` (values ≥ 8)
- **`B2`** is high for inputs `4`–`7` and `C`–`F`
- **`B1`** is high for inputs `2`, `3`, `6`, `7`, `A`, `B`, `E`, `F`
- **`B0`** is the LSB — high for all odd-valued inputs

---

## Circuit Diagram

Below is a circuit diagram illustrating the OR gate structure used to implement the encoder:

![Hexadecimal to Binary Circuit](/imageAssets/HexBinaryCircuit.png)

---

## Waveform Diagram

Below is the waveform diagram captured when running the simulation using the files in this project:

![Hexadecimal to Binary Waveform](/imageAssets/HexBinaryWaveform.png)

---

## Verilog Implementation

```verilog
`timescale 1ns / 1ps

module hexademicalBinary(
    input  zero, one, two, three, four, five, six, seven,
    input  eight, nine, a, b, c, d, e, f,
    output B3,
    output B2,
    output B1,
    output B0
    );

    assign B3 = eight | nine | a | b | c | d | e | f;
    assign B2 = four  | five | six | seven | c | d | e | f;
    assign B1 = two   | three | six | seven | a | b | e | f;
    assign B0 = one   | three | five | seven | nine | b | d | f;

endmodule
```

---

## Testbench

```verilog
`timescale 1ns / 1ps

module hexademicalBinary_tb();
    reg zero, one, two, three, four, five, six, seven;
    reg eight, nine, a, b, c, d, e, f;

    wire B3, B2, B1, B0;

    hexademicalBinary uut(zero, one, two, three, four, five, six, seven,
                          eight, nine, a, b, c, d, e, f,
                          B3, B2, B1, B0);

    task clear_inputs;
    begin
        zero = 0; one = 0; two = 0; three = 0; four = 0;
        five = 0; six = 0; seven = 0;
        eight = 0; nine = 0; a = 0; b = 0;
        c = 0; d = 0; e = 0; f = 0;
    end
    endtask

    initial begin
        clear_inputs; zero  = 1; #10 $display("0 -> %b%b%b%b", B3, B2, B1, B0);
        clear_inputs; one   = 1; #10 $display("1 -> %b%b%b%b", B3, B2, B1, B0);
        clear_inputs; two   = 1; #10 $display("2 -> %b%b%b%b", B3, B2, B1, B0);
        clear_inputs; three = 1; #10 $display("3 -> %b%b%b%b", B3, B2, B1, B0);
        clear_inputs; four  = 1; #10 $display("4 -> %b%b%b%b", B3, B2, B1, B0);
        clear_inputs; five  = 1; #10 $display("5 -> %b%b%b%b", B3, B2, B1, B0);
        clear_inputs; six   = 1; #10 $display("6 -> %b%b%b%b", B3, B2, B1, B0);
        clear_inputs; seven = 1; #10 $display("7 -> %b%b%b%b", B3, B2, B1, B0);
        clear_inputs; eight = 1; #10 $display("8 -> %b%b%b%b", B3, B2, B1, B0);
        clear_inputs; nine  = 1; #10 $display("9 -> %b%b%b%b", B3, B2, B1, B0);
        clear_inputs; a     = 1; #10 $display("A -> %b%b%b%b", B3, B2, B1, B0);
        clear_inputs; b     = 1; #10 $display("B -> %b%b%b%b", B3, B2, B1, B0);
        clear_inputs; c     = 1; #10 $display("C -> %b%b%b%b", B3, B2, B1, B0);
        clear_inputs; d     = 1; #10 $display("D -> %b%b%b%b", B3, B2, B1, B0);
        clear_inputs; e     = 1; #10 $display("E -> %b%b%b%b", B3, B2, B1, B0);
        clear_inputs; f     = 1; #10 $display("F -> %b%b%b%b", B3, B2, B1, B0);
    end
endmodule
```

---

## Testbench Output

Console output confirming correct hexadecimal-to-binary encoding behavior:

```
0 -> 0000
1 -> 0001
2 -> 0010
3 -> 0011
4 -> 0100
5 -> 0101
6 -> 0110
7 -> 0111
8 -> 1000
9 -> 1001
A -> 1010
B -> 1011
C -> 1100
D -> 1101
E -> 1110
F -> 1111
```

**Verification summary:**
- `B3` is `1` only for inputs `8` through `F` — the MSB of binary values ≥ 8
- `B2` is `1` for inputs `4`–`7` and `C`–`F`
- `B1` is `1` for inputs `2`, `3`, `6`, `7`, `A`, `B`, `E`, `F`
- `B0` is `1` for all odd inputs: `1`, `3`, `5`, `7`, `9`, `B`, `D`, `F`

---

## Running the Project in Vivado

### 1. Launch Vivado

Open **Xilinx Vivado**.

### 2. Create a New RTL Project

1. Click **Create Project**
2. Select **RTL Project**
3. Optionally enable *Do not specify sources at this time*, or add source files directly

### 3. Add Source Files

| Role              | File                       |
|-------------------|----------------------------|
| Design Source     | `hexademicalBinary.v`      |
| Simulation Source | `hexademicalBinary_tb.v`   |

> Set `hexademicalBinary_tb.v` as the **simulation top module**.

### 4. Run Behavioral Simulation

Navigate to:

```
Flow → Run Simulation → Run Behavioral Simulation
```

Observe the signals in the waveform viewer:

```
Inputs : zero, one, two, three, four, five, six, seven,
         eight, nine, a, b, c, d, e, f
Outputs: B3, B2, B1, B0
```

Verify that the waveform output matches the truth table and the console output listed above.

---

## Project Files

| File                      | Description                                                              |
|---------------------------|--------------------------------------------------------------------------|
| `hexademicalBinary.v`     | Hexadecimal to binary encoder RTL module                                 |
| `hexademicalBinary_tb.v`  | Testbench — applies all 16 hex inputs and displays 4-bit binary output   |

---

## Author

**Kadhir Ponnambalam**

---

*Designed and simulated using Xilinx Vivado.*