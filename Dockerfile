# syntax=docker/dockerfile:1
ARG RUBY_VERSION=3.3
FROM ruby:$RUBY_VERSION-slim AS base

WORKDIR /rails

# Cache bust with current date
RUN echo "Build date: $(date)" > builddate

# Install base packages
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y \
    curl \
    libjemalloc2 \
    libvips \
    sqlite3 \
    pkg-config \
    libyaml-0-2 \
    nodejs && \
    rm -rf /var/lib/apt/lists/* /var/cache/apt/archives

ENV RAILS_ENV="production" \
    BUNDLE_WITHOUT="development:test" \
    BUNDLE_FROZEN="0" \
    NODE_ENV="production" \
    RAILS_SERVE_STATIC_FILES="true" \
    RAILS_LOG_TO_STDOUT="true"

FROM base AS build

# Install build dependencies
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y \
    build-essential \
    git \
    pkg-config \
    libyaml-dev \
    libpq-dev && \
    rm -rf /var/lib/apt/lists/* /var/cache/apt/archives

# Install gems
COPY Gemfile Gemfile.lock ./
RUN gem install bundler:2.5.22 && \
    bundle config set --local deployment false && \
    bundle config set --local frozen false && \
    bundle install

# Copy application code
COPY . .

FROM base

COPY --from=build /usr/local/bundle /usr/local/bundle
COPY --from=build /rails /rails

RUN useradd rails --create-home --shell /bin/bash && \
    chown -R rails:rails db log tmp storage public 

USER rails:rails
EXPOSE 80

CMD ["./bin/rails", "server"]