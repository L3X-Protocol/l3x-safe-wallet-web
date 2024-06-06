FROM node:18-alpine
RUN apk add --no-cache libc6-compat git python3 py3-pip make g++ libusb-dev eudev-dev linux-headers
WORKDIR /app
COPY . .

# Fix arm64 timeouts
RUN yarn config set network-timeout 300000 && yarn global add node-gyp

# Install deps
RUN yarn install --frozen-lockfile
RUN yarn after-install

ENV NODE_ENV production
ENV NEXT_TELEMETRY_DISABLED 1

# Use Railway's PORT variable
EXPOSE $PORT

CMD ["yarn", "static-serve"]
