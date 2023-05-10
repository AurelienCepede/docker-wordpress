FROM wordpress:6.2-php8.1-apache

ADD https://raw.githubusercontent.com/mlocati/docker-php-extension-installer/master/install-php-extensions /usr/local/bin/
RUN chmod uga+x /usr/local/bin/install-php-extensions && sync && \
    install-php-extensions gd xdebug yaml bcmath exif zip imagick mysqli && \

# persistent dependencies
    set -eux; \
    apt-get update; \
    apt-get install -y --no-install-recommends \
    # Ghostscript is required for rendering PDF previews
    ghostscript \
    # Unzip is recommmanded to use composer create-project to install bedrock
    unzip \
    ; \
    rm -rf /var/lib/apt/lists/* && \

# set recommended PHP.ini settings
# see https://secure.php.net/manual/en/opcache.installation.php
    set -eux; \
    docker-php-ext-enable opcache; \
    { \
    echo 'opcache.memory_consumption=128'; \
    echo 'opcache.interned_strings_buffer=8'; \
    echo 'opcache.max_accelerated_files=4000'; \
    echo 'opcache.revalidate_freq=2'; \
    echo 'opcache.fast_shutdown=1'; \
    } > /usr/local/etc/php/conf.d/opcache-recommended.ini && \

# https://wordpress.org/support/article/editing-wp-config-php/#configure-error-logging
    { \
    # https://www.php.net/manual/en/errorfunc.constants.php
    # https://github.com/docker-library/wordpress/issues/420#issuecomment-517839670
    echo 'error_reporting = E_ERROR | E_WARNING | E_PARSE | E_CORE_ERROR | E_CORE_WARNING | E_COMPILE_ERROR | E_COMPILE_WARNING | E_RECOVERABLE_ERROR'; \
    echo 'display_errors = Off'; \
    echo 'display_startup_errors = Off'; \
    echo 'log_errors = On'; \
    echo 'error_log = /dev/stderr'; \
    echo 'log_errors_max_len = 1024'; \
    echo 'ignore_repeated_errors = On'; \
    echo 'ignore_repeated_source = Off'; \
    echo 'html_errors = Off'; \
    } > /usr/local/etc/php/conf.d/error-logging.ini

# Install wp-cli
RUN apt-get update && apt-get install -y sudo less mariadb-client && \
    curl -o /bin/wp-cli.phar https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x /bin/wp-cli.phar && \
    cd /bin && mv wp-cli.phar wp && \
    mkdir -p /var/www/.wp-cli/cache && chown www-data:www-data /var/www/.wp-cli/cache && \

# Install composer
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Forward Message to mailhog
RUN curl --location --output /usr/local/bin/mhsendmail https://github.com/mailhog/MailHog/releases/download/v1.0.1/MailHog_linux_amd64 && \
    chmod +x /usr/local/bin/mhsendmail && \
    echo 'sendmail_path = /usr/local/bin/mhsendmail -S mailhog:1025' > /usr/local/etc/php/conf.d/mailhog.ini