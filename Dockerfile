# syntax=docker/dockerfile:1
FROM ruby:3.3-slim

WORKDIR /rails

# Force rebuild every time
RUN echo $(date) > builddate

# Install minimal dependencies
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y \
    build-essential \
    curl \
    git \
    libpq-dev \
    libyaml-dev \
    nodejs \
    pkg-config && \
    rm -rf /var/lib/apt/lists/* /var/cache/apt/archives

ENV RAILS_ENV="production" \
    BUNDLE_WITHOUT="development:test" \
    BUNDLE_DEPLOYMENT="0" \
    RAILS_LOG_TO_STDOUT="true" \
    RAILS_SERVE_STATIC_FILES="true"

# Copy only what's needed for bundle install
COPY Gemfile Gemfile.lock ./

# Install bundler and gems
RUN gem install bundler:2.5.22 && \
    bundle config set --local frozen false && \
    bundle install

# Copy application code
COPY . .

# Ensure the db folder exists
RUN mkdir -p db

# Precompiling assets for production without requiring secret RAILS_MASTER_KEY
RUN SECRET_KEY_BASE_DUMMY=1 ./bin/rails assets:precompile

# Create required directories and ensure assets directory exists
RUN mkdir -p tmp/pids tmp/cache public/assets && \
    touch public/assets/.keep

# Create user and set permissions
RUN groupadd --system --gid 1000 rails && \
    useradd rails --uid 1000 --gid 1000 --create-home --shell /bin/bash && \
    chown -R rails:rails db log tmp
USER 1000:1000

# Entrypoint prepares the database.
ENTRYPOINT ["/rails/bin/docker-entrypoint"]

# Entrypoint prepares the database.
ENTRYPOINT ["/rails/bin/docker-entrypoint"]

USER rails:rails
EXPOSE 80

# Simple start command
CMD ["./bin/rails", "s", "-b", "0.0.0.0", "-p", "80"]