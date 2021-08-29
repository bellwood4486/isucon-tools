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
