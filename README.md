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

start server

```
$ ruby app.rb -sv
```

### Get segments

```
$ curl -d '{"text":"我在睡觉，不要打扰我"}' http://localhost:9000/dicts/segments

{"segments":["打扰","睡觉"]}
```

### Get synonyms

```
$ curl -d '{"text":"本来"}' http://localhost:9000/dicts/synonyms

{"synonyms":["原本","原先","原来"]}
```

### Get homonyms

```
$ curl -d '{"text":"富裕"}' http://localhost:9000/dicts/homonyms

{"hononyms":["馥郁"]}
```
