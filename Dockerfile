FROM node:lts-alpine AS build

ENV NPM_CONFIG_UPDATE_NOTIFIER=false
ENV NPM_CONFIG_FUND=false

# Add any needed enviroment variables here following this same format
ARG SAMPLE_ENVIRONMENT_VARIABLE_1
ARG SAMPLE_ENVIRONMENT_VARIABLE_2

WORKDIR /app

COPY package*.json ./

RUN npm ci

COPY . ./

RUN npm run build

FROM caddy

WORKDIR /app

COPY Caddyfile ./

COPY --from=build /app/dist /app/dist

CMD ["caddy", "run", "--config", "Caddyfile", "--adapter", "caddyfile"]