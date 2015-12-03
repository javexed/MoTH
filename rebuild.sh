#/bin/bash
if [ ! -d "docker-asterisk" ]; then
  git clone https://github.com/javexed/docker-asterisk
fi
docker-compose stop
docker-compose rm -f
docker-compose build
docker-compose up -d
docker-compose run dejavu python load_scripts.py
