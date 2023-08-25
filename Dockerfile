FROM node:18.17-alpine AS builder

# Setup buildtime environment variables
ARG PUBLIC_URL=https://app-59782.on-aptible.com
ENV PUBLIC_URL=https://app-59782.on-aptible.com
ARG ADMIN_URL=https://app-59782.on-aptible.com/admin
ENV ADMIN_URL=https://app-59782.on-aptible.com/admin

# Add cache directory to install package
WORKDIR /cache

# Install dependencies
COPY package.json .
COPY yarn.lock .
RUN yarn install

# Build app
RUN yarn build

# Add a work directory
WORKDIR /app

# Copy app files
COPY . .

# Copy dependencies dari cache
RUN cp -rfu /cache/node_modules/. /app/node_modules/

# Expose port
EXPOSE 1337

# Run the app
CMD [ "yarn",  "start"]
