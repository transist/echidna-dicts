#echidna-dicts

dicts system for echidna.

## Setup

install redis-server on debian

```
$ sudo apt-get install redis-server
```

or mac

```
$ brew install redis
```

install rvm for ruby

```
$ curl -L https://get.rvm.io | bash -s stable --ruby
$ source ~/.rvm/scripts/rvm
$ echo 'rvm_trust_rvmrcs_flag=1' > ~/.rvmrc
```

install dependencies for ruby

```
$ rvm requirements
```

then followed the notes

install ruby

```
$ rvm install 1.9.3-p327-falcon --patch falcon
$ rvm use 1.9.3-p327-falcon --default
```

install bundler (ruby gems management)

```
$ rvm gemset use global
$ gem install bundler
$ rvm gemset use default
```

install app dependencies

```
$ cd <app path>
$ bundle install
```

## Parse dicts

synonym dicts and stopwords

```
$ git submodule init
$ git submodule update
$ bundle exec ruby bin/dicts
```

## Run tests

```
$ bundle exec rspec spec
```

unit tests

```
$ bundle exec rspec spec/models
```

functional tests

```
$ bundle exec rspec spec/apis
```

## APIs

start server for development, port is 3000

```
$ ruby app.rb -sv
```

start server for production, port is 9200, run as a daemon

```
$ RACK_ENV=production ruby app.rb -e production -d
```

### Get segments

```
$ curl -w '\n' http://localhost:9000/dicts/segments?text=我在睡觉，不要打扰我

{"segments":["我","在","睡觉","，","不要","打扰","我"]}
```

```
$ curl -w '\n' http://localhost:9000/dicts/segments?text=我在睡觉，不要打扰我&optimize=true

{"segments":["打扰","睡觉"]}
```

### Get synonyms

```
$ curl -w '\n' http://localhost:9000/dicts/synonyms?text=本来

{"synonyms":["原本","原先","原来"]}
```

### Get homonyms

```
$ curl -w '\n' http://localhost:9000/dicts/homonyms?text=富裕

{"hononyms":["馥郁"]}
```
