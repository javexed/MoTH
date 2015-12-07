FROM ruby
RUN gem install adhearsion adhearsion-asr adhearsion-drb diff-lcs rspec-support rspec-core rspec-expectations rspec-mocks rspec json minitest stomp
RUN apt-get update -y
RUN apt-get install -y nano
RUN mkdir /opt/adhearsion
ADD ./adhearsion_app /opt/adhearsion/app
WORKDIR /opt/adhearsion/app
RUN bundle install
EXPOSE 9050
CMD ahn start .
