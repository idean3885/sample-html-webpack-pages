FROM node:16-alpine3.18 AS node
FROM base-alpine3.18:scriptlanguages

# Copy node to alpine linux
COPY --from=node /usr/lib /usr/lib
COPY --from=node /usr/local/share /usr/local/share
COPY --from=node /usr/local/lib /usr/local/lib
COPY --from=node /usr/local/include /usr/local/include
COPY --from=node /usr/local/bin /usr/local/bin

# Copy yarn to alpine linux
COPY --from=node /opt/yarn* /opt/yarn
RUN ln -vfns /opt/yarn/bin/yarn /usr/local/bin/yarn
RUN ln -vfns /opt/yarn/bin/yarnpkg /usr/local/bin/yarnpkg

WORKDIR /app
COPY . .

RUN npm ci

ENTRYPOINT npm run start
