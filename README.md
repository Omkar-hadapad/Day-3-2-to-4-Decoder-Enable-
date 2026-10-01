# Day 3 — 2-to-4 Decoder with Enable

<p align="center">
  <b>Digital VLSI • Verilog RTL • Functional Verification • Cadence Genus</b>
</p>

<p align="center">
  <code>Specification → Architecture → RTL → Testbench → Simulation → Verification → Synthesis → Timing → PPA → Documentation</code>
</p>

---

## 1. Project Information

| Item                | Details                          |
| ------------------- | -------------------------------- |
| Project             | Day 3                            |
| Design Title        | `2-to-4 Decoder with Enable`     |
| Top Module          | `decoder_2to4_top`               |
| Domain              | Digital VLSI / RTL Design        |
| HDL                 | Verilog HDL                      |
| Design Type         | Combinational Logic Circuit      |
| Verification        | Directed Functional Verification |
| Verification Result | **24/24 PASS**                   |
| Synthesis Tool      | Cadence Genus                    |
| Genus Version       | 21.14-s082_1                     |
| Technology Library  | `tsmc18`                         |
| Operating Condition | `slow (balanced_tree)`           |
| Wireload Mode       | `enclosed`                       |
| Area Mode           | `timing library`                 |
| Sequential Cells    | 0                                |
| Combinational Cells | 10                               |
| Status              | **Completed**                    |

---

## 2. Project Overview

This project implements a **2-to-4 decoder with enable control** using synthesizable Verilog RTL.

A 2-to-4 decoder converts a 2-bit binary input into one of four mutually exclusive output lines.

The enable input controls whether the decoder outputs are active.

For an enabled decoder:

| `A B` | Active Output |
| ----- | ------------- |
| `00`  | `Y0`          |
| `01`  | `Y1`          |
| `10`  | `Y2`          |
| `11`  | `Y3`          |

When the decoder is disabled, the outputs remain inactive according to the implemented enable logic.

The design was simulated using Cadence NC-Sim and synthesized using Cadence Genus with the `tsmc18` technology library.

---

## 3. Objective

* Understand decoder operation.
* Design a 2-to-4 decoder using combinational logic.
* Implement enable-controlled decoder logic.
* Understand one-hot output generation.
* Write synthesizable Verilog RTL.
* Develop a functional verification testbench.
* Verify all four input combinations.
* Verify enable ON/OFF operation.
* Compare RTL and gate-level behavior.
* Understand the synthesized hardware.
* Perform RTL synthesis using Cadence Genus.
* Analyze hierarchy and standard-cell mapping.
* Analyze area, timing and power.
* Document actual PPA results.
* Build a professional GitHub Digital VLSI portfolio project.

---

## 4. Concept

A decoder is a combinational circuit that converts an `n`-bit binary input into up to `2^n` output lines.

For a 2-bit decoder:

$$
N_{out}=2^2=4
$$

Therefore:

```text
2 input bits → 4 possible output combinations
```

The decoder generates a one-hot style output where one output corresponds to the selected binary input condition.

### Basic Mapping

```text
A B
│ │
│ └────── Select Bit
└──────── Select Bit
     │
     ▼
  2-to-4
  Decoder
     │
     ├── Y0
     ├── Y1
     ├── Y2
     └── Y3
```

### Enable Concept

The enable signal controls whether the decoder is allowed to activate an output.

```text
             A
             B
             │
             ▼
       ┌─────────────┐
EN ───►│ 2-to-4       │
       │ Decoder      │
       └──────┬──────┘
              │
       ┌──────┼──────┬──────┐
       ▼      ▼      ▼      ▼
      Y0     Y1     Y2     Y3
```

---

## 5. Hardware Architecture

The design consists of two logical sections:

1. **2-to-4 decoder logic**
2. **Enable logic**

### Conceptual Architecture

```text
                 A
                 │
                 ├──────────────┐
                 │              │
                 │           Inverter
                 │              │
                 │              ▼
                 │             A'
                 │
                 B
                 │
                 ▼
          ┌───────────────┐
          │ 2-to-4        │
          │ Decoder Logic │
          └───────┬───────┘
                  │
          ┌───────┼────────┬───────┐
          ▼       ▼        ▼       ▼
         R0      R1       R2      R3
          │       │        │       │
          ▼       ▼        ▼       ▼
        Enable  Enable   Enable  Enable
         Logic   Logic    Logic   Logic
          │       │        │       │
          ▼       ▼        ▼       ▼
         Y0      Y1       Y2      Y3
```

