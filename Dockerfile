FROM ruby
RUN gem install adhearsion adhearsion-asr adhearsion-drb diff-lcs rspec-support rspec-core rspec-expectations rspec-mocks rspec json minitest 
RUN apt-get update -y
RUN apt-get install -y nano
RUN mkdir /opt/adhearsion
WORKDIR /opt/adhearsion
EXPOSE 9050
