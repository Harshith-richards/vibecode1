FROM node:20 AS build
WORKDIR /app
COPY . .
RUN npm ci && npm run build

FROM nginx:1.27
COPY --from=build /app/dist /usr/share/nginx/html
