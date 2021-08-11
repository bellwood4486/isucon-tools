# curl


## 詳細な情報も表示
```shell
curl -v http://localhost:18888
```

## ヘッダーの送信
```shell
curl -H "X-Test: Hello" http://localhost:18888
```

## メソッドを送る
```shell
curl -X POST http://localhost:18888
```

## リダイレクトに追従
```shell
curl -L http://localhost:18888
```

## JSONをボディにつけて送る
```shell
curl -d "{\"hello\":\"world\"}" -H "Content-Type: application/json" http://localhost:18888
```

## JSONをボディにつけて送る(ファイル)
```shell
curl -d @test.json -H "Content-Type: application/json" http://localhost:18888
```

## 強制的にボディをつけてGETを呼ぶ
`-X GET`とするのがポイント。
```shell
curl -X GET --data "hello=world" http://localhost:18888
```

## フォームと同じ形式で送る。ただしURLエンコードはされない。
```
<form method="POST>
  <input name="title">
  <input name="author">
  <input name="submit">
</form>
```
```shell
curl -d title="The Art of Community" -d author="Jono Bacon" http://localhost:18888
```

## 上記をURLエンコード(RFC3986)して送る
```shell
curl --data-urlencode title="The Art of Community" -d author="Jono Bacon" http://localhost:18888
```

## multipart/form-dataエンコードされたファイルを送る
```shell
curl -F title="The Art of Community" -F author="Jono Bacon" -F attachement-file=@test.txt http://localhost:18888
```

