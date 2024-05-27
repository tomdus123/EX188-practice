<pre>
sudo dnf install podman -y
sudo vim /etc/containers/registries.conf
...
unqualified-search-registries = ["registry.do180.lab:5000", "registry.access.redhat.com", "registry.redhat.io", "docker.io"]
...
[[registry]]
prefix="*.do180.lab"
insecure=true

</pre>

$ podman info -f json | jq '.registries["search"]' 