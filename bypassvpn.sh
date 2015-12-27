#!/bin/bash
#for OSX
set -u

#hostnames to be by passed by vpn
dnses=(
  douban.fm
  www.duokan.com
  www.jd.com
  wx.qq.com
)

function dnsToIPs() {
    ips=`dig $1| awk '/ANSWER SECTION:/ {flag=1;next} /AUTHORITY SECTION:/ {flag=0} flag && $4=="A" {print $5}'`
    echo $ips
}

gw=`netstat -rn | grep  default | grep -v utun | awk '{print $2}' 2>/dev/null`

for dns in "${dnses[@]}";do
    for ip in `dnsToIPs $dns`; do
        echo -n "set routing: $dns($ip) to $gw ..."
        if route -nv add $ip $gw >/dev/null 2>&1; then
            echo "ok"
        else
            echo "failed"
        fi
    done
done
