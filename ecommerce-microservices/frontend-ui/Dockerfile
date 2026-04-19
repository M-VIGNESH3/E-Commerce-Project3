FROM node:20-alpine AS build
RUN apk update && apk upgrade --no-cache
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
ARG VITE_APP_ENV=blue
ENV VITE_APP_ENV=$VITE_APP_ENV
RUN npm run build

FROM nginx:alpine
COPY --from=build /app/dist /usr/share/nginx/html
# Copy custom nginx config if we had one for client side routing
COPY nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]


