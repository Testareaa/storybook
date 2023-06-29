FROM node:lts-alpine3.18 as build-prod
WORKDIR /usr/src/app
COPY /package.json /yarn.lock ./
RUN yarn
COPY ./ ./
RUN yarn build

FROM nginx:stable-alpine3.17-slim
COPY --from=build-prod /usr/src/app/build /usr/share/nginx/html
EXPOSE 80