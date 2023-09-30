# Build the vue files
FROM node:20-alpine3.17 as build-stage
WORKDIR /app
COPY ../client/package*.json ./

# Install dependencies
RUN npm install

# Set the API URL
ARG VITE_API_URL
ENV VITE_API_URL=$VITE_API_URL

COPY ../client/ ./
RUN NODE_ENV=production npm run build-prod

# Start nginx server
FROM nginx:1.21.3-alpine
COPY --from=build-stage /app/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]

