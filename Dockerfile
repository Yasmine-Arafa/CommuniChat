FROM ruby:3.2.2

# Set environment variables
ENV RAILS_ENV=development \
    RAILS_ROOT=/app


# Set the working directory inside the container
WORKDIR $RAILS_ROOT

# Install system dependencies
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

# Install bundler and gems
RUN gem install bundler
COPY Gemfile Gemfile.lock ./
RUN bundle install

# Copy the Rails application into the container
COPY . .

# Expose port 3000 (the default Rails port)
EXPOSE 3000

# Start the Rails application
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
