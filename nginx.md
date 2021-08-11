# nginx

## nginxのアクセスログのフォーマットをalpが読める形にする
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

シンタックスをチェックする。
```
sudo nginx -t
```

反映する。
```
sudo nginx -s reload
```

## nginxの設定を反映する
前述の`sudo nginx -t`で設定のシンタックスが問題ないのを確認して、以下を実行すると設定が反映される。
```
sudo nginx -s reload
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

## ベンチマーク取る前にアクセスログをクリアする
```
$ sudo truncate --size 0 /var/log/nginx/access.log
```
`truncate`コマンドでサイズを0に指定するとクリアできる。
ベンチマーク取る前に、これやっておくと調査しやすそう。ここはベンチとセットで一発でできるようにしたい。

