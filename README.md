#echidna-dicts

dicts system for echidna.

## Setup

```ruby
$ bundle install
```

## Parse dicts

```
$ ruby bin/dicts
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