### Logical Hierarchy

```text
decoder_2to4_top
│
└── DECODER_TOP : decoder_2to4_enable
    │
    ├── DECODER : decoder_2to4
    │   ├── AND0
    │   ├── AND1
    │   ├── AND2
    │   └── AND3
    │
    ├── E0 : enable_logic
    │   └── AND_EN
    │
    ├── E1 : enable_logic_17
    │   └── AND_EN
    │
    ├── E2 : enable_logic_16
    │   └── AND_EN
    │
    └── E3 : enable_logic_15
        └── AND_EN
```

The supplied Genus hierarchy report shows the decoder and four separate enable-logic branches.

---

## 6. Boolean Function

For the decoder section, the four output conditions are represented by the corresponding input minterms.

Conceptually:

$$
D_0=\overline{A}\overline{B}
$$

$$
D_1=\overline{A}B
$$

$$
D_2=A\overline{B}
$$

$$
D_3=AB
$$

The enable logic then controls the corresponding decoder outputs.

Conceptually:

$$
Y_0=EN\cdot D_0
$$

$$
Y_1=EN\cdot D_1
$$

$$
Y_2=EN\cdot D_2
$$

$$
Y_3=EN\cdot D_3
$$

The exact active polarity of enable must follow the supplied RTL/testbench implementation.

---

## 7. Functional Specification

### Inputs

| Signal | Width | Description            |
| ------ | ----: | ---------------------- |
| `A`    |     1 | Decoder input bit      |
| `B`    |     1 | Decoder input bit      |
| `EN`   |     1 | Decoder enable control |

### Outputs

| Signal | Width | Description      |
| ------ | ----: | ---------------- |
| `Y0`   |     1 | Decoder output 0 |
| `Y1`   |     1 | Decoder output 1 |
| `Y2`   |     1 | Decoder output 2 |
| `Y3`   |     1 | Decoder output 3 |

### Internal Signals Observed During Simulation

The supplied simulation probe list includes:

```text
A
B
EN

D0
D1
D2
D3

E0
E1
E2
E3

ENABLE_Y
NOT_A

R0
R1
R2
R3

T0
T1
T2
T3

AND_Y
```

The internal signals provide visibility into decoder, inversion, intermediate and enable logic during simulation.

---

## 8. Functional Truth Table

For the enabled decoder operation:

| `EN`    | `A B` | Active Decoder Output |
| ------- | ----- | --------------------- |
| Enabled | `00`  | `Y0`                  |
| Enabled | `01`  | `Y1`                  |
| Enabled | `10`  | `Y2`                  |
| Enabled | `11`  | `Y3`                  |

When enable is inactive, the corresponding decoder outputs are disabled according to the RTL implementation.

> The exact logic polarity of `EN` should be interpreted from the implemented RTL rather than assumed from a generic decoder convention.

---

## 9. RTL Design

The design is organized hierarchically into:

```text
2-to-4 Decoder
       +
Enable Logic
       ↓
2-to-4 Decoder with Enable
```

### RTL Hardware Structure

```text
A,B
 │
 ▼
Decoder Logic
 │
 ├── D0
 ├── D1
 ├── D2
 └── D3
      │
      ▼
Enable Logic
 │
 ├── Y0
 ├── Y1
 ├── Y2
 └── Y3
```

### RTL Source

```text
rtl/
```

The repository should contain the actual Day-3 Verilog source used for the supplied simulation and Genus synthesis.

> The README intentionally does not reproduce an unverified RTL implementation. The repository source should remain the authoritative RTL.

---

## 10. RTL-to-Hardware Mapping

The supplied Cadence Genus technology-mapped report contains:

| Standard Cell | Instances |        Area | Library  |
| ------------- | --------: | ----------: | -------- |
| `AND2X1`      |         8 |     106.445 | `tsmc18` |
| `INVXL`       |         2 |      13.306 | `tsmc18` |
| **Total**     |    **10** | **119.750** |          |

Therefore, the synthesized implementation contains:

```text
8 × AND2X1
2 × INVXL
----------------
10 total leaf cells
```

