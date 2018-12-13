FROM php:latest
WORKDIR /app
COPY . /app
ENV NAME sunplc
CMD php test.php
