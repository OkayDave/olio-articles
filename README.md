# OLIO Technical Test

## Purpose

This repository is [Dave Russell's](https://www.linkedin.com/in/dave-russell-a77b59b/) submission for the OLIO technical test. It is a basic Rails application which displays a list of articles from a JSON source and allows users to perform a 'like' action on them.

The full brief for the test is available [here](https://tech.olioex.com/rails-coding-task.html).

## Tasks

* [**T1**](https://github.com/OkayDave/olio-articles/pulls?q=is%3Apr+%5BT1%5D) - Initial commit and documentation
* [**T2**](https://github.com/OkayDave/olio-articles/pulls?q=is%3Apr+%5BT2%5D) - Rubocop and Test setup
* [**T3**](https://github.com/OkayDave/olio-articles/pulls?q=is%3Apr+%5BT3%5D) - Add Skeleton UI
* [**T4**](https://github.com/OkayDave/olio-articles/pulls?q=is%3Apr+%5BT4%5D) - Retrieve articles and display in UI
* [**T5**](https://github.com/OkayDave/olio-articles/pulls?q=is%3Apr+%5BT5%5D) - Basic authentication
* [**T6**](https://github.com/OkayDave/olio-articles/pulls?q=is%3Apr+%5BT6%5D) - Introduce concept of 'Like'
* [**T7**](https://github.com/OkayDave/olio-articles/pulls?q=is%3Apr+%5BT7%5D) - Tidy up / refactor

## Running

To prepare the application:

```bash
git clone git@github.com:OkayDave/olio-articles.git
cd olio-articles
bundle install
rake db:setup
```

To run the test suite:

```bash
rake
```

To run the application:

```bash
rails s
```

## Overview

The Articles JSON is pulled from S3 by the `ArticleCollection` class. This class then initialises an `Article` object for each article in the JSON. 

The `Article` class is a non-persisted PORO which contains the provided data for each article along with data collected by the application for the likes that have been created.

Likes created by the users of the application are persisted, using a `likeable_reference` column linking to the `article.id` value. Likes are unique per-user-per-article.

## Key Software Used
- Ruby 3.1.2
- Rails 7.0.4
- SQLite
- MiniTest::Spec
- Capybara
- TailwindCSS
- Sorcery

## Areas for Improvement

- Improve test coverage. It's not great at the moment, in the interests of time I've done a little bit of everything rather than being as thorough as I'd like.
- Make better use of Ajax/Turbo. The UX could be improved by having the 'like' buttons work without a page refresh.
- Add a 'show' page for each Article
- Persist Articles without compromising the always up-to-date nature of the data. This could be done by synchronising the data at regular intervals as a background job
- Make better (or any) use of caching. This could be done without persisting the Article data at the S3/CloudFront level; or by fragment caching the rendered Article UI.
- Make 'Likes' polymorphic so that they can be applied to other models in the future.
- Give better feedback to the user around validations on forms.