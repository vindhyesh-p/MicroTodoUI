# Stage 1: Build the React app
FROM node:16.17.0-alpine AS build

WORKDIR /app

COPY package*.json ./

RUN npm ci

COPY . .

RUN npm run build


# Stage 2: Production image
FROM nginx:alpine

# Update Alpine packages to latest security fixes
RUN apk upgrade --no-cache

COPY --from=build /app/build /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
