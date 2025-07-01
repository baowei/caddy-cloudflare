FROM caddy:builder as builder
ARG CADDY_VERSION
ARG ROUTE53_VERSION

RUN xcaddy build v${CADDY_VERSION} \
    --with github.com/caddy-dns/cloudflare@v${ROUTE53_VERSION}

FROM caddy:latest

COPY --from=builder /usr/bin/caddy /usr/bin/caddy
RUN /usr/bin/caddy version
RUN /usr/bin/caddy list-modules --skip-standard --versions
