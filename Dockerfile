# build stage
FROM hub.lexoya.com/cache/library/node:16.18.1-alpine3.16 as build-stage
WORKDIR /app
COPY package*.json ./
RUN npm config set registry https://npm.iranrepo.ir/
RUN npm install
COPY . .
RUN npm run build

# production stage
FROM hub.lexoya.com/cache/library/nginx:stable-alpine as production-stage
COPY --from=build-stage /app/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