### Hardware Interpretation

The decoder is synthesized entirely from combinational standard cells:

```text
Input Logic
    ↓
2 × Inverters
    ↓
AND-based Decoder Logic
    ↓
Enable AND Logic
    ↓
Y0–Y3
```

No sequential elements were synthesized.

---

## 11. Verification

The supplied simulation demonstrates multiple levels of verification.

### Verification Sections

```text
1. Basic Gate Verification
2. 2-to-4 Decoder Verification
3. Enable Verification
4. Decoder with Enable
5. Gate-Level vs RTL
6. Top Module Verification
```

The testbench is executed using Cadence NC-Sim.

### Verification Flow

```text
Apply Inputs
     ↓
Generate Decoder Outputs
     ↓
Check Expected Result
     ↓
Compare RTL / Gate-Level
     ↓
Check Top Module
     ↓
PASS / FAIL
```

---

## 12. Verification Results

The supplied simulator output reports:

```text
DAY 3 : 2-to-4 DECODER VERIFICATION

---- 1. BASIC GATE VERIFICATION ----
GATE TEST 00 : PASS
GATE TEST 01 : PASS
GATE TEST 10 : PASS
GATE TEST 11 : PASS

---- 2. 2-to-4 DECODER ----
DECODER 00 : PASS
DECODER 01 : PASS
DECODER 10 : PASS
DECODER 11 : PASS

---- 3. ENABLE VERIFICATION ----
ENABLE OFF : PASS
ENABLE ON : PASS

---- 4. DECODER WITH ENABLE ----
ENABLE DECODER OFF : PASS
ENABLE DECODER 00 : PASS
ENABLE DECODER 01 : PASS
ENABLE DECODER 10 : PASS
ENABLE DECODER 11 : PASS

---- 5. GATE-LEVEL VS RTL ----
RTL/GATE 00 : PASS
RTL/GATE 01 : PASS
RTL/GATE 10 : PASS
RTL/GATE 11 : PASS

---- 6. TOP MODULE VERIFICATION ----
TOP 00 : PASS
TOP 01 : PASS
TOP 10 : PASS
TOP 11 : PASS
TOP ENABLE OFF : PASS
```

### Overall Result

```text
Total reported verification checks = 24
PASS = 24
FAIL = 0
```

Therefore:

> **24/24 supplied verification checks passed.**

---

## 13. Simulation

The simulation was executed using Cadence NC-Sim.

### Waveform Database

```text
waves.shm
```

The simulation created an SHM waveform database:

```text
database -open waves -into waves.shm -default
```

### Probed Signals

The supplied simulation probes include:

```text
A
B
D0 D1 D2 D3
E0 E1 E2 E3
EN
ENABLE_Y
NOT_A
R0 R1 R2 R3
T0 T1 T2 T3
AND_Y
```

### Simulation Completion

The supplied simulator output reports:

```text
Simulation complete via $finish(1)
at time 240 NS
```

Therefore:

```text
Simulation completion time = 240 ns
```

---

## 14. Simulation Evidence

Recommended repository location:

```text
simulation/
├── waves.shm/
└── console_output.txt
```

Recommended image location:

```text
images/
├── rtl_waveform.png
├── verification_result.png
└── synthesis_hierarchy.png
```

Only actual generated waveform and simulator screenshots should be uploaded.

> Do not fabricate waveform images or simulation screenshots.

---

## 15. Synthesis Flow

The design was synthesized using Cadence Genus.

```text
Verilog RTL
     ↓
Elaboration
     ↓
Logic Synthesis
     ↓
Technology Mapping
     ↓
Standard-Cell Netlist
     ↓
Area / Timing / Power Analysis
```

### Cadence Genus Configuration

| Parameter           | Actual Value           |
| ------------------- | ---------------------- |
| Tool                | Cadence Genus          |
| Version             | 21.14-s082_1           |
| Top Module          | `decoder_2to4_top`     |
| Technology Library  | `tsmc18`               |
| Operating Condition | `slow (balanced_tree)` |
| Wireload Mode       | `enclosed`             |
| Area Mode           | `timing library`       |
| Report Date         | Sep 27, 2026           |

---

## 16. Area

The supplied Genus area report gives:

