# syntax=docker/dockerfile:1
FROM ruby:3.3-slim

WORKDIR /rails

# Install dependencies
RUN apt-get update -qq && \
    apt-get install -y --no-install-recommends \
    build-essential \
    curl \
    git \
    libsqlite3-dev \
    nodejs \
    pkg-config && \
    rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/*

# Set environment variables
ENV RAILS_ENV="production" \
    BUNDLE_WITHOUT="development:test" \
    BUNDLE_DEPLOYMENT="1" \
    RAILS_LOG_TO_STDOUT="true" \
    RAILS_SERVE_STATIC_FILES="true"

# Copy dependency files
COPY Gemfile Gemfile.lock ./

# Install bundler and gems
RUN gem install bundler:2.5.22 && \
    bundle config set --local frozen true && \
    bundle install

# Copy entire application
COPY . .

# Precompile assets
RUN bundle exec rails assets:precompile

# Create directories
RUN mkdir -p tmp/pids tmp/cache public/assets && \
    touch public/assets/.keep

# Create Rails user
RUN useradd rails --create-home --shell /bin/bash && \
    chown -R rails:rails /rails

# Switch to Rails user
USER rails:rails

# Expose Puma's port
EXPOSE 3000

# Health check
HEALTHCHECK --interval=10s --timeout=5s --start_period=30s \
  CMD curl -f http://localhost:3000/up || exit 1

# Start Rails server
CMD ["./bin/rails", "server", "-e", "production", "-b", "0.0.0.0", "-p", "3000"]