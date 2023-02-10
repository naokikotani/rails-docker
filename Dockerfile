FROM node:15.0.1
FROM ruby:3.0.2

COPY --from=node /opt/yarn-* /opt/yarn
COPY --from=node /usr/local/bin/node /usr/local/bin/
COPY --from=node /usr/local/lib/node_modules/ /usr/local/lib/node_modules/
RUN ln -fs /usr/local/lib/node_modules/npm/bin/npm-cli.js /usr/local/bin/npm \
  && ln -fs /usr/local/lib/node_modules/npm/bin/npm-cli.js /usr/local/bin/npx \
  && ln -fs /opt/yarn/bin/yarn /usr/local/bin/yarn \
  && ln -fs /opt/yarn/bin/yarnpkg /usr/local/bin/yarnpkg
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev

RUN mkdir /rails_docker
WORKDIR /rails_docker
ADD Gemfile /rails_docker/Gemfile
ADD Gemfile.lock /rails_docker/Gemfile.lock
RUN bundle install
ADD package.json yarn.lock /rails_docker
RUN yarn install
ADD . /rails_docker
