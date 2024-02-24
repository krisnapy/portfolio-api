FROM oven/bun

# Setup buildtime environment variables
ARG PUBLIC_URL=${PUBLIC_URL}
ENV PUBLIC_URL=${PUBLIC_URL}
ARG ADMIN_URL=${ADMIN_URL}
ENV ADMIN_URL=${ADMIN_URL}
ARG HOST=${HOST}
ENV HOST=${HOST}
ARG PORT=${PORT}
ENV PORT=${PORT}
ARG NODE_VERSION=${NODE_VERSION}
ENV NODE_VERSION=${NODE_VERSION}
ARG APP_KEYS=${APP_KEYS}
ENV APP_KEYS=${APP_KEYS}
ARG API_TOKEN_SALT=${API_TOKEN_SALT}
ENV API_TOKEN_SALT=${API_TOKEN_SALT}
ARG ADMIN_JWT_SECRET=${ADMIN_JWT_SECRET}
ENV ADMIN_JWT_SECRET=${ADMIN_JWT_SECRET}
ARG TRANSFER_TOKEN_SALT=${TRANSFER_TOKEN_SALT}
ENV TRANSFER_TOKEN_SALT=${TRANSFER_TOKEN_SALT}
ARG DATABASE_CLIENT=${DATABASE_CLIENT}
ENV DATABASE_CLIENT=${DATABASE_CLIENT}
ARG DATABASE_FILENAME=${DATABASE_FILENAME}
ENV DATABASE_FILENAME=${DATABASE_FILENAME}
ARG JWT_SECRET=${JWT_SECRET}
ENV JWT_SECRET=${JWT_SECRET}
ARG DATABASE_NAME=${DATABASE_NAME}
ENV DATABASE_NAME=${DATABASE_NAME}
ARG DATABASE_USERNAME=${DATABASE_USERNAME}
ENV DATABASE_USERNAME=${DATABASE_USERNAME}
ARG DATABASE_PASSWORD=${DATABASE_PASSWORD}
ENV DATABASE_PASSWORD=${DATABASE_PASSWORD}
ARG CLOUDINARY_KEY=${CLOUDINARY_KEY}
ENV CLOUDINARY_KEY=${CLOUDINARY_KEY}
ARG CLOUDINARY_NAME=${CLOUDINARY_NAME}
ENV CLOUDINARY_NAME=${CLOUDINARY_NAME}
ARG CLOUDINARY_SECRET=${CLOUDINARY_SECRET}
ENV CLOUDINARY_SECRET=${CLOUDINARY_SECRET}
ARG NEON_API_KEY=${NEON_API_KEY}
ENV NEON_API_KEY=${NEON_API_KEY}
ARG NEON_PROJECT_NAME=${NEON_PROJECT_NAME}
ENV NEON_PROJECT_NAME=${NEON_PROJECT_NAME}
ARG NEON_ROLE=${NEON_ROLE}
ENV NEON_ROLE=${NEON_ROLE}
ARG NEON_ENABLED=${NEON_ENABLED}
ENV NEON_ENABLED=${NEON_ENABLED}

# Add cache directory to install package
WORKDIR /cache

# Install dependencies
COPY package.json .
COPY bun.lockb .
RUN bun install --timeout 600000

# Add a work directory
WORKDIR /app

# Copy app files
COPY . .

# Copy dependencies dari cache
RUN cp -rfu /cache/node_modules/. /app/node_modules/

# Run the build
RUN ["bun",  "run", "build"]

# Expose port
EXPOSE 1337

# Run the production server
CMD ["bun", "run", "start"]
