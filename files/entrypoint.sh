#!/bin/bash

DOCKERIZE="/usr/local/bin/dockerize"
TEMPLATE_PARAM="/opt/gophish/config.tmpl:/opt/gophish/config.json"
DOCKERIZE_PARAM=""

if [[ "$DB_DRIVER" == "mysql" ]]
then
	test -n "$DB_TIMEOUT" && db_timeout="$DB_TIMEOUT" || db_timeout="30"
	test -n "$DB_HOST" && host=$DB_HOST || host="db"
	test -n "$DB_PORT" && port=$DB_PORT || port="3306"
	DB_PARAM="-wait tcp://${host}:${port} -timeout ${db_timeout}s"
else
	DB_PARAM=""
fi


DOCKERIZE_PARAM="$DB_PARAM -template $TEMPLATE_PARAM /opt/gophish/gophish $GOPHISH_PARAMETER"

$DOCKERIZE $DOCKERIZE_PARAM
