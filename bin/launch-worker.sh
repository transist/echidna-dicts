#!/bin/bash
source $HOME/.rvm/scripts/rvm
cd `pwd`
ruby "$PWD/bin/worker.rb"
