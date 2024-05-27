#!/bin/sh

sudo podman pull registry.do180.lab:5000/httpd:latest

sudo podman run -d \
        --name reg-httpd \
        -p 8080:80 \
        -v /web:/usr/local/apache2/htdocs \
        registry.do180.lab:5000/httpd:Z

sudo semanage fcontext -a -t container_file_t "/web(/.*)?"
sudo restorecon -R -v /web

sudo podman generate systemd reg-httpd > reg-httpd.service
sudo mv reg-httpd.service /etc/systemd/system
# sudo podman generate systemd reg-httpd -f /etc/systemd/system/reg-httpd.service
sudo restorecon /etc/systemd/system/reg-httpd.service

sudo systemctl daemon-reload
sudo systemctl enable --now reg-httpd

# Test
curl localhost:8080