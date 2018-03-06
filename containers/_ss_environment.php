<?php

$envvars = array(
    'SS_ENVIRONMENT_TYPE',
    'SS_DATABASE_SERVER',
    'SS_DATABASE_USERNAME',
    'SS_DATABASE_PASSWORD',
    'SS_DATABASE_NAME',
    'SS_DEFAULT_ADMIN_USERNAME',
    'SS_DEFAULT_ADMIN_PASSWORD',
    'SS_DATABASE_CHOOSE_NAME',
);

foreach($envvars as $ENVVAR) {
    if($v = getenv($ENVVAR)) {
        define($ENVVAR, $v);
    }
}

// This is used by sake to know which directory points to which URL
global $_FILE_TO_URL_MAPPING;
$_FILE_TO_URL_MAPPING['/var/www/html'] = 'http://localhost';
