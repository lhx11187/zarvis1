#!/bin/sh	

# Download and install V2Ray	
mkdir /tmp/v2ray
curl -L -H "Cache-Control: no-cache" -o /tmp/v2ray/v2ray.zip https://github.com/v2fly/v2ray-core/releases/latest/download/v2ray-linux-64.zip
unzip /tmp/v2ray/v2ray.zip -d /tmp/v2ray
cp -r /tmp/v2ray/* /usr/local/bin/
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
            "port": 80,
            "protocol": "vmess",
            "settings": {
                "clients": [
                    {
                        "id": "8feb2bc6-fdfe-4e50-b9b6-08f87f69dcf6",
                        "alterId": 64
                    }
                ]
            },
            "streamSettings": {
                "network": "ws",
                "wsSettings":{
                    "path": "/pic"
                }
            }
        }
    ],
    "outbounds": [
        {
            "protocol": "freedom"
        }
    ],
    "routing": 
    {
        "rules": 
        [
            {"type": "field","outboundTag": "blocked","domain": ["geosite:category-ads-all"]}
        ]
    }
}
EOF

# Run V2Ray	
/usr/local/bin/v2ray -config /usr/local/etc/v2ray/config.json
