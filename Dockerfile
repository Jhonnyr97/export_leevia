FROM ruby:latest
COPY . .
ENTRYPOINT ["ruby", "leevia.rb"]