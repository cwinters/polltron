# README: Polltron

This is a simple application accompanying a three-part Summa blog post. It uses:

- Ruby 2.0
- Rails 4.0
- Redis

And it's built to be deployed on Heroku.

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

To advance to a particular point in the exercise you can check out a tag:

    polltron: $ git co v0.0.1
