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
    sqlite3 && \
    rm -rf /var/lib/apt/lists/* /var/cache/apt/archives

ENV RAILS_ENV="production" \
    BUNDLE_WITHOUT="development:test" \
    BUNDLE_DEPLOYMENT="0" \
    RAILS_LOG_TO_STDOUT="true" \
    RAILS_SERVE_STATIC_FILES="true"

COPY Gemfile Gemfile.lock ./

RUN gem install bundler:2.5.22 && \
    bundle config set --local frozen false && \
    bundle install

COPY . .

# Precompiling assets for production without requiring secret RAILS_MASTER_KEY
RUN SECRET_KEY_BASE_DUMMY=1 ./bin/rails assets:precompile

# Create required directories and ensure they're writable
RUN mkdir -p tmp/pids tmp/cache public/assets db storage && \
    touch public/assets/.keep && \
    chmod -R 777 db tmp storage public/assets

# Copy and set up entrypoint before changing user
COPY bin/docker-entrypoint /rails/bin/
RUN chmod +x /rails/bin/docker-entrypoint

# Set up user and permissions
RUN groupadd --system --gid 1000 rails && \
    useradd rails --uid 1000 --gid 1000 --create-home --shell /bin/bash && \
    chown -R rails:rails /rails

USER rails:rails
EXPOSE 80

ENTRYPOINT ["/rails/bin/docker-entrypoint"]
CMD ["./bin/rails", "s", "-b", "0.0.0.0", "-p", "80"]