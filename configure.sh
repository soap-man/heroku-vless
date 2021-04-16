#!/bin/sh

# Download and install V2Ray
mkdir /tmp/v2ray
curl -L -H "Cache-Control: no-cache" -o /tmp/v2ray/v2ray.zip https://github.com/v2fly/v2ray-core/releases/latest/download/v2ray-linux-64.zip
unzip /tmp/v2ray/v2ray.zip -d /tmp/v2ray
install -m 755 /tmp/v2ray/v2ray /usr/local/bin/v2ray
install -m 755 /tmp/v2ray/v2ctl /usr/local/bin/v2ctl

# Remove temporary directory
rm -rf /tmp/v2ray

# V2Ray new configuration
install -d /usr/local/etc/v2ray
cat << EOF > /usr/local/etc/v2ray/config.json
{
  "outbound": {
    "streamSettings": null,
    "tag": null,
    "protocol": "freedom",
    "mux": null,
    "settings": null
  },
  "inboundDetour": null,
  "inbound": {
    "streamSettings": {
      "network": "ws",
      "kcpSettings": null,
      "wsSettings": {
        "headers": {
          "host": "heroku-sunset-cf93.soapmans.workers.dev"
        },
        "path": ""
      },
      "tcpSettings": null,
      "tlsSettings": {},
      "security": ""
    },
    "listen": null,
    "protocol": "vmess",
    "port": 5888,
    "settings": {
      "ip": null,
      "udp": true,
      "clients": [
        {
          "alterId": 100,
          "security": "aes-128-gcm",
          "id": "163b3ae0-29ba-4c02-bfae-0e07465a2466"
        }
      ],
      "auth": null
    }
  },
  "outboundDetour": [
    {
      "tag": "blocked",
      "protocol": "blackhole",
      "settings": null
    }
  ],
  "routing": {
    "strategy": "rules",
    "settings": {
      "rules": [
        {
          "ip": [
            "0.0.0.0/8",
            "10.0.0.0/8",
            "100.64.0.0/10",
            "127.0.0.0/8",
            "169.254.0.0/16",
            "172.16.0.0/12",
            "192.0.0.0/24",
            "192.0.2.0/24",
            "192.168.0.0/16",
            "198.18.0.0/15",
            "198.51.100.0/24",
            "203.0.113.0/24",
            "::1/128",
            "fc00::/7",
            "fe80::/10"
          ],
          "domain": null,
          "type": "field",
          "port": null,
          "outboundTag": "blocked"
        }
      ],
      "domainStrategy": null
    }
  },
  "dns": null
}
EOF

# Run V2Ray
/usr/local/bin/v2ray -config /usr/local/etc/v2ray/config.json