| Metric                       |      Result |
| ---------------------------- | ----------: |
| Leaf instance count          |      **10** |
| Physical instance count      |       **0** |
| Sequential instance count    |       **0** |
| Combinational instance count |      **10** |
| Cell area                    | **119.750** |
| Physical cell area           |   **0.000** |
| Net area                     |   **0.000** |
| Total area                   | **119.750** |

The reported area is in the library/tool area units provided by Genus.

No unsupported conversion to `µm²` is made.

### Area Hierarchy

| Hierarchy          | Cell Count |        Area |
| ------------------ | ---------: | ----------: |
| `decoder_2to4_top` |         10 | **119.750** |
| `DECODER_TOP`      |         10 | **119.750** |
| `DECODER`          |          6 |  **66.528** |
| `E0`               |          1 |  **13.306** |
| `E1`               |          1 |  **13.306** |
| `E2`               |          1 |  **13.306** |
| `E3`               |          1 |  **13.306** |

---

## 17. Cell Area Breakdown

Cadence Genus reported the following technology-mapped cells:

| Cell      | Instances |        Area | Library  |
| --------- | --------: | ----------: | -------- |
| `AND2X1`  |         8 |     106.445 | `tsmc18` |
| `INVXL`   |         2 |      13.306 | `tsmc18` |
| **Total** |    **10** | **119.750** |          |

### Area Distribution

| Cell Type      | Instances |        Area |   Area % |
| -------------- | --------: | ----------: | -------: |
| Logic / AND    |         8 |     106.445 |    88.9% |
| Inverter       |         2 |      13.306 |    11.1% |
| Physical cells |         0 |       0.000 |     0.0% |
| **Total**      |    **10** | **119.750** | **100%** |

### Synthesized Cell Structure

```text
8 × AND2X1
2 × INVXL
----------------
10 total leaf cells
```

The design contains no physical-only cells in the supplied report.

---

## 18. Hierarchy

The supplied Genus hierarchy report shows:

```text
decoder_2to4_top
│
└── DECODER_TOP
    │
    ├── DECODER
    │   ├── AND0
    │   ├── AND1
    │   ├── AND2
    │   └── AND3
    │
    ├── E0
    │   └── AND_EN
    │
    ├── E1
    │   └── AND_EN
    │
    ├── E2
    │   └── AND_EN
    │
    └── E3
        └── AND_EN
```

### Hierarchical Instance Count

```text
Leaf instances       : 10
Hierarchical instances: 14
```

The hierarchy report does not identify an unresolved blackbox.

---

## 19. Timing

The supplied Genus timing report contains a detailed input-to-output combinational path.

### Actual Timing Result

```text
Path 1: UNCONSTRAINED

Startpoint: A (Rising)
Endpoint:   Y0 (Falling)

Data Path: 412 ps
```

Therefore:

$$
T_{path}=412\ ps
$$

$$
\boxed{T_{path}=0.412\ ns}
$$

### Timing Path

```text
A
 ↓
INVXL
 ↓
AND2X1
 ↓
AND2X1
 ↓
Y0
```

### Path Breakdown

| Timing Point                     | Cell     |  Delay |    Arrival |
| -------------------------------- | -------- | -----: | ---------: |
| `A`                              | Input    |   0 ps |       0 ps |
| `DECODER_TOP/DECODER/g3/Y`       | `INVXL`  |  41 ps |      41 ps |
| `DECODER_TOP/DECODER/AND0/.../Y` | `AND2X1` | 197 ps |     238 ps |
| `DECODER_TOP/E0/AND_EN/.../Y`    | `AND2X1` | 174 ps | **412 ps** |
| `Y0`                             | Output   |   0 ps | **412 ps** |

The path delay is:

$$
41+197+174=412\ ps
$$

Therefore:

$$
\boxed{412\ ps=0.412\ ns}
$$

### Timing Status

The path is explicitly reported as:

```text
UNCONSTRAINED
```

The summary report also states:

```text
No paths
TNS = 0.0
Violating Paths = 0
```

This must **not** be interpreted as timing closure.

The valid conclusion is:

> **The supplied Genus timing analysis reports an unconstrained A → Y0 combinational data-path delay of 412 ps (0.412 ns).**

### Timing Claims Not Made

This project does not claim:

* setup timing closure
* hold timing closure
* positive timing slack
* maximum operating frequency
* clock-period compliance
* timing constraint satisfaction

