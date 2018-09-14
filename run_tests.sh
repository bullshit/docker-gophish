#!/bin/bash

COMMAND="docker run -v $(pwd)/files/config.tmpl:/tmp/config.tmpl"
IMAGE="jwilder/dockerize:latest"
ARGUMENT="-template /tmp/config.tmpl"

function execute() {
	local testname=$1
	local testparam=$2
	local expectedFile=$3

	CMD="${COMMAND} ${testparam} ${IMAGE} ${ARGUMENT}"
	got=`$CMD | jq -S .`
	expected=`jq -S . "$expectedFile"`

	diff <(echo "$expected" ) <(echo "$got")
	if [ $? -eq 1 ]; then
		echo "ERROR: $testname"
		exit 1
	else
		echo "PASSED: $testname"
	fi
}

####################################################################
#
# TESTCASES
#
####################################################################

TESTCASE_01_PARAM="-e CONTACT_ADDRESS=user@host.tld"
execute "TESTCASE-01" "$TESTCASE_01_PARAM" "./tests/testcase_01_expected.json"


PHISING_PARAM="-e CONTACT_ADDRESS=phising@example.tld"

#TESTCASE_XX_PARAM="$PHISING_PARAM -e "
#execute "TESTCASE-XX" "$TESTCASE_XX_PARAM" "./tests/testcase_XX_expected.json"

TESTCASE_02_PARAM="$PHISING_PARAM -e DB_DRIVER=mysql -e DB_USER=gophish -e DB_PASS=passme"
execute "TESTCASE-02" "$TESTCASE_02_PARAM" "./tests/testcase_02_expected.json"

TESTCASE_03_PARAM="$PHISING_PARAM -e DB_DRIVER=mysql -e DB_PASS=passme -e DB_HOST=mysql.local"
execute "TESTCASE-03" "$TESTCASE_03_PARAM" "./tests/testcase_03_expected.json"

TESTCASE_04_PARAM="$PHISING_PARAM -e DB_DRIVER=mysql -e DB_PASS=passme -e DB_PORT=12345"
execute "TESTCASE-04" "$TESTCASE_04_PARAM" "./tests/testcase_04_expected.json"

TESTCASE_05_PARAM="$PHISING_PARAM -e ADMIN_SERVER_URL=192.168.0.1:4444"
execute "TESTCASE-05" "$TESTCASE_05_PARAM" "./tests/testcase_05_expected.json"

TESTCASE_06_PARAM="$PHISING_PARAM -e PHISH_SERVER_URL=192.168.10.1:8080"
execute "TESTCASE-06" "$TESTCASE_06_PARAM" "./tests/testcase_06_expected.json"

TESTCASE_07_PARAM="$PHISING_PARAM -e PHISH_TLS=true -e PHISH_CERT_FILE=example.crt -e PHISH_KEY_FILE=example.key"
execute "TESTCASE-07" "$TESTCASE_07_PARAM" "./tests/testcase_07_expected.json"

TESTCASE_08_PARAM="$PHISING_PARAM -e ADMIN_TLS=true -e ADMIN_CERT_FILE=admin.crt -e ADMIN_KEY_FILE=admin.key"
execute "TESTCASE-08" "$TESTCASE_08_PARAM" "./tests/testcase_08_expected.json"

TESTCASE_09_PARAM="$PHISING_PARAM -e ADMIN_SERVER_URL=192.168.0.1:4444 -e ADMIN_TLS=true -e ADMIN_CERT_FILE=admin.crt -e ADMIN_KEY_FILE=admin.key"
execute "TESTCASE-09" "$TESTCASE_09_PARAM" "./tests/testcase_09_expected.json"

TESTCASE_10_PARAM="$PHISING_PARAM -e PHISH_SERVER_URL=192.168.10.1:8080 -e PHISH_TLS=true -e PHISH_CERT_FILE=example.crt -e PHISH_KEY_FILE=example.key "
execute "TESTCASE-10" "$TESTCASE_10_PARAM" "./tests/testcase_10_expected.json"

TESTCASE_11_PARAM="$PHISING_PARAM -e DB_DRIVER=sqlite -e DB_FILE=example.db"
execute "TESTCASE-11" "$TESTCASE_11_PARAM" "./tests/testcase_11_expected.json"
