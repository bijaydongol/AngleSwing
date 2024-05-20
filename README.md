# AngleSwing

## Dependencies
ruby version: 3.2.0
postgres > 14.11

## Installation
- clone the project from the git with command git clone <github-repo-ssh/https-url>
- bundle install
- rails db:setup
- rails db:migrate

## Run server
- rails server

## Run test
- bundle exec rspec
  To execute a specific spec
- bundle exec rpsec/spec/<path_to_spec_file_name>

## To view the coverage report
  SimpleCov gem is used for the spec coverage report
- run the spec first then execute the command
- xdg-open coverage/index.html