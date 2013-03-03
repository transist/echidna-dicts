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

### Ruby Environment Setup

<https://github.com/transist/echidna/wiki/Ruby-Environment-Setup>

## Parse dicts

synonym dicts and stopwords

```bash
git submodule update --init
ECHIDNA_ENV=development ECHIDNA_REDIS_HOST=127.0.0.1 ECHIDNA_REDIS_PORT=6379 ruby bin/init_dicts.rb
```

flush old dicts and parse again

```bash
ECHIDNA_ENV=development ECHIDNA_REDIS_HOST=127.0.0.1 ECHIDNA_REDIS_PORT=6379 FORCE_FLUSH=true ruby bin/init_dicts.rb
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
ECHIDNA_ENV=development ECHIDNA_DICTS_IP=0.0.0.0 ECHIDNA_DICTS_PORT=9000 ECHIDNA_DICTS_DAEMON=true ECHIDNA_REDIS_HOST=127.0.0.1 ECHIDNA_REDIS_PORT=6379 ruby app.rb
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
