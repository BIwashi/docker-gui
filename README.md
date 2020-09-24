# ubuntu コンテナ内のguiをホストで表示するためのテスト

参考

[Docker上のGUI出力をMacで表示](https://qiita.com/uedashuhei/items/3f6f8612b5c4a2b00b1a)

[Dockerを導入してGUI操作可能なLinux(Ubuntu)コンテナを作成する
](https://qiita.com/ryoya-s/items/ee1daf9cab18c100c990)

<br>

![アーキテクチャ](https://qiita-user-contents.imgix.net/https%3A%2F%2Fqiita-image-store.s3.amazonaws.com%2F0%2F100027%2F417679be-a834-d4f3-f887-b3939519eba4.png?ixlib=rb-1.2.2&auto=format&gif-q=60&q=75&w=1400&fit=max&s=0cc2c9ff5cf1454e141dcb6b6d9e3b46)

<br>

# Xquartzの導入・起動
Xquartz(X11.app)は、macOS用のX Window Systemとなります。X Window Systemとは、Unix系OSでGUI操作を可能にするものです。
最近のmacOSではデフォルトでは入っていないので、導入・起動します。

```
$ brew cask install xquartz
$ open -a XQuartz #起動
```
ちなみに、xquartzは下記から導入することもできます。

[Quartz](https://www.xquartz.org/)

```
# xquartzをセットアップ
brew cask install xquartz
# xquartzを起動しておきます
open -a XQuartz
```



## Socatの導入・起動
Socatは、簡単なプロキシサーバを建ててソケット通信を実施するものです。つまり、ここでは、port6000番(コンテナのGUI操作を行うx11用のボート)を通して、ホスト側の画面がコンテナ内と通信できるようにするために使用します。
まずは、導入から。

```
$ brew install socat
```

下記コマンドで、port6000番(UnixのGUI操作を行うxquartz用のポート)への通信をホスト側のディスプレイで表示するようにします。
forkは複数のコネクションを管理できるようにするオプションで、reuseaddrはポートを再利用可能にするオプションです。

```
$ socat TCP-LISTEN:6000,reuseaddr,fork UNIX-CLIENT:\"$DISPLAY\"
```


## ここから…
Qiitaの設定がいらない？


```
$ docker-compose build
$ docker-compose up -d
```