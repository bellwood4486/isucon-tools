# Tools for ISUCON

## How to use

```sh
$ cd
$ git clone git@github.com:bellwood4486/isucon-tools.git
```

以下を`.bashrc`に足す。
```
alias vim='~/isucon-tools/backup-and-edit.sh'
alias sudo='sudo -E '
```
aliasの末尾にスペースを含めると、それに続くコマンドにもalias等が引き継がれる([参考](https://yudoufu.hatenablog.jp/entry/20110326/1301129885))
