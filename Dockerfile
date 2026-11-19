FROM searxng/searxng:latest
COPY settings.yml /etc/searxng/settings.yml
COPY logo.svg /tmp/gm-logo.svg
COPY extra.css /tmp/gm-extra.css
USER root
RUN find /usr/local/searxng -type f \( -name "searxng.svg" -o -name "favicon.svg" \) -exec cp /tmp/gm-logo.svg {} \; ; \
    find /usr/local/searxng -type f -name "sxng-*.css" -exec sh -c 'cat /tmp/gm-extra.css >> "$1"' _ {} \; ; \
    find /usr/local/searxng -type f \( -name "sxng-*.css.gz" -o -name "sxng-*.css.br" -o -name "searxng.svg.gz" -o -name "searxng.svg.br" -o -name "favicon.svg.gz" -o -name "favicon.svg.br" \) -delete ; \
    true
RUN echo "GMDBG-SVGS" ; find /usr/local/searxng -path "*themes/simple*" \( -name "*.svg" -o -name "*.png" \) | head -40 ; \
    echo "GMDBG-INDEX" ; cat "$(find /usr/local/searxng -path "*templates/simple/index.html" | head -1)" | head -30 ; \
    echo "GMDBG-CSS" ; grep -o "[^}]*\.index[^{]*{[^}]*}" "$(find /usr/local/searxng -name "sxng-ltr.min.css" | head -1)" | head -12 ; true
USER 977:977
ENV SEARXNG_LIMITER=false
EXPOSE 8080
