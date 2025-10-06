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

| Name         | Package Needed                     | Command                            |
| ------------ | ---------------------------------- | ---------------------------------- |
| `amd64`      | `gcc-x86-64-linux-gnu`             | `x86_64-linux-gnu-gcc`             |
| `alpha`      | `gcc-alpha-linux-gnu`              | `alpha-linux-gnu-gcc`              |
| `arc`        | `gcc-arc-linux-gnu`                | `arc-linux-gnu-gcc`                |
| `arm64`      | `gcc-aarch64-linux-gnu`            | `aarch64-linux-gnu-gcc`            |
| `armel`      | `gcc-arm-linux-gnueabi`            | `arm-linux-gnueabi-gcc`            |
| `armhf`      | `gcc-arm-linux-gnueabihf`          | `arm-linux-gnueabihf-gcc`          |
| `hppa64`     | `gcc-hppa64-linux-gnu`             | `hppa64-linux-gnu-gcc`             |
| `hppa`       | `gcc-hppa-linux-gnu`               | `hppa-linux-gnu-gcc`               |
| `i386`       | `gcc-i686-linux-gnu`               | `i686-linux-gnu-gcc`               |
| `loong64`    | `gcc-loongarch64-linux-gnu`        | `loongarch64-linux-gnu-gcc`        |
| `m68k`       | `gcc-m68k-linux-gnu`               | `m68k-linux-gnu-gcc`               |
| `mips64`     | `gcc-mips64-linux-gnuabi64`        | `mips64-linux-gnuabi64-gcc`        |
| `mips64el`   | `gcc-mips64el-linux-gnuabi64`      | `mips64el-linux-gnuabi64-gcc`      |
| `mips64r6`   | `gcc-mipsisa64r6-linux-gnuabi64`   | `mipsisa64r6-linux-gnuabi64-gcc`   |
| `mips64r6el` | `gcc-mipsisa64r6el-linux-gnuabi64` | `mipsisa64r6el-linux-gnuabi64-gcc` |
| `mips`       | `gcc-mips-linux-gnu`               | `mips-linux-gnu-gcc`               |
| `mipsel`     | `gcc-mipsel-linux-gnu`             | `mipsel-linux-gnu-gcc`             |
| `mipsr6`     | `gcc-mipsisa32r6-linux-gnu`        | `mipsisa32r6-linux-gnu-gcc`        |
| `mipsr6el`   | `gcc-mipsisa32r6el-linux-gnu`      | `mipsisa32r6el-linux-gnu-gcc`      |
| `powerpc`    | `gcc-powerpc-linux-gnu`            | `powerpc-linux-gnu-gcc`            |
| `ppc64`      | `gcc-powerpc64-linux-gnu`          | `powerpc64-linux-gnu-gcc`          |
| `ppc64el`    | `gcc-powerpc64le-linux-gnu`        | `powerpc64le-linux-gnu-gcc`        |
| `riscv64`    | `gcc-riscv64-linux-gnu`            | `riscv64-linux-gnu-gcc`            |
| `s390x`      | `gcc-s390x-linux-gnu`              | `s390x-linux-gnu-gcc`              |
| `sh4`        | `gcc-sh4-linux-gnu`                | `sh4-linux-gnu-gcc`                |
| `sparc64`    | `gcc-sparc64-linux-gnu`            | `sparc64-linux-gnu-gcc`            |
| `x32`        | `gcc-x86-64-linux-gnux32`          | `x86_64-linux-gnux32-gcc`          |

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
