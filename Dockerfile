# syntax=docker/dockerfile:1
FROM ruby:3.3-slim
WORKDIR /rails

# Install minimal dependencies
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y \
    build-essential \
    curl \
    git \
    libpq-dev \
    libyaml-dev \
    nodejs \
    pkg-config \
    sqlite3 \
    imagemagick && \
    rm -rf /var/lib/apt/lists/* /var/cache/apt/archives

ENV RAILS_ENV="production" \
    BUNDLE_WITHOUT="development:test" \
    BUNDLE_DEPLOYMENT="0" \
    RAILS_LOG_TO_STDOUT="true" \
    RAILS_SERVE_STATIC_FILES="true"

# First, copy only the files needed for bundle install
COPY Gemfile Gemfile.lock ./
RUN gem install bundler:2.5.22 && \
    bundle config set --local frozen false && \
    bundle install

# Create required directories with proper permissions
RUN mkdir -p tmp/pids tmp/cache public/assets db/migrate storage && \
    chmod -R 777 tmp public/assets storage db

# Now copy the entire application ensuring migrations are included
COPY . .
RUN chmod -R 777 db/migrate

# Precompiling assets
RUN SECRET_KEY_BASE_DUMMY=1 ./bin/rails assets:precompile

# Set up user and permissions
RUN groupadd --system --gid 1000 rails && \
    useradd rails --uid 1000 --gid 1000 --create-home --shell /bin/bash && \
    chown -R rails:rails /rails

USER rails:rails
EXPOSE 80

ENTRYPOINT ["/rails/bin/docker-entrypoint"]
CMD ["./bin/rails", "s", "-b", "0.0.0.0", "-p", "80"]