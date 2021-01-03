#!/bin/bash -ex

llvm_config="$1"
libdir="$2"
cmake="$3"
make="$4"

function llvm_targets() {
    "$llvm_config" --targets-built | sed 's/ /\n/g'
}

function remove_experimentals() {
    sed 's/^WebAssembly\|AVR\|Nios2//g' | xargs
}

function only_experimentals() {
    sed -n '/^WebAssembly\|AVR\|Nios2/p' | xargs
}

function llvm_install {
    mkdir build
    cd build

    local targets=`llvm_targets | remove_experimentals | sed 's/ /;/g'`
    local experimental_targets=`llvm_targets | only_experimentals | sed 's/ /;/g'`

    "$cmake" \
        -DCMAKE_BUILD_TYPE="`"$llvm_config" --build-mode`" \
        -DLLVM_TARGETS_TO_BUILD="$targets" \
        -DLLVM_EXPERIMENTAL_TARGETS_TO_BUILD="$experimental_targets" \
        -DLLVM_OCAML_EXTERNAL_LLVM_LIBDIR="`"$llvm_config" --libdir`" \
        -DBUILD_SHARED_LIBS=`[ $1 = "shared" ] && echo TRUE || echo FALSE` \
        -DLLVM_OCAML_OUT_OF_TREE=TRUE \
        -DLLVM_OCAML_INSTALL_PATH="${libdir}" \
        ..
    $make ocaml_all
    "$cmake" -P bindings/ocaml/cmake_install.cmake

    mkdir "${libdir}"/llvm/$1
    mv "${libdir}"/llvm/*.cma "${libdir}"/llvm/$1
    mv "${libdir}"/llvm/*.cmxa "${libdir}"/llvm/$1
    mv "${libdir}"/llvm/llvm*.a "${libdir}"/llvm/$1

    cd ..
    rm -rf build
}

if "$llvm_config" --link-static --libs; then
    sed "s,%%LINKAGE%%,static," link-META.patch | patch -p1
    llvm_install static
else
    echo "Cannot build llvm statically"
    exit 1
fi
