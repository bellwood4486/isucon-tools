# Tips

## sshで鍵認証ログイン
【参考】 https://cameong.hatenablog.com/entry/2017/02/17/011429

```
❯ ssh xxx.xxx.xxx.xxx -l isucon -i ~/Downloads/isucon9q-key
```
※鍵はパーミッション`600`にしておくこと

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

## アプリケーション・サーバーにcURLでPOSTを送る
```
curl -XPOST http://127.0.0.1:8000/initialize -H 'Content-Type: application/json' -d @overwriteip.json
```

## CPUを確認する
https://qiita.com/yoshi389111/items/a9026769a6c6a8786c90
```sh
#!/bin/bash

P_CPU=$( fgrep 'physical id' /proc/cpuinfo | sort -u | wc -l )
CORES=$( fgrep 'cpu cores' /proc/cpuinfo | sort -u | sed 's/.*: //' )
L_PRC=$( fgrep 'processor' /proc/cpuinfo | wc -l )
H_TRD=$(( L_PRC /  P_CPU / CORES ))

echo -n "${L_PRC} processer" ; [ "${L_PRC}" -ne 1 ] && echo -n "s"
echo -n " = ${P_CPU} socket" ; [ "${P_CPU}" -ne 1 ] && echo -n "s"
echo -n " x ${CORES} core"   ; [ "${CORES}" -ne 1 ] && echo -n "s"
echo -n " x ${H_TRD} thread" ; [ "${H_TRD}" -ne 1 ] && echo -n "s"
echo
```

## nginxの設定文法チェック
```
isucon@isucon9q:~$ sudo nginx -t
nginx: the configuration file /etc/nginx/nginx.conf syntax is ok
nginx: configuration file /etc/nginx/nginx.conf test is successful
```
コマンドラインオプションの説明。
https://www.nginx.com/resources/wiki/start/topics/tutorials/commandline/

`-t`の説明は以下
> Don’t run, just test the configuration file. NGINX checks configuration for correct syntax and then try to open files referred in configuration.

## マシンを再起動する
```
sudo reboot
```

## ポートを使っているプロセスを確認する
```
sudo lsof -i:80
```

## nginxの設定ファイル
nginxの設定ファイルは、Ubuntuにapt-getで入れた場合は、`/etc/nginx/nginx.conf`にあるはず。


## nginxの設定ファイルの見方
ポイント
- `access_log`を見ると、アクセスログの場所がわかる
- `upstream`、`server`を見ると、どのポートでリクエストを受けて、それをどこに流しているかがわかる。

例1：アクセスログを`/var/log`配下に設定している。
```
access_log /var/log/nginx/access.log;
```

例2：`80`で受けて、それを`8000`に流している。
```
    upstream app {
        server 127.0.0.1:8000;
    }

    server {
        listen 80;
        location / {
            proxy_pass http://app;
            proxy_set_header Host $host;
        }
    }
```

## PIDからそれがどの実行ファイルかを調べる
```
isucon@isucon9q:~/isucon9-qualify$ sudo lsof -i :8000
COMMAND  PID   USER   FD   TYPE DEVICE SIZE/OFF NODE NAME
isucari 1091 isucon    3u  IPv6  24044      0t0  TCP *:8000 (LISTEN)

isucon@isucon9q:~/isucon9-qualify$ ls -al /proc/1091/exe
lrwxrwxrwx 1 isucon isucon 0 Jul 10 23:11 /proc/1091/exe -> /home/isucon/isucon9-qualify/webapp/go/isucari
```

`/proc/{PID}`には実行プロセスのいろんな情報が入っている。[参考](https://linuc.org/study/knowledge/532/)

`exe`がシンボリックリンクになっているのでそれを見るとどの実行ファイルかがわかる。

## grepで一気に調べる

```
isucon@isucon9q:~$ grep "MYSQL_HOST=" -rn
```
- `-r`は、再帰的に調べていく。
- `-n`は、行番号も結果に出す

## mysqlの動作確認
標準入力を受け付けるので以下を実行
```sh
echo "select now();" | sudo mysql
```

## mysqlのクライアントからつなぐ
```
isucon@isucon9q:~$ mysql -uisucari -pisucari
```

- `-u`: ユーザー名
- `-p`: パスワード

データベースを切り替える
```
mysql> use isucari;
```

テーブルの情報を見る
```
mysql> show tables;
```


## nginxのアクセスログのフォーマットををalpが読める形にする
```
http {
...
    log_format ltsv "time:$time_local"
    "\thost:$remote_addr"
    "\tforwardedfor:$http_x_forwarded_for"
    "\treq:$request"
    "\tstatus:$status"
    "\tmethod:$request_method"
    "\turi:$request_uri"
    "\tsize:$body_bytes_sent"
    "\treferer:$http_referer"
    "\tua:$http_user_agent"
    "\treqtime:$request_time"
    "\tcache:$upstream_http_x_cache"
    "\truntime:$upstream_http_x_runtime"
    "\tapptime:$upstream_response_time"
    "\tvhost:$host";
    access_log /var/log/nginx/access.log ltsv;
...
}
```

`log_format`で名前(この例だと`ltsv`)を定義し、`access_log`のほうでそれを参照する。

なお変更は以下の流れで反映する。
```
sudo nginx -t

# ↑でシンタックスチェックして、
# ↓で反映する。

sudo nginx -s reload
```
## nginxの設定を反映する
前述の`sudo nginx -t`で設定のシンタックスが問題ないのを確認して、以下を実行すると設定が反映される。
```
isucon@isucon9q:~$ sudo nginx -s reload
```

## ベンチマーク取る前にアクセスログをクリアする
```
$ sudo truncate --size 0 /var/log/nginx/access.log
```
`truncate`コマンドでサイズを0に指定するとクリアできる。
ベンチマーク取る前に、これやっておくと調査しやすそう。ここはベンチとセットで一発でできるようにしたい。

## Golandでリモートマシンのコードを直接編集する
マニュアルはこれ。以下を参考にGolandにリモートホストを登録する。
https://www.jetbrains.com/help/go/editing-individual-files-on-remote-hosts.html

もしリモートホストがまだ未登録なら以下を見て先に登録しておく必要がある。TypeはSFTPでいけた。
https://www.jetbrains.com/help/go/configuring-synchronization-with-a-remote-host.html


## VSCodeでリモートマシンのコードを直接編集する
(Golandよりこっちのほうが使いやすいかも)

次の拡張を入れる
https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.vscode-remote-extensionpack

拡張機能のヘルプページにある`SSH Tutorial`をみて設定する。
`.ssh/config`も読んでくれるので設定はGolandより楽。
`File > Open...`からフォルダを決める。結構トップからやっちゃうと警告(？)がでるので、絞ったほうが良さそう。

## golangのインストール

```sh
$ wget https://golang.org/dl/go1.16.7.linux-amd64.tar.gz
$ sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go1.16.7.linux-amd64.tar.gz
```

## sudoで使われるパスを変える
https://qiita.com/akito1986/items/e9ca48cfcd56fdbf4c9d
