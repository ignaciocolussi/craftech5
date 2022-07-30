FROM nginx:stable-alpine

COPY www/index.html /usr/share/nginx/html

EXPOSE 80