#!/usr/bin/env bash

# Dockerfiles for php-cli
for version in php56 php70 php71 php72 php73; do
    lib="$version/cli"
    target="$lib/Dockerfile"

    cat \
        src/autogenerated \
        src/baseimage_${version}-cli \
        src/debian_base \
        src/php_extensions \
        src/php_ini_opcache \
        src/composer \
        src/workdir_with_user \
        > $target
    echo "Created $target"
done

# Dockerfiles for php-apache
for version in php56 php70 php71 php72 php73; do
    lib="$version/apache"
    target="$lib/Dockerfile"

    cp src/apache.conf $lib
    cat \
        src/autogenerated \
        src/baseimage_${version}-apache \
        src/debian_base \
        src/php_extensions \
        src/php_ini_opcache_develop \
        src/apache \
        src/composer \
        src/workdir_without_user \
        > $target

    echo "Created $target"
done

# Dockerfiles for php-cli, from PHP 7.4
for version in php74 php80 php81 php82; do
    lib="$version/cli"
    target="$lib/Dockerfile"

    cat \
        src/autogenerated \
        src/baseimage_${version}-cli \
        src/debian_base \
        src/php_extensions_${version} \
        src/php_ini_opcache \
        src/anax_cli \
        src/composer \
        src/git_config \
        src/workdir_with_user \
        > $target
    echo "Created $target"
done

# Dockerfiles for php-apache, from PHP 7.4
for version in php74 php80 php81 php82; do
    lib="$version/apache"
    target="$lib/Dockerfile"

    cp src/apache.conf $lib
    cat \
        src/autogenerated \
        src/baseimage_${version}-apache \
        src/debian_base \
        src/php_extensions_${version} \
        src/php_ini_opcache_develop \
        src/apache \
        src/anax_cli \
        src/composer \
        src/git_config \
        src/workdir_without_user \
        > $target

    echo "Created $target"
done


# Dockerfiles having pre installed Git module
# for version in php70 php71 php72; do
version="php72"
lib="$version/apache"
target="$lib/Dockerfile-clone-repo-make-install"

cp src/{apache,apache-htdocs}.conf $lib
cat \
    src/autogenerated \
    src/baseimage_${version}-apache \
    src/php_extensions \
    src/php_ini_opcache \
    src/apache-htdocs \
    src/workdir_without_user \
    src/clone_repo_make_install_production \
    > $target

    # src/with_user_root \
    # src/debian_base \
    # src/composer \
    # src/baseimage_anax-dev-${version}-apache \

echo "Created $target"
# done
