FROM searxng/searxng:latest
COPY settings.yml /etc/searxng/settings.yml
COPY logo.svg /tmp/gm-logo.svg
COPY extra.css /tmp/gm-extra.css
USER root
RUN find /usr/local/searxng -type f \( -name "searxng.svg" -o -name "favicon.svg" \) -exec cp /tmp/gm-logo.svg {} \; ; \
    find /usr/local/searxng -type f -name "sxng-*.css" -exec sh -c 'cat /tmp/gm-extra.css >> "$1"' _ {} \; ; \
    find /usr/local/searxng -type f \( -name "sxng-*.css.gz" -o -name "sxng-*.css.br" -o -name "searxng.svg.gz" -o -name "searxng.svg.br" -o -name "favicon.svg.gz" -o -name "favicon.svg.br" \) -delete ; \
    true
USER 977:977
ENV SEARXNG_LIMITER=false
EXPOSE 8080
