FROM nginx:latest

RUN apt-get update && \
    apt-get install -y curl && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/www/nginx-default
RUN mkdir -p /var/www/html/maintenance

COPY files/favicon.ico /var/www/nginx-default/
COPY files/status.html /var/www/nginx-default/
COPY files/index.html /var/www/nginx-default/
COPY files/index.html /var/www/html/maintenance

RUN mkdir -p /etc/nginx/switch

COPY files/nginx-proxy.conf /etc/nginx/conf.d/
COPY files/http_gzip_static.conf /etc/nginx/conf.d/
COPY files/nginx.conf /etc/nginx/

RUN rm -f /etc/nginx/conf.d/default.conf

CMD ["nginx", "-g", "daemon off;"]
