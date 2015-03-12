# Although not a supported configuration you can use apache to proxy kimchi traffic.
# Here is an example of the required configuration.
# This requires the following apache modules be enabled:
# - mod_proxy
# - mod_proxy_http
# - mod_ssl
# The port 80 redirect also requires mod_redirect
# HTTP STS (Strict Transport Security) also requires mod_headers
<VirtualHost *:443>
        ServerName kimchi

        SSLEngine On
        SSLCertificateFile /etc/kimchi/kimchi-cert.pem
        SSLCertificateKeyFile /etc/kimchi/kimchi-key.pem

        ProxyRequests On
        ProxyPass / http://127.0.0.1:8010/
        ProxyPassReverse / http://127.0.0.1:8010/

        <Proxy http://127.0.0.1:8010/>
                Require all granted
        </Proxy>

        # HTTP STS
        Header always set Strict-Transport-Security "max-age=31536000; includeSubdomains;"
</VirtualHost>

<VirtualHost *:80>
        ServerName kimchi

        Redirect / https://kimchi/

        # HTTP STS
        Header always set Strict-Transport-Security "max-age=31536000; includeSubdomains;"
</VirtualHost>
