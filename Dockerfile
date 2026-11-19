FROM searxng/searxng:latest
COPY settings.yml /etc/searxng/settings.yml
COPY logo.svg /tmp/gm-logo.svg
COPY extra.css /tmp/gm-extra.css
COPY gm_home.html /tmp/gm_home.html
COPY gm_brand.html /tmp/gm_brand.html
COPY gm_patch.py /tmp/gm_patch.py
USER root
RUN find /usr/local/searxng -type f \( -name "searxng.svg" -o -name "favicon.svg" \) -exec cp /tmp/gm-logo.svg {} \; ; \
    find /usr/local/searxng -type f -name "sxng-*.css" -exec sh -c 'cat /tmp/gm-extra.css >> "$1"' _ {} \; ; \
    find /usr/local/searxng -type f \( -name "sxng-*.css.gz" -o -name "sxng-*.css.br" -o -name "searxng.svg.gz" -o -name "searxng.svg.br" -o -name "favicon.svg.gz" -o -name "favicon.svg.br" \) -delete ; \
    for f in $(find / -path "*templates/simple/index.html" -not -path "/proc/*" 2>/dev/null); do \
      echo "GMDBG-PATCH $f"; \
      n=$(grep -n '{% endblock' "$f" | tail -1 | cut -d: -f1); \
      if [ -n "$n" ] && [ "$n" -gt 1 ]; then sed -i "$((n-1))r /tmp/gm_home.html" "$f"; else cat /tmp/gm_home.html >> "$f"; fi; \
    done; \
    python3 /tmp/gm_patch.py; \
    find / -name "*.pyc" -path "*searx*" -not -path "/proc/*" -delete 2>/dev/null; \
    true
USER 977:977
ENV SEARXNG_LIMITER=false
EXPOSE 8080
