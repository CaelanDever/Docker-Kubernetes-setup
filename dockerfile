FROM nginx:alpine
COPY index.html /usr/share/nginx/html/
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Docker WebApp</title>
</head>
<body>
    <h1>Welcome to the Docker Web Application!</h1>
    <p>This application is served using Docker and Nginx.</p>
    <p>Docker simplifies the deployment and scaling of applications.</p>
    <p>Enjoy exploring Docker!</p>
</body>
</html>
