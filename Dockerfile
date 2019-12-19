FROM elixir:1.9.0-alpine
EXPOSE 9091

# Compile in prod mode by default
ARG MIX_ENV=test

# .mix folder will be inside the project
ARG APP_HOME=/var/www/app

ENV MIX_ENV=${MIX_ENV}
ENV APP_HOME=${APP_HOME}
ENV MIX_HOME=${APP_HOME}/.mix

WORKDIR $APP_HOME

RUN apk update && \
  apk add postgresql-client

# Create app directory and copy the Elixir projects into it
RUN mkdir /app
COPY . /app
WORKDIR /app

RUN mix local.hex --force
RUN mix local.rebar --force
RUN mix deps.get
RUN mix deps.compile
RUN mix compile

ENTRYPOINT ["/bin/sh", "/app/entrypoint.sh"]