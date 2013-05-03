#!/bin/bash
source $HOME/.rvm/scripts/rvm
cd `pwd`
echo $ECHIDNA_ENV
ruby "$PWD/app.rb"
