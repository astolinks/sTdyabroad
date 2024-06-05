FROM caddy:alpine

# Install nodejs and npm
RUN apk update && apk add --no-cache nodejs npm

# Set the working directory
WORKDIR /app

# Copy the package.json and package-lock.json for npm install
COPY package*.json ./

# Install the dependencies
RUN npm install

# Copy the source code
COPY . .

# Build the app
RUN npm run build

# Copy the built app to the Caddy server
RUN npm run build

# Copy the built app to the Caddy server
RUN cp -r dist/* /srv/

# Copy the Caddyfile
COPY ./Caddyfile /etc/caddy/Caddyfile