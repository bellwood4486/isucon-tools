# PC and OS

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

## マシンを再起動する
```
sudo reboot
```

## ポートを使っているプロセスを確認する
```
sudo lsof -i:80
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

## sudoで使われるパスを変える
https://qiita.com/akito1986/items/e9ca48cfcd56fdbf4c9d

## grepで一気に調べる

```
isucon@isucon9q:~$ grep "MYSQL_HOST=" -rn
```
- `-r`は、再帰的に調べていく。
- `-n`は、行番号も結果に出す

