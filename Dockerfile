FROM elixir:latest
ENV DEBIAN_FRONTEND=noninteractive
ENV MIX_ENV=prod
  
RUN mix local.rebar --force
RUN mix local.hex --force
RUN apt-get update && apt-get install -y unzip
ADD https://github.com/CookingQuest/phoenix/archive/master.zip /repo/repo.zip
WORKDIR /repo
RUN unzip repo.zip
WORKDIR /repo/phoenix-master
  
RUN mix do deps.get, deps.compile, compile, release --verbose --env=prod
RUN mkdir -p /opt/myapp/log && \
    cp rel/myapp/releases/0.1.0/myapp.tar.gz /opt/myapp/ && \
    cd /opt/myapp && \
    tar -xzf myapp.tar.gz && \
    rm myapp.tar.gz && \
    rm -rf /opt/app/* && \
    chmod -R 777 /opt/app && \
    chmod -R 777 /opt/myapp

WORKDIR /opt/myapp

EXPOSE 4000
CMD ./bin/myapp foreground  