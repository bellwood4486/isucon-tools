# mysql

## mysqlの設定ファイル

### 設定ファイルを探す

どこにあるか探す。
```shell
sudo ls /etc/my.cnf /etc/mysql/my.cnf ~/.my.cnf -l
```
結果の例(`/etc/mysql/my.cnf`がヒット)
```text
ls: cannot access '/etc/my.cnf': No such file or directory
ls: cannot access '/home/isucon/.my.cnf': No such file or directory
lrwxrwxrwx 1 root root 24 Aug  9 00:07 /etc/mysql/my.cnf -> /etc/alternatives/my.cnf
```

### それでも見つからない場合
ヘルプから読み込まれるパスを確認する。
```
mysql --help | grep "Default options" -A 1
```
`-A`は見つかった行の次のn行も表示する。

結果の例
```
Default options are read from the following files in the given order:
/etc/my.cnf /etc/mysql/my.cnf ~/.my.cnf
```

## mysqlの設定ファイルの見方(一部)
```
!includedir /etc/mysql/conf.d/
!includedir /etc/mysql/mysql.conf.d/
```
これはディレクトリがインクルードされているということ。

## mysqlの設定ファイルでログ関連の設定を探す

```shell
grep log /etc/mysql/mysql.conf.d/*
```

結果の例
```text
/etc/mysql/mysql.conf.d/mysqld.cnf:# Be aware that this log type is a performance killer.
/etc/mysql/mysql.conf.d/mysqld.cnf:# As of 5.1 you can enable the log at runtime!
/etc/mysql/mysql.conf.d/mysqld.cnf:#general_log_file        = /var/log/mysql/mysql.log
/etc/mysql/mysql.conf.d/mysqld.cnf:#general_log             = 1
/etc/mysql/mysql.conf.d/mysqld.cnf:# Error log - should be very few entries.
★/etc/mysql/mysql.conf.d/mysqld.cnf:log_error = /var/log/mysql/error.log
★/etc/mysql/mysql.conf.d/mysqld.cnf:#slow_query_log		= 1
/etc/mysql/mysql.conf.d/mysqld.cnf:#slow_query_log_file	= /var/log/mysql/mysql-slow.log
/etc/mysql/mysql.conf.d/mysqld.cnf:#log-queries-not-using-indexes
/etc/mysql/mysql.conf.d/mysqld.cnf:# The following can be used as easy to replay backup logs or for replication.
/etc/mysql/mysql.conf.d/mysqld.cnf:#log_bin			= /var/log/mysql/mysql-bin.log
/etc/mysql/mysql.conf.d/mysqld.cnf:expire_logs_days	= 10
/etc/mysql/mysql.conf.d/mysqld.cnf:max_binlog_size   = 100M
/etc/mysql/mysql.conf.d/mysqld.cnf:#binlog_do_db		= include_database_name
/etc/mysql/mysql.conf.d/mysqld.cnf:#binlog_ignore_db	= include_database_name
/etc/mysql/mysql.conf.d/mysqld_safe_syslog.cnf:syslog
```

エラーログが`/var/log`配下に履かれているのがわかる。★部分。

また、スロークエリログが無効(コメントアウト)されているのもわかる。★部分。


## スロークエリの設定

### 有効無効の確認
```shell
sudo mysql -uroot -e "show variables like '%slow_query%'"
```
結果の例(無効のとき)
```
+---------------------+----------------------------------+
| Variable_name       | Value                            |
+---------------------+----------------------------------+
| slow_query_log      | OFF                              |
| slow_query_log_file | /var/lib/mysql/isucon9q-slow.log |
+---------------------+----------------------------------+
```

### 閾値の確認
```shell
sudo mysql -uroot -e "show variables like '%long_q%'"
```
結果の例(10秒のとき)
```
+-----------------+-----------+
| Variable_name   | Value     |
+-----------------+-----------+
| long_query_time | 10.000000 |
+-----------------+-----------+
```

## テーブルのデータ量を確認する

最後の`isucari`は変えること。
```shell
sudo mysql -e 'select table_name, table_rows from information_schema.TABLES where table_schema = "isucari";'
```
