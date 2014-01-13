# README: Polltron

This is a simple application accompanying a three-part Summa blog post. It uses:

- Ruby 2.0
- Rails 4.0
- Redis

And it's built to be deployed on Heroku. It's not something you should use in the
real world but instead it's built to demonstrate how these different tools are used.

## Getting started

First, check out this repository. I use the command-line, so it would
look like this:

    $ git clone git@github.com:cwinters/polltron.git
    Cloning into 'polltron'...
    remote: Counting objects: 69, done.
    remote: Compressing objects: 100% (51/51), done.
    remote: Total 69 (delta 7), reused 69 (delta 7)
    Receiving objects: 100% (69/69), 15.

Now let Bundler do its work:

    $ cd polltron
    polltron: $ bundle install
    Using rake (10.1.1)
    ...
    Using uglifier (2.4.0)
    Using unicorn (4.7.0)
    Your bundle is complete!
    Use `bundle show [gemname]` to see where a bundled gem is installed.

The exercise has a number of references like this `(Tag: v0.0.2)`. You can advance (or retreat) to
that particular point in the exercise by checking out that tag in git:

    polltron: $ git co v0.0.2

## Redis use

### Models

We store a few different types of models in Redis. (Traditionally these might be better done in a
relational database but we're using Redis for everything.)

__Poll__

Key `poll.{numeric ID}`

Value: STRING; serialized JSON with keys:

* id
* name
* choices: array of numeric IDs

__Poll choice__

Key: `poll_choice.{numeric ID}`

Value: STRING; serialized JSON with keys:

* id
* name
* poll (full redis key)

__User__

Key: `user.{numeric ID}`

Value: STRING; serialized JSON with keys:

* email
* id
* name


### Tracking structures

__Poll created__

Key: `poll_created`

Value: ZSET; score is timet when poll created; value is `poll.{numeric ID}`

__User created__

Key `user_created`

Value: ZSET; score is timet of creation, value is `user.{numeric ID}`

__User polls__

Key: `user.{numeric ID}.polls`

Value: ZSET; score is timet of poll creation, value is `poll.{numeric ID}`

__User votes__

Key: `user.{numeric ID}.votes`

Value: ZSET; score is timet of vote, value is `poll.{numeric ID}.choices {index}`

__Vote count by poll__

Key: `poll.{numeric ID}.vote_count`

Value: HASH; key is choice ID, value is count of that choice; additional key `TOTAL`
which is the sum.

__Vote by poll__

Key: `poll.{numeric ID}.votes`

Value: ARRAY; value is `{timet} poll.{numeric ID}.choices {index}`

__Vote time__

Key: `vote_time`

Value: ZSET; score is timet of vote, value is `poll.{numeric ID}`

__Vote count__

Key: `vote_count`

Value: ZSET; score is total vote count, value is `poll.{numeric ID}`
