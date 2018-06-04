### The Flop House Recommends

This is a silly little site that shows the movies recommended by [The Flop House](http://www.flophousepodcast.com/)

## Setup

- Clone the repo
- Create a `config/initializers/local.rb` file that sets necessary environment variables. The values are in Heroku.

```
ENV["REDISTOGO_URL"] = ""
ENV["S3_BUCKET"] = ""
ENV["S3_SECRET_ACCESS_KEY"] = ""
ENV["S3_ACCESS_KEY_ID"] = ""
ENV["OMDBAPI_KEY"] = ""
```
