#! /bin/sh

#PORT=8081

if [ -e "$SNAP_DATA/configured" ]; then
	exit 0
fi

while ! avahi-set-host-name dashkiosk-client 2>/dev/null; do
	echo "setup: avahi-control interface not connected, sleeping 30 for sec"
	sleep 30
done

if grep -q localhost.localdomain /etc/hostname; then
    while ! /usr/bin/hostnamectl set-hostname dashkiosk-client 2>/dev/null; do
		echo "setup: waiting for hostname-control interface, sleeping 10 sec"
		sleep 10
    done
fi

#if grep -q wlan0 /proc/net/dev; then
#    ifconfig wlan0 up
#
#    while true; do {
#        SELECT=""
#        LIST="$(iw dev wlan0 scan|grep SSID|sed 's/^.*: //')"
#        for ITEM in $LIST; do
#            SELECT="$SELECT\n<option value=\"$ITEM\">$ITEM</option>"
#        done
#        while true; do {
#            echo -e 'HTTP/1.1 200 OK\r\n'
#            cat << EOF
#<html>
#    <head>
#        <title>Network Config</title>
#    </head>
#    <body>
#         <form>
#         <h3>System Setup</h3>
#               WLAN: <select name="network">
#               $SELECT
#               </select><br>
#               Passsphrase: <input type="text" name="Key">
#         <h3>Browser Setup</h3>
#               Server IP Address:<br>
#               <input type="text" name="browserip"><br>
#               <input type="submit" value="Submit">
#         </form>
#    </body>
#</html>
#EOF
#        } | nc -l 127.0.0.1 $PORT | grep GET | sed 's/^GET \/?//;s/ HTTP.*$//'
#        done
#    }
#    done
#fi

touch $SNAP_DATA/configured
