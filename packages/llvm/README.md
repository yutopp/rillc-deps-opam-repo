These files are based on [https://github.com/ocaml/opam-repository/tree/master/packages/llvm](https://github.com/ocaml/opam-repository/tree/master/packages/llvm).

```
#
cd llvm.10.0.0+rillc
wget https://raw.githubusercontent.com/ocaml/opam-repository/master/packages/llvm/llvm.10.0.0/opam

#
cd files
for f in 'META.patch' 'fix-shared.patch' 'install.sh' 'link-META.patch'; do
    wget "https://raw.githubusercontent.com/ocaml/opam-repository/master/packages/llvm/llvm.10.0.0/files/$f" -O $f
done
```
