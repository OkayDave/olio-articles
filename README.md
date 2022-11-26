# OLIO Technical Test

## Purpose

This repository is [Dave Russell's](https://www.linkedin.com/in/dave-russell-a77b59b/) submission for the OLIO technical test. It is a basic Rails application which displays a list of articles from a JSON source and allows users to perform a 'like' action on them.

The full brief for the test is available [here](https://tech.olioex.com/rails-coding-task.html).

## Tasks

* **T1** - Initial commit and documentation
* **T2** - Rubocop setup
* **T3** - Add Skeleton UI
* **T4** - Retrieve articles and display in UI
* **T5** - Basic authentication
* **T6** - Introduce concept of 'Like'
* **T7** - Tidy up / refactor

## Running

This application was developed against Ruby 3.1.2 and Rails 7.0.4. It uses SQLite as its store.

To prepare the application:

```bash
git clone git@github.com:OkayDave/olio-articles.git
cd olio-articles
bundle install
bin/rake db:setup
```

To run the test suite:

```bash
bin/rake
```

To run the application:

```bash
bin/rails s
```

