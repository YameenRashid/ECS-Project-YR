#Stage 1: Build Stage
FROM node:20-alpine AS build

WORKDIR /app

COPY package.json yarn.lock ./

RUN yarn install

COPY . .

RUN yarn build


#Stage 2: Production Stage
FROM nginx:alpine

COPY --from=build /app/build /usr/share/nginx/html

COPY nginx.conf /etc/nginx/conf.d/default.conf

RUN addgroup -S appgroup && adduser -S appuser -G appgroup && \
    chown -R appuser:appgroup /var/cache/nginx && \
    chown -R appuser:appgroup /var/run && \
    chown -R appuser:appgroup /var/log/nginx && \
    chown -R appuser:appgroup /run
    
RUN touch /var/run/nginx.pid && \
    chown -R appuser:appgroup /var/run/nginx.pid
    
USER appuser

EXPOSE 8080

CMD ["nginx", "-g", "daemon off;"]