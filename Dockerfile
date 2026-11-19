FROM searxng/searxng:latest
COPY settings.yml /etc/searxng/settings.yml
ENV SEARXNG_LIMITER=false
EXPOSE 8080
