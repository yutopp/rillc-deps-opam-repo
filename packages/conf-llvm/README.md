These files are based on [https://github.com/ocaml/opam-repository/tree/master/packages/conf-llvm](https://github.com/ocaml/opam-repository/tree/master/packages/conf-llvm).

```
pkg_repo_url='https://raw.githubusercontent.com/ocaml/opam-repository/master/packages'
base_url="$pkg_repo_url/conf-llvm/conf-llvm.10.0.0"

#
cd conf-llvm.11.0.0+rillc
wget "$base_url/opam"

#
cd files
for f in 'configure.sh'; do
    wget "$base_url/files/$f" -O $f
done
```
