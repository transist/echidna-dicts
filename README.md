#echidna-dicts

dicts system for echidna.

## Setup

install redis-server on debian

```bash
sudo apt-get install redis-server
```

or mac

```bash
brew install redis
```

install rvm for ruby

```bash
curl -L https://get.rvm.io | bash -s stable --ruby
source ~/.rvm/scripts/rvm
echo 'rvm_trust_rvmrcs_flag=1' > ~/.rvmrc
```

install dependencies for ruby

```bash
rvm requirements
```

then followed the notes

install ruby

```bash
rvm install 1.9.3-p327-falcon --patch falcon
rvm use 1.9.3-p327-falcon --default
```

install bundler (ruby gems management)

```bash
rvm gemset use global
gem install bundler
rvm gemset use default
```

copy .rvmrc.example to .rvmrc and customize it to conform your ruby setup if necessary
then install app dependencies

```bash
cd <app path>
cp .rvmrc.example .rvmrc
bundle install
```

## Parse dicts

synonym dicts and stopwords

```bash
git submodule update --init
bin/dicts
```
flush old dicts and parse again

```bash
FORCE_FLUSH=true bin/dicts
```

## Run tests

```bash
bundle exec rspec spec
```

unit tests

```bash
bundle exec rspec spec/models
```

functional tests

```bash
bundle exec rspec spec/apis
```

## APIs

start server for development, port is 3000, bind 0.0.0.0

```bash
ruby app.rb -sv
```

start server for production, port is 9200, bind 127.0.0.1, run as a daemon

```bash
RACK_ENV=production ruby app.rb -e production -p 9200 -a 127.0.0.1 -d
```

### Get segments

```bash
curl -w '\n' "http://localhost:9000/dicts/segments?text=我在睡觉，不要打扰我"

# => {"segments":["我","在","睡觉","，","不要","打扰","我"]}
```

```bash
curl -w '\n' "http://localhost:9000/dicts/segments?text=我在睡觉，不要打扰我&optimize=true"

# => {"segments":["打扰","睡觉"]}
```

### Get synonyms

```bash
curl -w '\n' "http://localhost:9000/dicts/synonyms?text=本来"

# => {"synonyms":["原本","原先","原来"]}
```

### Get homonyms

```bash
curl -w '\n' "http://localhost:9000/dicts/homonyms?text=富裕"

# => {"hononyms":["馥郁"]}
```

### Get hypernyms

```bash
curl -w '\n' "http://localhost:9000/dicts/hypernyms?text=许愿"

# => {"hypernyms":["许诺","作曲家","网络作家","作家","河南"]}
```
