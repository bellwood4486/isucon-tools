# pprof

## コード埋め込み
```go
import (
  ...
	_ "net/http/pprof"
)

func main() {
	go func() {
		log.Print(http.ListenAndServe("localhost:6060", nil))
	}()
  ...
}
```
参考：[[Go] pprofでのプロファイル(計測)のやり方を改めて整理した - Qiita](https://qiita.com/momotaro98/items/bd24a5d4603e378cc357)

## 計測スタート

以下のコマンドを実行すると計測が始まる。最後の数字が秒数。
```sh
go tool pprof http://localhost:6060/debug/pprof/profile?seconds=70
```

## コマンドラインで分析する

### 開く

```sh
go tool pprof 実行ファイル プロファイル
```
例
```sh
go tool pprof pprof/pprof.isucondition.samples.cpu.002.pb.gz cpu.pprof
```
参考： [Golangのpprofの使い方【基礎編】 - Carpe Diem](https://christina04.hatenablog.com/entry/golang-pprof-basic)

### top N を見る
```
top N
```
例
```
top 50
```

### 遅いメソッドの内訳見る
```
peek メソッド名
```
例
```
peek main.postIsuCondition
```

参考：[Golangのpprofの使い方【コマンドラインツール編】 - Carpe Diem](https://christina04.hatenablog.com/entry/golang-pprof-cli)
