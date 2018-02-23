FROM elixir:alpine as builder
MAINTAINER fterrier@gmail.com <fterrier@gmail.com>

ENV MIX_ENV=prod
ENV REPLACE_OS_VARS=true

RUN apk add --no-cache build-base

COPY . /app

WORKDIR /app

# Read version from mix.exs and store it in .version
RUN echo $(cat mix.exs| grep version: | head -n1 | awk -F: '{print $2}' | sed 's/[\",]//g' | tr -d '[[:space:]]') > .version
RUN mix local.hex --force && mix local.rebar --force
RUN mix deps.get
RUN mix compile
RUN ls -lha /app
RUN mix release --env=prod
RUN mkdir -p /app/target
RUN tar xzf /app/_build/prod/rel/heating/releases/$(cat .version)/heating.tar.gz -C /app/target/

FROM alpine:3.6
MAINTAINER Francois Terrier <fterrier@gmail.com>

RUN apk add --no-cache ncurses-libs openssl bash

COPY --from=builder /app/target/ /app/

RUN ls -lha /app/

ENTRYPOINT ["/app/bin/heating"]
CMD ["foreground"]
