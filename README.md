## Build the image
docker build -t mooqr .

## Run it
docker run --env ROOT_URL=http://xxx.xxx --env MONGO_URL=mongodb://xxx/xxx -p 80:80 mooqr


