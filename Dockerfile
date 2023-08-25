FROM node:18.17-alpine

# Add cache directory to install package
WORKDIR /cache

# Install dependencies
COPY package.json .
COPY yarn.lock .
RUN yarn install

# Add a work directory
WORKDIR /app

# Copy app files
COPY . .

EXPOSE 1337

# Copy dependencies dari cache
RUN cp -rfu /cache/node_modules/. /app/node_modules/

# Run the app
CMD [ "yarn",  "start"]
