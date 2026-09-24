# Build the Flutter web app in a Flutter toolchain image.
FROM ghcr.io/cirruslabs/flutter:stable AS build

WORKDIR /app

COPY pubspec.yaml pubspec.lock ./
RUN flutter pub get

COPY . .

# Coolify serves this container from the domain root. The public domain is
# injected by Nginx at request time, so this same image works on any domain.
RUN flutter build web --release --wasm --base-href /

# Serve the static Flutter output with a small production web server.
FROM nginx:stable-alpine-slim

# Apply the latest Alpine security updates to the runtime image.
RUN apk upgrade --no-cache

COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=build /app/build/web /usr/share/nginx/html

EXPOSE 2106

HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
  CMD wget --quiet --tries=1 --spider http://127.0.0.1:2106/ || exit 1
