# ruby 2.6.3のDocker imageをベースとする
FROM ruby:2.6.3

# 環境設定: LANGを日本語UTF-8に設定
# ja_JP.UTF-8にしたければ別途インストールする必要がある？？ひとまずC.UTF-8に設定
ENV LANG="C.UTF-8"
# 環境設定: APP_ROOTを定義しルートディレクトリを設定
ENV APP_ROOT /railsgirls
# 作業ディレクトリを割り当て
WORKDIR $APP_ROOT

    # パッケージリストの更新
RUN apt-get update \
    # 必要なパッケージをインストール
    && apt-get install -y nodejs \
    postgresql-client \
    sqlite3 \
    --no-install-recommends \
    # パッケージリストのキャッシュをcleanする
    && apt-get clean \
    # Docker imageの容量を減らすためパッケージのリストは削除する
    && rm -rf /var/lib/apt/lists/*

# ローカル環境（host側）のGemfileをコピー
ADD Gemfile $APP_ROOT/Gemfile
ADD Gemfile.lock $APP_ROOT/Gemfile.lock

# bundler install
RUN gem install bundler
# bundle install
RUN bundle install

# $APP_ROOT（/railsgirls）配下をコンテナ上にコピー
COPY . $APP_ROOT

# ポート3000を解放
EXPOSE  3000
# docker runした時に起動するコマンドを設定
# rails serverを立ち上げる（pidの削除はdocker-composeの方ですることに）
CMD ["rails", "server", "-b", "0.0.0.0"]
