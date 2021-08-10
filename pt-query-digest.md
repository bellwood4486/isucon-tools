# pt-query-digest

ツール
- https://www.percona.com/doc/percona-toolkit/3.0/pt-query-digest.html

# インストール
## Ubuntu
```shell
sudo apt-get install -y gnupg2
```

```shell
wget https://repo.percona.com/apt/percona-release_latest.$(lsb_release -sc)_all.deb
```

```shell
sudo dpkg -i percona-release_latest.$(lsb_release -sc)_all.deb
```

```shell
sudo apt-get update; sudo apt-get install -y percona-toolkit
```

バージョンの確認
```shell
pt-query-digest --version
```
