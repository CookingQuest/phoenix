FROM elixir:latest
ENV DEBIAN_FRONTEND=noninteractive
RUN mix local.hex --force
RUN apt-get update && apt-get install -y unzip
ADD https://github.com/CookingQuest/phoenix/archive/master.zip /repo/repo.zip
WORKDIR /repo
RUN unzip repo.zip
WORKDIR /repo/phoenix-master    
RUN MIX_ENV=prod mix do deps.get, compile
CMD ["MIX_ENV=prod", "mix", "phoenix.server"]  