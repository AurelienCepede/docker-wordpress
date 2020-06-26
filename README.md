# Docker archi for wordpress

- Apache
- Php 7.2
- MySQL
- PhpMyAdmin
- Wordpress
- MailHog

## Requirements

- Docker ([get Docker](https://docs.docker.com/get-docker/))
- Docker-Compose ([instructions to install Docker-Compose](https://docs.docker.com/compose/install/))

## Steps to launch the stack

- Modify .env file to configure your database
- You can modify config/php-config.ini file to configure some variables of php.ini
- If you want to use Nginx or another version of php change the image tag at first line of the dockerfile ([all tags](https://hub.docker.com/_/wordpress/))
- Use docker-compose up -d to pull and mount all the stack


## Links

- wordpress website : http://localhost
- phpmyadmin : http://localhost:8080
- mailhog : http://localhost:8025
