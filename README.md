# 2D-Gabor-Filter

This project implements a Gabor filter for fingerprint image enhancement using Verilog HDL on an FPGA-based architecture. The design focuses on real-time convolution for fingerprint texture segmentation, improving ridge–valley clarity for biometric recognition systems.

Design:

Uses a memory-based convolution architecture,
implements a 3×3 Gabor kernel,
performs floating-point convolution using IEEE-754 single precision,
is fully described in Verilog HDL

What should be the outcome:

Implement a digital Gabor filter for fingerprint texture segmentation,
design a real-time convolution architecture using FPGA,
enhance fingerprint ridge and valley structures

System Architecture:

The top-level design consists of three main modules:

1️. Control Logic Unit (CLU)

Controls the convolution sequence,
Generates memory and kernel addresses,
Uses multiple counters for pixel and kernel traversal,
Switches between write mode (image input) and convolution mode

2️. Memory Unit (MEMORY)

Stores the input fingerprint image (16×16 pixels),
Each pixel is stored as a 32-bit floating-point value,
Supports read/write operations controlled by CLU,

3️. Arithmetic Logic Unit (ALU)

Performs the convolution operation

Contains:

ROM for Gabor coefficients

9 parallel multipliers

Adder tree for accumulation

Produces the filtered pixel output

- Gabor Filter Details
- Gabor Filter Characteristics
- Spatial localization
- Orientation selectivity
- Frequency selectivity

These properties make Gabor filters ideal for fingerprint texture extraction.

Filter Parameters Used
Parameter	Value
Frequency (ƒ)	: 1/3
Orientation (θ)	: 45°
σx	: 0.5
σy	: 0.5
3×3 Gabor Kernel

[ 0.006737943   1.29E-05     -4.0E-08  ]

[ 2.35672E-07  4.14E-08     1.45E-12  ]

[ -1.36E-11    2.65E-14     8.53E-17  ]

Convolution Methodology

Input image is stored pixel-by-pixel in memory,
A sliding 3×3 window is applied,

Each output pixel is computed as:

Output = Σ (Pixel × Kernel Coefficient)


Convolution is performed sequentially across the image

Parallel multipliers significantly reduce computation time
