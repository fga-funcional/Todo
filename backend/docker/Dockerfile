FROM debian:latest

# Install dependencies.
RUN apt-get update && \
  apt-get install --assume-yes curl gcc libgmp-dev make xz-utils zlib1g-dev

# Install Stack.
RUN curl --location https://www.stackage.org/stack/linux-x86_64-static > stack.tar.gz && \
  tar xf stack.tar.gz && \
  cp stack-*-linux-x86_64-static/stack /usr/local/bin/stack && \
  rm -f -r stack.tar.gz stack-*-linux-x86_64-static/stack && \
  stack --version

WORKDIR /home/tasks-api
COPY stack.yaml /home/tasks-api/
COPY tasks-api.cabal /home/tasks-api/

RUN stack setup

COPY Main.hs home/tasks-api/

RUN stack --no-system-ghc --install-ghc build --allow-different-user

RUN stack install
