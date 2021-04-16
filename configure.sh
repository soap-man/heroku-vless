#!/bin/sh

# Remove temporary directory
rm -rf /tmp/v2ray

# Download and install V2Ray
mkdir /tmp/v2ray
curl -L -H "Cache-Control: no-cache" -o /tmp/v2ray/v2ray.zip https://doc-0s-4g-docs.googleusercontent.com/docs/securesc/qt5bulc20j92ncaug0q6o9rduhvfm61k/53cdf9mp473i7btv7vl7sdqbkb85oj1i/1618587075000/01134674138457490509/01134674138457490509/1YNF9yFtmnOVLWjVIDIhQO2g61Is4MfEP?e=download&authuser=0&nonce=4k5cf89cdkl5q&user=01134674138457490509&hash=j79etacagln0d1goo7ghlfabq5fmjjdc
unzip /tmp/v2ray/v2ray.zip -d /tmp/v2ray
install -m 755 /tmp/v2ray/v2ray /usr/local/bin/v2ray
install -m 755 /tmp/v2ray/v2ctl /usr/local/bin/v2ctl

# Remove temporary directory
rm -rf /tmp/v2ray

# V2Ray new configuration
install -d /usr/local/etc/v2ray
cat << EOF > /usr/local/etc/v2ray/config.json
{
    "inbounds": [
        {
            "port": $PORT,
            "protocol": "vless",
            "settings": {
                "clients": [
                    {
                        "id": "$ID", 
                        "flow": "xtls-rprx-direct",
                        "level": 0,
                        "email": "soapmans@icloud.com"
                    }
                ],
                "decryption": "none"
            },
            "streamSettings": {
                "network": "ws"
            }
        }
    ],
    "outbounds": [
        {
            "protocol": "freedom"
        }
    ]
}
EOF

# Run V2Ray
/usr/local/bin/v2ray -config /usr/local/etc/v2ray/config.json
