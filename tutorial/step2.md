### Creating the Docker container
You will have noticed that there is also a Dockerfile present in the directory. This is where we enter the configuration in order to host the server inside a docker container. Please edit this file in order to set up the container, the contents should look like:
```bash
# Dockerfile
FROM node:20-alpine

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .

EXPOSE 3000

CMD ["node", "app.mjs"]
```
- The first line specifies that we want to use the node image alpine of version 20. Alpine Linux are small distribution base images which can host our server without taking up much space
- Next we specify the working directory
- We then copy the package files into the directory and install all dependencies
- The `COPY . . ` command copies all files from the host system into the image
- Finally we expose port 3000 to let Docker know which port the container should listen on. The `CMD` command will be executed when the container is running.

Now, let's build the docker image. The `-t` option is used to tag our image, which let's us recognise the image later on:
```bash
docker build -t express-app .
```
You can see the image by running:
```bash
docker images
```

### Spinning up the container
Now let's spin up the container and test the application
```bash
docker run -d -p 80:3000 --name express-app express-app
```
- `-d` flag to run in detached mode
- `-p` to specify that docker should map the host port 3000 to port 80 in the container

After running this command you should see an output in the terminal, this is the ID of your running image. Let's test it: Press `Check` and see if the docker image has been correctly configured.