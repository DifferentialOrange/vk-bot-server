FROM tarantool/tarantool:1.x-centos7

WORKDIR /app

RUN yum install -y git \
                   cmake \
                   make \
                   gcc
COPY . .
RUN mkdir -p tmp

RUN tarantoolctl rocks make

ENTRYPOINT [ "tarantool", "init.lua" ]
