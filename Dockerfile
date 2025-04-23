# Use an official Nginx image as the base image
FROM nginx:alpine

# Copy the static files into the Nginx container
COPY index.html /usr/share/nginx/html
COPY styles.css /usr/share/nginx/html

# Expose the default Nginx port
EXPOSE 80

# The default Nginx container will automatically serve the files on port 80
CMD ["nginx", "-g", "daemon off;"]
