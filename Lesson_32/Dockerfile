FROM ubuntu:20.04

ARG USERNAME

ENV ENV_USERNAME $USERNAME

RUN apt-get update && apt-get install -y nginx

EXPOSE 80

WORKDIR /var/www/html

RUN echo "the test is run by $ENV_USERNAME" > index.html

CMD ["nginx", "-g", "daemon off;"]
