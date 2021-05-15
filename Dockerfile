FROM node:alpine as builder
WORKDIR '/app'
RUN chown -R node:node /app
COPY --chown=node:node package.json .
RUN npm install
COPY --chown=node:node . .
USER node
RUN npm run build

FROM nginx
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html