---

## 20. Fanout

The supplied Genus summary reports:

| Fanout Metric  |       Result |
| -------------- | -----------: |
| Maximum fanout | **4 (`EN`)** |
| Minimum fanout | **1 (`Y3`)** |
| Average fanout |      **1.7** |

### Interpretation

The enable signal has the highest reported fanout:

```text
EN
├── Enable Logic 0
├── Enable Logic 1
├── Enable Logic 2
└── Enable Logic 3
```

Therefore:

```text
Maximum fanout = 4
```

---

## 21. Power

The supplied Genus power report was generated for:

```text
Instance: /decoder_2to4_top
Power Unit: W
PDB Frame: /stim#0/frame#0
```

### Total Power

$$
P_{total}=3.03147\times10^{-6}W
$$

Therefore:

$$
\boxed{P_{total}=3.03147\ \mu W}
$$

### Power Breakdown

| Metric    |          Power | Percentage |
| --------- | -------------: | ---------: |
| Internal  |     2.07165 µW |     68.34% |
| Switching |    0.955282 µW |     31.51% |
| Leakage   |  0.00454195 µW |      0.15% |
| **Total** | **3.03147 µW** |   **100%** |

### Power by Category

The supplied report shows:

```text
Logic:
Leakage  = 4.54195e-09 W
Internal = 2.07165e-06 W
Switching = 9.55282e-07 W
Total    = 3.03147e-06 W
```

Memory, register, latch, clock, pad, and other listed categories report zero power in the supplied report.

### Power Observation

The reported power is specific to:

* the technology library
* operating condition
* stimulus frame
* synthesis configuration
* power-analysis configuration

No generalized power-efficiency conclusion is made from this single measurement.

---

## 22. PPA

PPA represents:

* **Power**
* **Performance**
* **Area**

### Day-3 Actual Results

| PPA Metric        |                  Actual Result |
| ----------------- | -----------------------------: |
| **Power**         |                 **3.03147 µW** |
| **Path Delay**    |                   **0.412 ns** |
| **Area**          | **119.750 library area units** |
| **Leaf Cells**    |                         **10** |
| **Timing Status** |              **UNCONSTRAINED** |

### Primary Results

```text
┌───────────────────────────────────┐
│       DAY 3 — PPA RESULTS         │
├───────────────────────────────────┤
│ Area   : 119.750                  │
│ Power  : 3.03147 µW               │
│ Delay  : 0.412 ns                 │
│ Cells  : 10                       │
│ Timing : UNCONSTRAINED            │
└───────────────────────────────────┘
```

These values correspond to the supplied Cadence Genus reports.

No unsupported comparison or optimization improvement is claimed.

---

## 23. Optimization Study

Possible future implementation comparisons include:

### Current Architecture

```text
2-to-4 Decoder
      +
Enable Logic
```

### Possible Alternative

A decoder can also be described behaviorally using:

```verilog
case
```

or equivalent combinational RTL.

After synthesis, alternative implementations can be compared using:

* cell count
* area
* logic depth
* timing
* power
* fanout
* synthesis complexity
* verification complexity

### Current Status

No optimization improvement is claimed because the supplied data represents the current implementation only.

---

## 24. Common Mistakes

### 1. Incorrect Input-to-Output Mapping

The four binary input combinations must correspond to the intended output lines:

```text
00 → Y0
01 → Y1
10 → Y2
11 → Y3
```

### 2. Incorrect Enable Logic

Enable polarity must match the actual RTL specification.

Do not assume active-high or active-low behavior without checking the implementation.

### 3. Missing Inversion

Decoder equations require complemented input terms where appropriate.

For example:

```text
A'
B'
```

must be generated correctly.

### 4. Multiple Active Outputs

For a standard one-hot decoder operation, an input combination should select the intended output rather than an unintended combination of outputs.

### 5. Incomplete Verification

Testing only one input combination does not establish complete functional behavior.

### 6. Confusing Simulation and Synthesis

Successful RTL simulation does not automatically establish:

* synthesized area
* timing
* power
* physical implementation

### 7. Misinterpreting Unconstrained Timing

```text
No timing violations
```

is not equivalent to:

```text
Timing closure achieved
```

when the path is unconstrained.

---

## 25. Verification Status

