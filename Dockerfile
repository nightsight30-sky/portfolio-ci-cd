FROM nginx:alpine

COPY index.html /usr/share/nginx/html
COPY styles.css /usr/share/nginx/html
COPY resource /usr/share/nginx/html/resource

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
