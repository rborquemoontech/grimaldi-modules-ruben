FROM node:20.11.1-bullseye AS build
ARG BRANCH
ARG NPM_TOKEN
 
WORKDIR /build
 
COPY package*.json ./
 
RUN npm config set -- //git.moon.tech.nom.es/:_authToken=$NPM_TOKEN && \
    npm config set @moontech:registry https://git.moon.tech.nom.es/api/v4/packages/npm/ && \
    npm ci
 
 
COPY . .
 
RUN npm run build && \
    date +"%Y/%m/%d %H:%M:%S $BRANCH" > /build/dist/ruben/buildtime.txt
 
FROM scratch
COPY --from=build /build/dist/ruben /dist