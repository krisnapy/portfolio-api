FROM node:18.17-alpine

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
