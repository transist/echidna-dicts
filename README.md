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

```
$ git submodule add git@github.com:transist/echidna-dicts-data.git dicts
$ bundle exec ruby bin/dicts
```

## APIs

start server

```
$ ruby app.rb -sv
```

### Get segments

```
$ curl -d '{"text":"我在睡觉，不要打扰我"}' http://localhost:9000/v1/dicts/segments

{"segments":["我","在","睡觉","，","不要","打扰","我"]}
```

### Get synonyms

```
curl -d '{"text":"本来"}' http://localhost:9000/v1/dicts/synonyms

{"synonyms":["原本","原先","原来"]}
```
