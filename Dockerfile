FROM ruby
RUN apt-get update -y
RUN apt-get install -y nano
ADD ./client.rb ./
