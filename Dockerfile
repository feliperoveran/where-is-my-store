FROM ruby:2.5.1-alpine

# App variables
ENV APP_PATH /app/
ENV APP_USER app
ENV APP_USER_HOME /home/app
# Bundler variables
ENV BUNDLE_PATH $APP_USER_HOME
ENV GEM_HOME $APP_USER_HOME/bundle
ENV BUNDLE_BIN $GEM_HOME/bin
# Rails variables
ENV RAILS_LOG_TO_STDOUT=true
# System variables
ENV PATH $PATH:$BUNDLE_BIN

# UID of the user that will be created
ARG UID

# Validating if UID argument was provided
RUN : "${UID:?You must provide a UID argument when building this image.}"

# Creating an user so we don't run everything as root
RUN adduser -h $APP_USER_HOME -D -u $UID $APP_USER

# cd to $APP_PATH
WORKDIR $APP_PATH

COPY --chown=app Gemfile* $APP_PATH

# Installing libraries and gems
RUN apk update && apk add --no-cache \
    --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing \
    geos-dev build-base postgresql-dev tzdata && \
    su -c "bundle install" $APP_USER && \
    apk del build-base && rm -r /var/cache/apk/*

COPY --chown=app . $APP_PATH

USER $APP_USER

# Puma
EXPOSE 3000

CMD ["rails", "s", "-b", "0.0.0.0"]
