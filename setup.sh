#!/bin/bash

# supported compilers
declare -Ar COMPILERS=(
	['alpha']='gcc-alpha-linux-gnu'
	['amd64']='gcc-x86-64-linux-gnu'
	['arc']='gcc-arc-linux-gnu'
	['arm64']='gcc-aarch64-linux-gnu aarch64-linux-gnu-gcc'
	['armel']='gcc-arm-linux-gnueabi'
	['armhf']='gcc-arm-linux-gnueabihf'
	['hppa64']='gcc-hppa64-linux-gnu'
	['hppa']='gcc-hppa-linux-gnu'
	['i386']='gcc-i686-linux-gnu'
	['loong64']='gcc-loongarch64-linux-gnu'
	['m68k']='gcc-m68k-linux-gnu'
	['mips64']='gcc-mips64-linux-gnuabi64'
	['mips64el']='gcc-mips64el-linux-gnuabi64'
	['mips64r6']='gcc-mipsisa64r6-linux-gnuabi64'
	['mips64r6el']='gcc-mipsisa64r6el-linux-gnuabi64'
	['mips']='gcc-mips-linux-gnu'
	['mipsel']='gcc-mipsel-linux-gnu'
	['mipsr6']='gcc-mipsisa32r6-linux-gnu'
	['mipsr6el']='gcc-mipsisa32r6el-linux-gnu'
	['powerpc']='gcc-powerpc-linux-gnu'
	['ppc64']='gcc-powerpc64-linux-gnu'
	['ppc64el']='gcc-powerpc64le-linux-gnu'
	['riscv64']='gcc-riscv64-linux-gnu'
	['s390x']='gcc-s390x-linux-gnu'
	['sh4']='gcc-sh4-linux-gnu'
	['sparc64']='gcc-sparc64-linux-gnu'
	['x32']='gcc-x86-64-linux-gnux32'
)
declare -Ar COMMANDS=(
	['alpha']='alpha-linux-gnu-gcc'
	['amd64']='x86_64-linux-gnu-gcc'
	['arc']='arc-linux-gnu-gcc'
	['arm64']='aarch64-linux-gnu-gcc'
	['armel']='arm-linux-gnueabi-gcc'
	['armhf']='arm-linux-gnueabihf-gcc'
	['hppa64']='hppa64-linux-gnu-gcc'
	['hppa']='hppa-linux-gnu-gcc'
	['i386']='i686-linux-gnu-gcc'
	['loong64']='loongarch64-linux-gnu-gcc'
	['m68k']='m68k-linux-gnu-gcc'
	['mips64']='mips64-linux-gnuabi64-gcc'
	['mips64el']='mips64el-linux-gnuabi64-gcc'
	['mips64r6']='mipsisa64r6-linux-gnuabi64-gcc'
	['mips64r6el']='mipsisa64r6el-linux-gnuabi64-gcc'
	['mips']='mips-linux-gnu-gcc'
	['mipsel']='mipsel-linux-gnu-gcc'
	['mipsr6']='mipsisa32r6-linux-gnu-gcc'
	['mipsr6el']='mipsisa32r6el-linux-gnu-gcc'
	['powerpc']='powerpc-linux-gnu-gcc'
	['ppc64']='powerpc64-linux-gnu-gcc'
	['ppc64el']='powerpc64le-linux-gnu-gcc'
	['riscv64']='riscv64-linux-gnu-gcc'
	['s390x']='s390x-linux-gnu-gcc'
	['sh4']='sh4-linux-gnu-gcc'
	['sparc64']='sparc64-linux-gnu-gcc'
	['x32']='x86_64-linux-gnux32-gcc'
)

# default compile options
readonly GCC_OPTS='-g -O0 -c -fverbose-asm -fno-asynchronous-unwind-tables -fno-stack-protector -fno-stack-clash-protection -fcf-protection=none'

# default output directory
readonly OUTPUT='output'

# default assembly syntax
syntax='-Mintel'
all=0

# list of architectures to build for
declare -a archs=()

# usage instructions
function usage {
	echo "Usage: $0 [<opts>] [<arch1> [<arch2> [<...]]]
Options:
    -f,--full: build for all architectures (default is host or specified).
    -l,--list: print the list of cross-compilers to install (all).
    -a,--atnt: dump the assembly using AT&T syntax (default is Intel).
    -p,--pack: pack the built rosetta stone.
    -h,--help: display the help."
}

# display the list of packages to install
function list {
	declare -a l
	local c
	for c in "${!COMPILERS[@]}"; do
		l+=("${COMPILERS[$c]}")
	done

	# print the list
	echo "${l[@]}"
}

# make the stone for a list of architectures
function dist {
	local c
	local cmd
	local tmp
	local rv=0

	# create the destination directory
	mkdir $OUTPUT &> /dev/null

	for c in "$@"; do
		# check if the architecture is supported
		if [ -z "${COMMANDS[$c]+a}" ]; then
			echo "unsupported architecture $c!" 1>&2; continue
		fi

		cmd="${COMMANDS[$c]}"
		tmp=$(mktemp -u)

		# check if the package is installed
		if ! command -v $cmd &> /dev/null; then
			echo "command not found $cmd, install ${COMPILERS[$c]}!" 1>&2
			rv=2; continue
		fi

		# build a temporary object file
		$cmd $GCC_OPTS -o "$tmp" rosetta.c > /dev/null || { echo "compilation failed for architecture $c!" 1>&2; rv=2; continue; }

		# dump the assembly using the given syntax
		objdump -drwC $syntax -S "$tmp" > "$OUTPUT/asm-rosetta-$c" || { echo "dumping failed for architecture $c!" 1>&2; rv=3; continue; }

		echo "successful build for architecture $c!"
	done
	return $rv
}

# make the stone for host architecture
function self {
	# create the destination directory
	mkdir $OUTPUT &> /dev/null

	# build a temporary object file
	local tmp=$(mktemp -u)
	gcc $GCC_OPTS -o "$tmp" rosetta.c > /dev/null || { echo 'compilation failed!' 1>&2; return 2; }

	# dump the assembly using the given syntax
	objdump -drwC $syntax -S "$tmp" > "$OUTPUT/asm-rosetta-self" || { echo 'dumping failed!' 1>&2; return 3; }

	echo 'successful build for host architecture!'
}

# create a distribution archive of all the artifacts
function pack {
	tar -H gnu --gzip -cf "asm-rosetta-$(date '+%d-%m-%Y-%H-%M-%S').tar.gz" "$OUTPUT/asm-rosetta-*"
	return $?
}

# parse options
while [ $# -gt 0 ]; do
	case $1 in
		-p|--p*)
			pack
			exit $?
			;;
		-a|--a*)
			syntax='-Matt'
			shift
			;;
		-f|--f*)
			all=1
			shift
			;;
		-l|--l*|--i*)
			list
			exit 0
			;;
		'-?'|-h|--h*)
			usage
			exit 0
			;;
		-*|--*)
			echo "unknown option $1" 1>&2
			usage
			exit 1
			;;
		*)
			archs+=("$1")
			shift
			;;
	esac
done

# compile either for the specified architectures or for all of them
if [ $all -eq 1 ]; then
	dist "${!COMMANDS[@]}"
else
	# if no architecture is specified, build for host
	if [ ${#archs[@]} -eq 0 ]; then
		self
	else
		dist "${archs[@]}"
	fi
fi
