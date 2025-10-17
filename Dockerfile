# Build-time arguments
ARG BUILD_VERSION="local"
ARG BUILD_TIME="unknown"


# Make build args available as labels (optional) and as env in final stage
LABEL org.example.build_version=${BUILD_VERSION}
LABEL org.example.build_time=${BUILD_TIME}


WORKDIR /app
COPY app/package.json ./
RUN npm ci --only=production
COPY app/ .


# Stage 2: runtime stage
FROM node:20-alpine


# Expose a runtime ENV with default values; these can be overridden at container run-time
ENV PORT=3000
ENV APP_NAME=demo-app
ENV GREETING="Hello from demo app!"


# Copy built app
WORKDIR /app
COPY --from=builder /app /app


# Forward build-time metadata from build stage using ARG (defaults kept for local build)
ARG BUILD_VERSION="local"
ARG BUILD_TIME="unknown"
ENV BUILD_VERSION=${BUILD_VERSION}
ENV BUILD_TIME=${BUILD_TIME}


EXPOSE ${PORT}
CMD ["node", "index.js"]