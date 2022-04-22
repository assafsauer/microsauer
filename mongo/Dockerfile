FROM mongo:5

COPY *.js /docker-entrypoint-initdb.d/

COPY dd.js tmp/

RUN mongo tmp/dd.js
