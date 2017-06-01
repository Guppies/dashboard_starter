#!/bin/bash

set -e # Exit on errors

if [ -n "$TMUX" ]; then
  export NESTED_TMUX=1
  export TMUX=''
fi

if [ ! $dashboard_DIR ]; then export dashboard_DIR=$HOME/workspace/dashboard_starter; fi

cd $dashboard_DIR

tmux new-session  -d -s dashboard
tmux set-environment -t dashboard -g dashboard_DIR $dashboard_DIR

tmux new-window     -t dashboard -n 'Web'
tmux send-key       -t dashboard 'cd $dashboard_DIR'      Enter 'rails s'                                     Enter

tmux new-window     -t dashboard -n 'Console'
tmux send-key       -t dashboard 'cd $dashboard_DIR'      Enter 'rails c'                                     Enter

tmux new-window     -t dashboard -n 'Redis'
tmux send-key       -t dashboard Enter 'redis-server'                                                       Enter
tmux split-window   -t dashboard
tmux send-key       -t dashboard Enter 'redis-cli'                                                          Enter

tmux new-window     -t dashboard -n 'sidekiq'
tmux send-key       -t dashboard 'cd $dashboard_DIR'      Enter 'bundle exec sidekiq -C config/sidekiq.yml'   Enter
tmux split-window   -t dashboard
tmux send-key       -t dashboard 'cd $dashboard_DIR'      Enter 'tail -f ./log/sidekiq.log'                   Enter

tmux new-window     -t dashboard -n 'Guard'
tmux send-key       -t dashboard 'cd $dashboard_DIR'      Enter 'bundle exec guard'                           Enter

tmux new-window     -t dashboard -n 'vim'
tmux send-key       -t dashboard 'cd $dashboard_DIR'      Enter 'vim .'                                       Enter

if [ -z "$NESTED_TMUX" ]; then
  tmux -2 attach-session -t dashboard
else
  tmux -2 switch-client -t dashboard
fi
