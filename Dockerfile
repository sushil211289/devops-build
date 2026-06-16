# Dockerfile
FROM nginx:alpine

# Remove default nginx page
RUN rm -rf /usr/share/nginx/html/*

# Copy your built app into nginx's serve directory
COPY . /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start nginx
CMD ["nginx", "-g", "daemon off;"]
