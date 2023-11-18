# Use an official Ruby image as a base
FROM ruby:3.2.2

# Install dependencies required for Rails
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

# Set the working directory inside the container
WORKDIR /communiChat

# Copy the Gemfile and Gemfile.lock into the container
COPY Gemfile /communiChat/Gemfile
COPY Gemfile.lock /communiChat/Gemfile.lock

# Install any needed gems
RUN bundle install

# Copy the rest of your app's code into the container
COPY . /communiChat

# Expose the port your app runs on
EXPOSE 3000

# Configure the main process to run when running the image
CMD ["rails", "server", "-b", "0.0.0.0"]
