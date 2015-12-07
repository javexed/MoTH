#/bin/bash
if [ ! -d "docker-asterisk" ]; then
  echo 'No docker-asterisk, grabbing'
  git clone https://github.com/javexed/docker-asterisk
fi
if [ ! -f "mariadb.env" ] ; then
  echo 'No mariadb.env file, copying sample, please configure'
  cp mariadb.env.sample mariadb.env
fi
if [ ! -f "config.yml" ] ; then
  echo 'No config.yml file, copying sample, please configure'
  cp config.yml.sample config.yml
fi
if [ ! -f "./docker-adhearsion/adhearsion.env" ] ; then
  echo 'No ./docker-adhearsion/adhearsion.env file, copying sampe, please configure'
  cp ./docker-adhearsion/adhearsion.env.sample ./docker-adhearsion/adhearsion.env
fi
docker-compose stop
docker-compose rm -f
docker-compose build
docker-compose up -d
docker-compose run dejavu python load_scripts.py
