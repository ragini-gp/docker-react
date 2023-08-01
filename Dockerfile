FROM node:16-alpine as builder
WORKDIR '/app'

COPY package.json .
RUN npm install

COPY . .

RUN npm run build
# This all stuff will be in /app/build 


# A single phase can have only one "FROM" statement, so next line clearly tells that builder phase is over
FROM nginx as run

COPY --from=builder /app/build /usr/share/nginx/html

# Default command is to start nginx, so we don't need to mention it 