FROM ruby:2.6.3

# Install required linux packages
RUN apt-get update && apt-get install --assume-yes build-essential libpq-dev nodejs

# Install rubygems and bundler
RUN gem update --system && gem install bundler

# Create dir in docker image
RUN mkdir -p /app

# Set working directory
WORKDIR /app

# Setting env up
ENV RAILS_ENV production
ENV RACK_ENV production

# Copy project files
COPY . .

# Install gems
RUN bundle install --without development test

# Precompile assets
RUN bundle exec rake assets:precompile

# Run migrations

EXPOSE 3000

CMD bundle exec rails server
