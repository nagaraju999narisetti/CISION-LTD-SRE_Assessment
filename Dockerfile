FROM ubuntu:latest

RUN apt-get update && apt-get upgrade -y

# Install nginx version 1.19 from the official Ubuntu repository
RUN apt-get install -y nginx=1.19.*

RUN rm /etc/nginx/nginx.conf

# Copy custom Nginx configuration file
COPY nginx.conf /etc/nginx/nginx.conf

RUN rm -rf /var/www/html/*

# Set the working directory to the web root
WORKDIR /var/www/html

# Expose port 80 to the host machine
EXPOSE 80

# Start Nginx when the container starts
CMD ["nginx", "-g", "daemon off;"]
