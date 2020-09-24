# ubuntuベース
FROM ubuntu

# aptコンテナのupdate&upgrade
RUN apt-get update && apt-get upgrade -y

# ubuntu 18.0.4で発生する問題回避 timezone 選択
RUN apt-get install -y tzdata
ENV TZ=Asia/Tokyo

# 色々なものをインストール
RUN apt-get install -y git
RUN apt-get install -y vim
RUN apt-get install -y wget



# GUIをホストで実行するための環境変数
ENV DISPLAY host.docker.internal:0.0


# 接続確認
RUN apt-get install -y x11-apps 
# 接続できていれば、$xeyes で目が表示されるはず


RUN apt-get autoremove -y