| Item                            | Status                      |
| ------------------------------- | --------------------------- |
| Specification                   | **Complete**                |
| Architecture                    | **Complete**                |
| RTL                             | **Complete**                |
| Testbench                       | **Complete**                |
| Basic gate verification         | **PASS**                    |
| Decoder verification            | **PASS**                    |
| Enable verification             | **PASS**                    |
| Decoder + enable                | **PASS**                    |
| RTL vs gate-level               | **PASS**                    |
| Top-module verification         | **PASS**                    |
| Total supplied checks           | **24**                      |
| PASS                            | **24**                      |
| FAIL                            | **0**                       |
| Waveform database               | **Available (`waves.shm`)** |
| Synthesis                       | **Complete**                |
| Hierarchy                       | **Complete**                |
| Area                            | **Complete**                |
| Cell mapping                    | **Complete**                |
| Timing                          | **Complete**                |
| Power                           | **Complete**                |
| PPA                             | **Complete**                |
| Formal verification             | **Not performed**           |
| UVM                             | **Not performed**           |
| Constrained-random verification | **Not performed**           |
| Functional coverage             | **Not performed**           |
| Timing closure                  | **Not claimed**             |
| Documentation                   | **Complete**                |

---

## 26. Limitations

This project intentionally does not include:

* parameterized decoder architecture
* SystemVerilog assertions
* constrained-random verification
* functional coverage
* UVM
* formal verification
* physical design
* placement
* CTS
* routing
* post-route timing
* post-route power

### Synthesis Analysis Limitations

The supplied Genus timing analysis is explicitly:

```text
UNCONSTRAINED
```

Therefore:

* no timing slack is reported
* no setup/hold analysis is claimed
* no maximum frequency is claimed
* no timing closure is claimed

### Area Limitation

The supplied Genus area report gives:

```text
119.750
```

as the total cell area.

The supplied report does not identify this value as `µm²`; therefore, it is retained as the reported **library/tool area unit**.

### Power Limitation

The power result corresponds to the supplied stimulus frame:

```text
/stim#0/frame#0
```

It should not be interpreted as a universal power value for every possible workload.

---

## 27. Future Work

1. Parameterized decoder design.
2. 3-to-8 decoder.
3. 4-to-16 decoder.
4. Decoder-based address selection.
5. Behavioral versus structural RTL comparison.
6. SystemVerilog assertions.
7. Functional coverage.
8. Constrained-random verification.
9. Formal verification.
10. Timing-constrained synthesis.
11. Physical implementation using Cadence Innovus.
12. Post-layout timing and PPA analysis.
13. Hierarchical decoder optimization.
14. Fanout optimization.
15. Decoder integration into a larger digital datapath.

---

## 28. Industry Connection

Decoders are fundamental combinational blocks used in:

* address decoding
* memory selection
* register selection
* instruction decoding
* control logic
* bus control
* chip-select generation
* datapath control
* processor architectures
* ASIC digital logic

### Skills Demonstrated

* Digital logic design
* Combinational RTL
* Verilog HDL
* Hierarchical RTL
* Decoder architecture
* Enable logic
* Directed verification
* Gate-level comparison
* NC-Sim simulation
* Cadence Genus synthesis
* Standard-cell mapping
* Area analysis
* Timing analysis
* Power analysis
* PPA documentation

### Relevant Industry Areas

* RTL Design
* ASIC Design
* FPGA Design
* Design Verification
* Digital VLSI
* SoC Design

---

## 29. GATE Relevance

Important concepts demonstrated by this project:

* Decoder truth tables
* Binary-to-one-hot conversion
* Boolean expressions
* Minterms
* Combinational circuits
* Enable-controlled logic
* Logic gates
* Propagation delay
* Fanout
* Logic implementation

### Decoder Size

For `n` input lines:

$$
N_{out}=2^n
$$

For this project:

$$
N_{out}=2^2=4
$$

Therefore:

```text
2 inputs → 4 decoder outputs
```

### Minterm Representation

```text
00 → m0
01 → m1
10 → m2
11 → m3
```

The decoder implements these input conditions using combinational logic.

---

## 30. Interview Questions

### Basic

**Q1. What is a decoder?**

A decoder is a combinational circuit that converts a binary input code into a corresponding output line or output pattern.

