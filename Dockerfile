FROM progrium/cedarish:cedar14
MAINTAINER progrium "progrium@gmail.com"

ADD ./stack/configs/etc-profile /etc/profile

ADD ./builder/ /build
RUN xargs -L 1 /build/install-buildpack /tmp/buildpacks < /build/config/buildpacks.txt

RUN gem install foreman

# fix php buildpack, source: https://github.com/deis/heroku-buildpack-php/commit/d305d7eb5f45959b54e1b9729b0cd36685c8126d
RUN sed -i 's|^;listen.mode = 0666|listen.mode = 0666|g' /build/buildpacks/*/conf/php/php-fpm.conf

#fix php buildpack, source: https://github.com/drmikecrowe/dokku-buildpack-php/commit/00cf93c2f3a60e11f9d4e81a7c110977dbddee41
RUN mkdir /root/bin

ENV PORT 5000
EXPOSE 5000
