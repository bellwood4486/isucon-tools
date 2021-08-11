# ssh

## sshで鍵認証ログイン
【参考】 https://cameong.hatenablog.com/entry/2017/02/17/011429

```
❯ ssh xxx.xxx.xxx.xxx -l isucon -i ~/Downloads/isucon9q-key
```
※鍵はパーミッション`600`にしておくこと

`~/.ssh/config`に書く場合
```
host isu
  hostname xxx.xxx.xxx.xxx
  user isucon
  IdentityFile ~/Downloads/isucon9q-key
```
↓
```
$ ssh isu
```

## sshでGitHubからpullする

sshの鍵を標準から変えた場合は、以下のように~/.ssh/configに指定する必要あり。
https://qiita.com/shizuma/items/2b2f873a0034839e47ce
```
Host github github.com
  HostName github.com
  IdentityFile ~/.ssh/id_git_rsa #ここに自分の鍵のファイル名
  User git
```

## ポートフォワーディング
```shell
ssh ${user}@${server} -L ${local_posrt}:${target_server}:${target_port}
```
例(configに記載済みの場合)
```shell
ssh isu -L 53306:127.0.0.1:3306
```
