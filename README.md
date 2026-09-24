# Jonakote — personal portfolio

> Digital things with intent.

A small, fast portfolio built with **Flutter Web**. It is designed to be a clear home for work, ideas, and future collaborations — with a deliberately minimal visual system and a strong focus on readability.

## What is here

- Responsive, single-page portfolio experience
- Dark, editorial visual direction with high-contrast lime accents
- Custom responsive layout built with Flutter and Dart
- SEO metadata, Open Graph tags, JSON-LD, sitemap, and robots directives
- No mobile targets or platform-specific code: web only

## Run locally

Make sure Flutter is installed, then run:

```bash
flutter pub get
flutter run -d chrome
```

To create a production build:

```bash
flutter build web --release --wasm --base-href /
```

The generated site lives in `build/web`.

## Deploy with Coolify

This repository includes a production-ready `Dockerfile` and Nginx configuration. In Coolify:

1. Create a **Dockerfile** resource from this repository.
2. Set the container port to `2106`.
3. Add the domain you want to use.
4. Deploy.

The Docker image builds Flutter Web with WebAssembly and serves the compiled output with Nginx. Client-side routes fall back to `index.html`, static assets receive long-lived cache headers, and SEO URLs automatically resolve to whichever Coolify domain receives the request.

For a local container preview:

```text
docker build -t jonakote-portfolio .
docker run --rm -p 2106:2106 jonakote-portfolio
```

## Project structure

```text
lib/main.dart                 # App entry point and Dart library parts
lib/screens/                  # Full-page screens
lib/sections/                 # Hero, work, about, contact, and principles
lib/components/               # Reusable navigation, cards, visuals, and primitives
lib/theme/                    # Shared color tokens
web/index.html                # SEO, social metadata, fonts, and structured data
web/manifest.json             # Web app metadata
web/robots.txt                # Crawler instructions
web/sitemap.xml               # Search discovery
Dockerfile                    # Multi-stage Flutter + Nginx image
nginx.conf                    # Static hosting and SPA fallback
```

## Design direction

The portfolio uses a restrained palette, generous spacing, and two complementary typefaces: Manrope for interface copy and Space Grotesk for display moments. The project visuals use `fl_chart` for responsive radar and line/area charts, keeping the graphics interactive and web-friendly without adding visual noise.

## About

This is the online home of [@jonakote](https://github.com/jonakote). The site is intentionally easy to evolve as new work, experiments, and collaborations take shape.

## License

The source is available for reference. Portfolio content, identity, and copy belong to Jonakote.
