#!/bin/bash
source $HOME/.rvm/scripts/rvm
cd `pwd`
echo $ECHIDNA_ENV
/home/echidna/.rvm/rubies/ruby-1.9.3-p385/bin/ruby app.rb -sv -e production -p 9200 -a 127.0.0.1 -d
