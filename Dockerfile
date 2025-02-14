# syntax=docker/dockerfile:1
ARG RUBY_VERSION=3.3
FROM ruby:$RUBY_VERSION-slim AS base

WORKDIR /rails

# Install base packages
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y curl libjemalloc2 libvips sqlite3 && \
    rm -rf /var/lib/apt/lists/* /var/cache/apt/archives

ENV RAILS_ENV="production" \
    BUNDLE_WITHOUT="development:test" \
    BUNDLE_FROZEN="0"

FROM base AS build

RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y build-essential git pkg-config && \
    rm -rf /var/lib/apt/lists/* /var/cache/apt/archives

# Configure bundler
RUN gem install bundler:2.5.22 && \
    bundle config set --local deployment false && \
    bundle config set --local frozen false

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

# Precompile bootsnap code and assets
RUN bundle exec bootsnap precompile app/ lib/ && \
    SECRET_KEY_BASE_DUMMY=1 bundle exec rails assets:precompile

FROM base

COPY --from=build /usr/local/bundle /usr/local/bundle
COPY --from=build /rails /rails

RUN useradd rails --create-home --shell /bin/bash && \
    chown -R rails:rails db log tmp storage

USER rails:rails
EXPOSE 80

CMD ["./bin/thrust", "./bin/rails", "server"]