**Q2. How many outputs does a 2-to-4 decoder have?**

For two input bits:

$$
2^2=4
$$

Therefore, it has four outputs.

**Q3. What type of circuit is a decoder?**

A decoder is a combinational logic circuit.

---

### RTL

**Q4. What hardware does a 2-to-4 decoder RTL create?**

The supplied synthesis result shows a combinational standard-cell implementation containing:

```text
8 × AND2X1
2 × INVXL
```

for a total of 10 leaf cells.

**Q5. Why are inverters required in a decoder?**

Complemented input terms are required for the decoder minterms, such as:

```text
A'
B'
```

**Q6. Why is enable logic used?**

Enable logic allows the decoder outputs to be controlled collectively by an additional control signal.

---

### Verification

**Q7. How many basic decoder input combinations exist?**

Four:

```text
00
01
10
11
```

**Q8. How many verification checks passed in this project?**

The supplied simulation reports:

```text
24 PASS
0 FAIL
```

**Q9. What is the purpose of gate-level versus RTL verification?**

It checks whether the synthesized gate-level implementation maintains the expected functional behavior of the RTL.

---

### Timing

**Q10. What is the reported Day-3 timing-path delay?**

The supplied timing report gives:

$$
412\ ps=0.412\ ns
$$

for:

```text
A → Y0
```

**Q11. Is this timing path constrained?**

No.

The report explicitly identifies it as:

```text
UNCONSTRAINED
```

**Q12. Can 0.412 ns be used directly to claim a maximum clock frequency?**

No. The supplied path is unconstrained and this is a combinational input-to-output delay, not a complete clock-period timing analysis.

---

### Synthesis / PPA

**Q13. What is the synthesized area?**

```text
119.750 library area units
```

**Q14. What is the reported total power?**

```text
3.03147 µW
```

**Q15. What standard cells were used?**

```text
8 × AND2X1
2 × INVXL
```

**Q16. What is the maximum reported fanout?**

```text
4 on EN
```

---

### Advanced

**Q17. How would you optimize a decoder with high fanout?**

Possible approaches include examining enable distribution, logic architecture, buffering, hierarchy and synthesis constraints, followed by measurement of area, timing and power.

**Q18. How would you compare two decoder RTL implementations?**

Use the same technology library and analysis configuration, then compare:

```text
Cell Count
Area
Timing
Power
Fanout
Logic Depth
Verification Complexity
```

---

## 31. Tiny Memory

```text
2-to-4 Decoder
│
├── 2 Inputs
├── 4 Outputs
└── Combinational Logic
```

```text
00 → Y0
01 → Y1
10 → Y2
11 → Y3
```

### Core Relation

$$
2^n=\text{number of decoder outputs}
$$

For this project:

$$
2^2=4
$$

### Day-3 Measured Results

```text
Area  = 119.750 library area units
Power = 3.03147 µW
Delay = 0.412 ns
Cells = 10
Checks = 24/24 PASS
Timing = UNCONSTRAINED
```

**Important:** Functional verification and PPA analysis are separate engineering activities.

---

## 32. Repository Structure

```text
Day-3/
│
├── README.md
│
├── rtl/
│   └── day3_design.v
│
├── tb/
│   └── day3_tb.v
│
├── simulation/
│   ├── console_output.txt
│   └── waves.shm/
│
├── reports/
│   ├── area_report.txt
│   ├── cell_area_report.txt
│   ├── hierarchy_report.txt
│   ├── power_report.txt
│   ├── timing_summary.txt
│   └── timing_path_report.txt
│
├── images/
│   ├── rtl_waveform.png
│   ├── verification_result.png
│   └── synthesis_hierarchy.png
│
└── docs/
    └── project_report.pdf
```


## 34. Project Status

```text
Specification             ✓ COMPLETE
Architecture              ✓ COMPLETE
RTL                       ✓ COMPLETE
Testbench                 ✓ COMPLETE
Simulation                ✓ COMPLETE
Basic Gate Verification   ✓ PASS
Decoder Verification      ✓ PASS
Enable Verification       ✓ PASS
Decoder + Enable          ✓ PASS
RTL vs Gate-Level         ✓ PASS
Top Module Verification   ✓ PASS
Waveform Database         ✓ AVAILABLE
Synthesis                 ✓ COMPLETE
Hierarchy                 ✓ COMPLETE
Area                      ✓ COMPLETE
Cell Mapping              ✓ COMPLETE
Timing                    ✓ COMPLETE
Power                     ✓ COMPLETE
PPA                       ✓ COMPLETE
Documentation             ✓ COMPLETE
```

