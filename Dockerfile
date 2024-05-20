#ref: https://www.honeybadger.io/blog/containerizing-an-existing-rails-application/
#where to find ruby container image
FROM ruby:3.2.0

#add the code from the app and bundle it
ADD . /angleswing
WORKDIR /angleswing
RUN bundle install

ENV RAILS_ENV development
ENV RAILS_SERVE_STATIC_FILES true

#exposing port
EXPOSE 3000

CMD ["bash"]


