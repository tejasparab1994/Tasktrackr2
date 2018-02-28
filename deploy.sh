#!/bin/bash

export PORT=5108
export MIX_ENV=prod
export GIT_PATH=/home/tasks1/src/Tasktrackr 

PWD=`pwd`
if [ $PWD != $GIT_PATH ]; then
	echo "Error: Must check out git repo to $GIT_PATH"
	echo "  Current directory is $PWD"
	exit 1
fi

if [ $USER != "tasks1" ]; then
	echo "Error: must run as user 'tasks1'"
	echo "  Current user is $USER"
	exit 2
fi

mix deps.get
(cd assets && npm install)
(cd assets && ./node_modules/brunch/bin/brunch b -p)
mix phx.digest
mix release --env=prod

mkdir -p ~/www
mkdir -p ~/old

NOW=`date +%s`
if [ -d ~/www/tasktracker ]; then
	echo mv ~/www/tasktracker ~/old/$NOW
	mv ~/www/tasktracker ~/old/$NOW
fi

mkdir -p ~/www/tasktracker
REL_TAR=~/src/Tasktrackr/_build/prod/rel/tasktracker/releases/0.0.1/tasktracker.tar.gz
(cd ~/www/tasktracker && tar xzvf $REL_TAR)

crontab - <<CRONTAB
@reboot bash /home/task1/src/tasktracker/start.sh
CRONTAB

#. start.sh
