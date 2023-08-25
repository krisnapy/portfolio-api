FROM node:18.17-alpine AS builder

# Setup buildtime environment variables
ARG PUBLIC_URL=https://app-59782.on-aptible.com
ENV PUBLIC_URL=${PUBLIC_URL}
ARG ADMIN_URL=https://app-59782.on-aptible.com/admin
ENV ADMIN_URL=${ADMIN_URL}

# Add cache directory to install package
WORKDIR /cache

# Install dependencies
COPY package.json .
COPY yarn.lock .
RUN yarn config set network-timeout 600000 -g && yarn install

# Add a work directory
WORKDIR /app

# Copy app files
COPY . .

# Copy dependencies dari cache
RUN cp -rfu /cache/node_modules/. /app/node_modules/

# Run the build
RUN ["yarn", "build"]

# Expose port
EXPOSE 1337

# Run the production server
CMD ["yarn", "start"]
