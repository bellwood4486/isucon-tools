# alp

ダウンロードサイト
- https://github.com/tkuchiki/alp/releases

## alpを入れる

```
cd
wget -q https://github.com/tkuchiki/alp/releases/download/v1.0.7/alp_linux_amd64.zip
unzip alp_linux_amd64.zip
./alp --version

```

## alpで集計する1
```
sudo ./alp ltsv --file=/var/log/nginx/access.log -r --sort=sum --output="count,method,uri,sum"
```
簡単。ただしこれだとIDが異なる同じエンドポイントが別になるので、全体感はつかめない。特定のキーだけ突出しているとかは見つけられそう。

## alpで集計する2
```
sudo ./alp ltsv --file=/var/log/nginx/access.log -r --sort=sum --output="count,method,uri,sum" -m "/items/[0-9]+.json,/upload/[0-9a-z]+.jpg"
```
`-m`オプションを使って正規表現でまとめられる。

