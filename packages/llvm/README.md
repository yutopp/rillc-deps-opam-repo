These files are based on [https://github.com/ocaml/opam-repository/tree/master/packages/llvm](https://github.com/ocaml/opam-repository/tree/master/packages/llvm).

A difference between this repository and the original repository is that a linking option is modified to provide objects for only static build.

```
#
pkg_repo_url='https://raw.githubusercontent.com/ocaml/opam-repository/master/packages'
base_url="$pkg_repo_url/llvm/llvm.10.0.0"

cd llvm.10.0.0+rillc
wget "base_url/opam"

#
cd files
for f in 'META.patch' 'fix-shared.patch' 'install.sh' 'link-META.patch'; do
    wget "$base_url/files/$f" -O $f
done
```

```
cat files/install.sh | md5sum
cat files/META.patch | md5sum
```
