# The user that gets all the mails (UID < 1000, usually the admin)
root=postmaster

# The mail server (where the mail is sent to), both port 465 or 587 should be acceptable
# See also https://support.google.com/mail/answer/78799
mailhub=${SSMTP_HOST}:${SSMTP_PORT}

# The address where the mail appears to come from for user authentication.
rewriteDomain=${SSMTP_REWRITE_DOMAIN}

# The full hostname.  Must be correctly formed, fully qualified domain name or GMail will reject connection.
hostname=${SSMTP_FROM_HOSTNAME}

# Use SSL/TLS before starting negotiation
UseTLS=${SSMTP_USE_TLS}
UseSTARTTLS=${SSMTP_USE_STARLTLS}

# Username/Password
#AuthUser=${SSMTP_AUTH_USER}
#AuthPass=${SSMTP_AUTH_PASSWORD}
#AuthMethod=${SSMTP_AUTH_METHOD}

# Email 'From header's can override the default domain?
FromLineOverride=yes