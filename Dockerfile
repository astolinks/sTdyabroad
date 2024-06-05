FROM caddy:alpine

# Install Node.js and npm
RUN apk update && apk add --no-cache nodejs npm

# Set the working directory
WORKDIR /app

# Copy the package.json and package-lock.json for npm install
COPY package*.json ./

# Install the dependencies
RUN npm install

# Copy the rest of the files
COPY . .

# Build the app
RUN npm run build

# Copy the built files to the Caddy server directory
RUN cp -r dist/* /usr/share/caddy

# Copy the Caddyfile
COPY Caddyfile /etc/caddy/Caddyfile