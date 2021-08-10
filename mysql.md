# mysql

## スロークエリの設定を確認する

```shell
sudo mysql -uroot -e "show variables like '%slow_query%'"
```
無効のときの例
```
+---------------------+----------------------------------+
| Variable_name       | Value                            |
+---------------------+----------------------------------+
| slow_query_log      | OFF                              |
| slow_query_log_file | /var/lib/mysql/isucon9q-slow.log |
+---------------------+----------------------------------+
```
