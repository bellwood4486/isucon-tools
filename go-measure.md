# go-measure

ツール
- https://github.com/najeira/measure

## import文の追加

```shell
go get "github.com/najeira/measure"
```

```go
import (
// ...
	"github.com/najeira/measure"
// ...
)
```

## 計測用データ型

```go
type MyLog struct {
	Key   string
	Count int64
	Sum   float64
	Min   float64
	Max   float64
	Avg   float64
	Rate  float64
	P95   float64
}
```

## 集計をCSVで返すAPIを追加

```go

func main() {
	// ...
	
	mux.HandleFunc(pat.Get("/stats"), getStats)
}

func getStats(w http.ResponseWriter, r *http.Request) {
	stats := measure.GetStats()
	stats.SortDesc("sum")
	var logs []MyLog
	for _, s := range stats {
		log := MyLog{
			Key:   s.Key,
			Count: s.Count,
			Sum:   math.Round(s.Sum),
			Min:   (math.Round(s.Min*100) / 100),
			Max:   (math.Round(s.Max*100) / 100),
			Avg:   (math.Round(s.Avg*100) / 100),
			Rate:  (math.Round(s.Rate*100) / 100),
			P95:   (math.Round(s.P95*100) / 100),
		}
		logs = append(logs, log)
	}
	body := bytes.NewBufferString("key,count,sum,avg\n")
	for _, s := range logs {
		body.WriteString(fmt.Sprintf("%s,%d,%f,%f\n",
			s.Key, s.Count, s.Sum, s.Avg))
	}
	w.Header().Set("Content-Type", "text/csv; charset=UTF-8")
	t := time.Now().Format("20060102_150405")
	disp := "attachment; filename=\"" + t + "_log.csv\""
	w.Header().Set("Content-Disposition", disp)
	_, err := io.Copy(w, body)
	if err != nil {
		panic(err)
	}
}
```

## 計測コードを仕込む

ひとつのメソッドを雑に測る。
```go
func foo() {
    defer measure.Start("foo").Stop()

    // your code

}
```

ひとつのメソッド内で複数箇所を分けて測る。
```go
func foo() {
    m := measure.Start("foo:part1")
    // ...
    m.Stop()
    
	m = measure.Start("foo:part2")
    // ...
    m.Stop()
}
```

※上記2つは組み合わせて書くこともできる。
