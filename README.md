# The ASM Rosetta Stone
This respository contains the ASM Rosetta Stone, a small snippet of C
that you can use to learn a new assembly variant in a short amount of 
time.

## Getting Started
To get started with studying assembly languages using Rosetta Stone, follow these steps:

1. **Clone the repository**: Open a terminal and run the following command to clone the repository to your local machine:

```
git clone --depth=1 https://github.com/RubisetCie/asm-rosetta-stone.git
```

2. **Build for host architecture**: Use the setup script to build the ASM Rosetta Stone into your host architecture. Run the following command:

```
./setup.sh
```

You'll then find the result in the `output` sub-directory.

## All Architectures
To distribute the ASM Rosetta Stone for all available architectures, follow these steps:

> [!NOTE]
> The list of cross-compiler needed are based on the official Debian package repository. They may not all be distributed for any other distro!

1. **Install necessary packages**: Install the necessary packages on your system by running the following command:

```
sudo apt-get install $(./setup.sh -l)
```

2. **Build for every architecture**: You can use the setup script to build the ASM Rosetta Stone for every architecture. Run the following command:

```
./setup.sh -f
```
Alternatively, you can compile the code for individual architectures using their respective target names:
```
./setup.sh arm64 powerpc mips (...)
```
You may find below a list of [currently supported architectures](##supported-architectures).

3. **Put into an archive**: The setup script can automate packing all of the outputs into a TAR archive. Run the following command:

```
./setup.sh -p
```

## Supported Architectures
Here is the list of architectures supported by the setup script:

| Name         | Package Needed                     |
| ------------ | ---------------------------------- |
| `alpha`      | `gcc-alpha-linux-gnu`              |
| `amd64`      | `gcc-x86-64-linux-gnu`             |
| `arc`        | `gcc-arc-linux-gnu`                |
| `arm64`      | `gcc-aarch64-linux-gnu`            |
| `armel`      | `gcc-arm-linux-gnueabi`            |
| `armhf`      | `gcc-arm-linux-gnueabihf`          |
| `hppa64`     | `gcc-hppa64-linux-gnu`             |
| `hppa`       | `gcc-hppa-linux-gnu`               |
| `i386`       | `gcc-i686-linux-gnu`               |
| `loong64`    | `gcc-loongarch64-linux-gnu`        |
| `m68k`       | `gcc-m68k-linux-gnu`               |
| `mips64`     | `gcc-mips64-linux-gnuabi64`        |
| `mips64el`   | `gcc-mips64el-linux-gnuabi64`      |
| `mips64r6`   | `gcc-mipsisa64r6-linux-gnuabi64`   |
| `mips64r6el` | `gcc-mipsisa64r6el-linux-gnuabi64` |
| `mips`       | `gcc-mips-linux-gnu`               |
| `mipsel`     | `gcc-mipsel-linux-gnu`             |
| `mipsr6`     | `gcc-mipsisa32r6-linux-gnu`        |
| `mipsr6el`   | `gcc-mipsisa32r6el-linux-gnu`      |
| `powerpc`    | `gcc-powerpc-linux-gnu`            |
| `ppc64`      | `gcc-powerpc64-linux-gnu`          |
| `ppc64el`    | `gcc-powerpc64le-linux-gnu`        |
| `riscv64`    | `gcc-riscv64-linux-gnu`            |
| `s390x`      | `gcc-s390x-linux-gnu`              |
| `sh4`        | `gcc-sh4-linux-gnu`                |
| `sparc64`    | `gcc-sparc64-linux-gnu`            |
| `x32`        | `gcc-x86-64-linux-gnux32`          |

## Checklist
- **Registers**
	- [ ] Names
	- [ ] Width
- **Stack Memory**
	- [ ] How is it used
	- [ ] Prologue, Epilogue
- **Calling Conventions**
	- [ ] Arguments
	- [ ] Return value
	- [ ] Return address
- **Control Flow**
	- [ ] Branching
	- [ ] Conditional Branches
	- [ ] Calls
- [ ] Syscall Interface
