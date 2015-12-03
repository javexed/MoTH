FROM ruby
RUN gem install adhearsion adhearsion-asr adhearsion-drb diff-lcs rspec-support rspec-core rspec-expectations rspec-mocks rspec json minitest active-support mini-portile stomp
RUN apt-get update -y
RUN apt-get install -y nano
RUN mkdir /opt/adhearsion
WORKDIR /opt/adhearsion/app
EXPOSE 9050
