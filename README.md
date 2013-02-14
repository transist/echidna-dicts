#echidna-dicts

dicts system for echidna.

## Setup

```
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
$ curl -d '{"text":"我在睡觉，不要打扰我"}' http://localhost:9000/dicts/segments

{"segments":["我","在","睡觉","，","不要","打扰","我"]}
```

### Get synonyms

```
curl -d '{"text":"本来"}' http://localhost:9000/dicts/synonyms

{"synonyms":["原本","原先","原来"]}
```
