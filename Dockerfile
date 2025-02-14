# syntax=docker/dockerfile:1
FROM ruby:3.3-slim

# Install system dependencies
RUN apt-get update -qq && \
    apt-get install -y --no-install-recommends \
    build-essential \
    curl \
    git \
    libpq-dev \
    libsqlite3-dev \
    libyaml-dev \
    nodejs \
    pkg-config && \
    rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/*

# Set working directory
WORKDIR /rails

# Set environment variables
ENV RAILS_ENV="production" \
    BUNDLE_WITHOUT="development:test" \
    BUNDLE_DEPLOYMENT="1" \
    RAILS_LOG_TO_STDOUT="true" \
    RAILS_SERVE_STATIC_FILES="true" \
    SQLITE_DATABASE_PATH="/rails/db/production.sqlite3"

# Copy only necessary files for dependency installation
COPY Gemfile Gemfile.lock ./

# Install bundler and gems
RUN gem install bundler:2.5.22 && \
    bundle config set --local deployment 'true' && \
    bundle config set --local without 'development test' && \
    bundle install

# Copy entire application
COPY . .

# Prepare directories with correct permissions
RUN mkdir -p tmp/pids tmp/cache public/assets db && \
    touch public/assets/.keep && \
    chown -R 1000:1000 db log tmp public/assets

# Create docker-entrypoint script
RUN echo '#!/bin/bash\n\
set -e\n\
\n\
# Ensure database directory exists with correct permissions\n\
mkdir -p /rails/db\n\
chown -R 1000:1000 /rails/db\n\
\n\
# Prepare database\n\
bundle exec rails db:prepare\n\
\n\
# Execute original command\n\
exec "$@"\n\
' > /rails/bin/docker-entrypoint && \
    chmod +x /rails/bin/docker-entrypoint

# Precompile assets
RUN SECRET_KEY_BASE_DUMMY=1 bundle exec rails assets:precompile

# Create rails user
RUN groupadd --system --gid 1000 rails && \
    useradd rails --uid 1000 --gid 1000 --create-home --shell /bin/bash

# Switch to non-root user
USER 1000:1000

# Expose port
EXPOSE 80

# Set entrypoint and default command
ENTRYPOINT ["/rails/bin/docker-entrypoint"]
CMD ["bundle", "exec", "rails", "s", "-b", "0.0.0.0", "-p", "80"]