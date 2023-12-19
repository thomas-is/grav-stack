#!/bin/sh

project=/srv/grav


# remove the X-Powered-By header
sed -e "s/expose_php = On/expose_php = Off/g" -i /etc/php81/php.ini

# set php-fpm user to grav
sed -e "s/user = nobody/user = grav/g"   -i /etc/php81/php-fpm.d/www.conf
sed -e "s/group = nobody/group = grav/g" -i /etc/php81/php-fpm.d/www.conf
# enable clear_env = no
sed -e 's/;clear_env = no/clear_env = no/g' -i /etc/php81/php-fpm.d/www.conf

if [ "$LOG_FORMAT" = "proxy" ] ; then
  sed -e "s/access_log \/dev\/stdout main;/access_log \/dev\/stdout $LOG_FORMAT;/g" -i /etc/nginx/http.d/default.conf
fi

# set grav uid and gid
usermod -u $GRAV_USER -g $GRAV_USER grav

# assign grav a random password
pass=$( N=16 ; cat /dev/urandom | tr -dc A-Za-z0-9 | head -c$N )
printf "%s\n%s\n" $pass $pass | passwd grav

# create project if $project does not exist
if [ "$( ls $project 2>/dev/null )" = "" ] ; then
  mkdir -p $project
  chown $GRAV_USER:$GRAV_USER $project
  su grav -c "composer create-project --no-interaction getgrav/grav $project"
fi

# start php-fpm
php-fpm81 --allow-to-run-as-root

echo "End of Entrypoint"

exec "$@"
