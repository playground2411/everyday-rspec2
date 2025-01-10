FROM ruby:3.3.0

# 必要最低限のツールを入れる
RUN apt-get update -qq && apt-get install -y sqlite3 vim nodejs npm sudo

# 最新のnodeを入れる
RUN npm install n -g
RUN n stable

# yarnだけはバージョン指定
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get install yarn

# railsをインストール
RUN gem install rails -v 7.1.3.2

# アプリケーションディレクトリを作成
RUN mkdir sample

# アプリケーションディレクトリを作業用ディレクトリに設定
WORKDIR /sample
ADD Gemfile ./Gemfile
ADD Gemfile.lock ./Gemfile.lock
RUN bundle install
ADD . .
EXPOSE 3000