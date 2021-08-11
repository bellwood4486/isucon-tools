# IDE

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

