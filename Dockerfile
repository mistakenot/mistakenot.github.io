FROM jekyll/jekyll:3.8

WORKDIR /app

ADD ./Gemfile .
ADD ./Gemfile.lock .

RUN bundle install
