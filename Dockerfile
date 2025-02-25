FROM ruby:2.2.9

COPY docker/sources.list /etc/apt/sources.list
RUN apt-get update && \
    apt-get install -y --force-yes python2.7 nodejs zlib1g && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN bundle config --global frozen 1

WORKDIR /usr/src/app

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

ENV LANG=C.UTF-8
ENV LC_ALL=C.UTF-8
ENV URL=http://developer.rebble.io
ENV HTTPS_URL=https://developer.rebble.io
ENV EXTERNAL_SERVER=https://example.com
ENV SKIP_DOCS=true
ENV RACK_ENV=production

EXPOSE 4000

CMD ["bundle", "exec", "jekyll", "serve", "--host=0.0.0.0"]
