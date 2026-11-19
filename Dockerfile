FROM searxng/searxng:latest
COPY settings.yml /etc/searxng/settings.yml
COPY logo.svg /tmp/gm-logo.svg
COPY extra.css /tmp/gm-extra.css
COPY gm_home.html /tmp/gm_home.html
USER root
RUN find /usr/local/searxng -type f \( -name "searxng.svg" -o -name "favicon.svg" \) -exec cp /tmp/gm-logo.svg {} \; ; \
    find /usr/local/searxng -type f -name "sxng-*.css" -exec sh -c 'cat /tmp/gm-extra.css >> "$1"' _ {} \; ; \
    find /usr/local/searxng -type f \( -name "sxng-*.css.gz" -o -name "sxng-*.css.br" -o -name "searxng.svg.gz" -o -name "searxng.svg.br" -o -name "favicon.svg.gz" -o -name "favicon.svg.br" \) -delete ; \
    f=$(find /usr/local/searxng -path "*templates/simple/index.html" | head -1); \
    n=$(grep -n '{% endblock' "$f" | tail -1 | cut -d: -f1); \
    if [ -n "$n" ] && [ "$n" -gt 1 ]; then sed -i "$((n-1))r /tmp/gm_home.html" "$f"; else cat /tmp/gm_home.html >> "$f"; fi; \
    echo "GMDBG-INDEX-FINAL"; sed 's/^/GMDBG: /' "$f" | head -12; \
    true
USER 977:977
ENV SEARXNG_LIMITER=false
EXPOSE 8080
