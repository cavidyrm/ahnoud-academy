FROM nginx:1.27-alpine

RUN rm -rf /usr/share/nginx/html/*

COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY support.js /usr/share/nginx/html/
COPY assets/ /usr/share/nginx/html/assets/
COPY robots.txt sitemap.xml site.webmanifest /usr/share/nginx/html/
COPY ["Ahnoud Academy Landing.dc.html", "/usr/share/nginx/html/Ahnoud Academy Landing.dc.html"]
COPY 404.dc.html /usr/share/nginx/html/404.dc.html

RUN cp "/usr/share/nginx/html/Ahnoud Academy Landing.dc.html" /usr/share/nginx/html/index.html \
    && cp /usr/share/nginx/html/404.dc.html /usr/share/nginx/html/404.html

EXPOSE 80