### Final Day-3 Results

```text
Design       : 2-to-4 Decoder with Enable
Top Module   : decoder_2to4_top
Technology   : tsmc18
Cells        : 10
Area         : 119.750 library area units
Power        : 3.03147 µW
Delay        : 0.412 ns
Fanout       : 4 maximum
Verification : 24/24 PASS
Timing       : UNCONSTRAINED
Status       : COMPLETE
```

---

## 35. Learning Outcome

```text
Decoder Concept
      ↓
Truth Table
      ↓
Boolean Logic
      ↓
Architecture
      ↓
Hierarchical RTL
      ↓
Testbench
      ↓
Simulation
      ↓
Functional Verification
      ↓
RTL vs Gate-Level Verification
      ↓
Cadence Genus Synthesis
      ↓
Standard-Cell Mapping
      ↓
Hierarchy Analysis
      ↓
Area / Timing / Power
      ↓
PPA Analysis
      ↓
GitHub Documentation
      ↓
Interview Preparation
```

### Key Engineering Question

> **What hardware does this RTL create?**

### Answer

> The supplied RTL synthesizes into a combinational decoder implementation mapped to 8 `AND2X1` cells and 2 `INVXL` cells, with a reported total cell area of 119.750 library area units.

---

# Author

**Omkar Kalmesh Hadapad**

B.E. Electronics & Communication Engineering
SDM Institute of Technology, Ujire, Karnataka

### Focus

* Digital VLSI
* RTL Design
* Verilog / SystemVerilog
* ASIC Design
* Design Verification
* Physical Design Awareness

---

## Evidence Rule

Only upload evidence actually generated from the RTL, simulation, and synthesis flow.

**Do not fabricate screenshots, simulation results, PPA values, timing closure, or verification claims.**

All Day-3 synthesis values documented above correspond to the supplied Cadence Genus reports for:

```text
decoder_2to4_top
```

All verification values correspond to the supplied Cadence NC-Sim output.

---

## Training Flow

```text
Specification
     ↓
Architecture
     ↓
RTL
     ↓
Testbench
     ↓
Simulation
     ↓
Verification
     ↓
Debug
     ↓
Synthesis
     ↓
Timing
     ↓
PPA
     ↓
Optimization
     ↓
Documentation
     ↓
GitHub
     ↓
Interview
```

---

# Day 3 Complete

**2-to-4 Decoder with Enable — RTL → Simulation → Verification → Genus Synthesis → Timing → PPA → Documentation**

### Final Measured Results

```text
Area         : 119.750 library area units
Power        : 3.03147 µW
Delay        : 0.412 ns
Cells        : 10
Verification : 24/24 PASS
Timing       : UNCONSTRAINED
```

---

# Day 4 — Next Project

## 8-to-3 Priority Encoder

### Concept Preview

The next project introduces a **priority encoder**, a combinational circuit that converts multiple input conditions into a binary encoded output while assigning priority when multiple inputs are active.

```text
I[7:0]
  │
  ▼
┌─────────────────────┐
│  8-to-3 Priority    │
│      Encoder        │
└──────────┬──────────┘
           │
           ▼
        Y[2:0]
```

### Core Concept

```text
Multiple Active Inputs
          ↓
   Priority Evaluation
          ↓
Highest-Priority Input
          ↓
    Binary Encoding
          ↓
       Y[2:0]
```

### Day 4 Learning Focus

```text
Priority Logic
     ↓
Truth Table
     ↓
Priority Encoder Architecture
     ↓
Combinational Verilog
     ↓
Priority Verification
     ↓
Simulation
     ↓
Synthesis
     ↓
Timing / Area / Power
     ↓
PPA Analysis
```

### Key Engineering Question for Day 4

> **What happens when more than one input of a priority encoder is active at the same time?**

This will be the central concept of the Day-4 project.

---

# End of Day 3

**Day 3: 2-to-4 Decoder with Enable — COMPLETE**

**Next: Day 4 — 8-to-3 Priority Encoder**
