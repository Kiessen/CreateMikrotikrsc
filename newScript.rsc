/tool mac-server
set allowed-interface-list=none
mac-winbox set allowed-interface-list=none

/ip service
ssh port=22
telnet port=23
www port=80
www-ssl port=443
api port=8728
api-ssl port=8729
ftp port=21

/ip neighbor discovery-settings set discover-interface-list=none

/tool bandwidth-server set enabled=no
/ip dns set allow-remote-requests=no

/ip proxy set enabled=no
/ip socks set enabled=no
/ip upnp set enabled=no
/ip cloud set ddns-enabled=no update-time=no


/ip firewall filter
add chain=forward connection-state=established comment="allow established connections"
add chain=forward connection-state=related comment="allow related connections"
add chain=forward connection-state=invalid action=drop comment="drop invalid connections"

add chain=virus protocol=tcp dst-port=135-139 action=drop comment="Drop Blaster Worm" disabled=no
add chain=virus protocol=udp dst-port=135-139 action=drop comment="Drop Messenger Worm" disabled=no
add chain=virus protocol=tcp dst-port=445 action=drop comment="Drop Blaster Worm" disabled=no
add chain=virus protocol=udp dst-port=445 action=drop comment="Drop Conficker Worm" disabled=no
add chain=virus protocol=tcp dst-port=593 action=drop comment="Drop Kido Worm" disabled=no
add chain=virus protocol=tcp dst-port=1024-1030 action=drop comment="________" disabled=no
add chain=virus protocol=tcp dst-port=1080 action=drop comment="Drop MyDoom" disabled=no
add chain=virus protocol=tcp dst-port=1214 action=drop comment="________" disabled=no
add chain=virus protocol=tcp dst-port=1363 action=drop comment="ndm requester" disabled=no
add chain=virus protocol=tcp dst-port=1364 action=drop comment="ndm server" disabled=no
add chain=virus protocol=tcp dst-port=1368 action=drop comment="screen cast" disabled=no
add chain=virus protocol=tcp dst-port=1373 action=drop comment="hromgrafx" disabled=no
add chain=virus protocol=tcp dst-port=1377 action=drop comment="cichlid" disabled=no
add chain=virus protocol=tcp dst-port=1433-1434 action=drop comment="Worm" disabled=no
add chain=virus protocol=tcp dst-port=2745 action=drop comment="Bagle Virus" disabled=no
add chain=virus protocol=tcp dst-port=2283 action=drop comment="Drop Dumaru.Y" disabled=no
add chain=virus protocol=tcp dst-port=2535 action=drop comment="Drop Beagle" disabled=no
add chain=virus protocol=tcp dst-port=2745 action=drop comment="Drop Beagle.C-K" disabled=no
add chain=virus protocol=tcp dst-port=3127-3128 action=drop comment="Drop MyDoom" disabled=no
add chain=virus protocol=tcp dst-port=3410 action=drop comment="Drop Backdoor OptixPro" disabled=no
add chain=virus protocol=tcp dst-port=4444 action=drop comment="Worm" disabled=no
add chain=virus protocol=udp dst-port=4444 action=drop comment="Worm" disabled=no
add chain=virus protocol=tcp dst-port=5554 action=drop comment="Drop Sasser" disabled=no
add chain=virus protocol=tcp dst-port=8866 action=drop comment="Drop Beagle.B" disabled=no
add chain=virus protocol=tcp dst-port=9898 action=drop comment="Drop Dabber.A-B" disabled=no
add chain=virus protocol=tcp dst-port=10000 action=drop comment="Drop Dumaru.Y" disabled=no
add chain=virus protocol=tcp dst-port=10080 action=drop comment="Drop MyDoom.B" disabled=no
add chain=virus protocol=tcp dst-port=12345 action=drop comment="Drop NetBus" disabled=no
add chain=virus protocol=tcp dst-port=17300 action=drop comment="Drop Kuang2" disabled=no
add chain=virus protocol=tcp dst-port=27374 action=drop comment="Drop SubSeven" disabled=no
add chain=virus protocol=tcp dst-port=65506 action=drop comment="Drop PhatBot, Agobot, Gaobot" disabled=no
add chain=virus protocol=udp dst-port=12667 action=drop comment="Trinoo" disabled=no
add chain=virus protocol=udp dst-port=27665 action=drop comment="Trinoo" disabled=no
add chain=virus protocol=udp dst-port=31335 action=drop comment="Trinoo" disabled=no
add chain=virus protocol=tcp dst-port=31335 action=drop comment="Trinoo" disabled=no
add chain=virus protocol=udp dst-port=27444 action=drop comment="Trinoo" disabled=no
add chain=virus protocol=tcp dst-port=34555 action=drop comment="Trinoo" disabled=no
add chain=virus protocol=udp dst-port=34555 action=drop comment="Trinoo" disabled=no
add chain=virus protocol=tcp dst-port=35555 action=drop comment="Trinoo" disabled=no
add chain=virus protocol=udp dst-port=35555 action=drop comment="Trinoo" disabled=no
add chain=virus protocol=tcp dst-port=27444 action=drop comment="Trinoo" disabled=no
add chain=virus protocol=tcp dst-port=27665 action=drop comment="Trinoo" disabled=no
add chain=virus protocol=tcp dst-port=31846 action=drop comment="Trinoo" disabled=no


add chain=forward action=jump jump-target=virus comment="jump to the virus chain"

add action=drop chain=forward comment=";;Block W32.Kido - Conficker" disabled=no protocol=udp src-port=135-139,445
add action=drop chain=forward comment="" disabled=no dst-port=135-139,445 protocol=udp
add action=drop chain=forward comment="" disabled=no protocol=tcp src-port=135-139,445,593
add action=drop chain=forward comment="" disabled=no dst-port=135-139,445,593 protocol=tcp
add action=accept chain=input comment="Allow limited pings" disabled=no limit=50/5s,2 protocol=icmp
add action=accept chain=input comment="" disabled=no limit=50/5s,2 protocol=icmp
add action=drop chain=input comment="drop FTP Brute Forcers" disabled=no dst-port=21 protocol=tcp src-address-list=FTP_BlackList
add action=drop chain=input comment="" disabled=no dst-port=21 protocol=tcp src-address-list=FTP_BlackList
add action=accept chain=output comment="" content="530 Login incorrect" disabled=no dst-limit=1/1m,9,dst-address/1m protocol=tcp
add action=add-dst-to-address-list address-list=FTP_BlackList address-list-timeout=1d chain=output comment="" content="530 Login incorrect" disabled=no protocol=tcp
add action=drop chain=input comment="drop SSH&TELNET Brute Forcers" disabled=no dst-port=22,23 protocol=tcp src-address-list=IP_BlackList
add action=add-src-to-address-list address-list=IP_BlackList address-list-timeout=1d chain=input comment="" connection-state=new disabled=no dst-port=22,23 protocol=tcp src-address-list=SSH_BlackList_3
add action=add-src-to-address-list address-list=SSH_BlackList_3 address-list-timeout=1m chain=input comment="" connection-state=new disabled=no dst-port=22,23 protocol=tcp src-address-list=SSH_BlackList_2
add action=add-src-to-address-list address-list=SSH_BlackList_2 address-list-timeout=1m chain=input comment="" connection-state=new disabled=no dst-port=22,23 protocol=tcp src-address-list=SSH_BlackList_1
add action=add-src-to-address-list address-list=SSH_BlackList_1 address-list-timeout=1m chain=input comment="" connection-state=new disabled=no dst-port=22,23 protocol=tcp
add action=drop chain=input comment="drop port scanners" disabled=no src-address-list=port_scanners
add action=add-src-to-address-list address-list=port_scanners address-list-timeout=2w chain=input comment="" disabled=no protocol=tcp tcp-flags=fin,!syn,!rst,!psh,!ack,!urg
add action=add-src-to-address-list address-list=port_scanners address-list-timeout=2w chain=input comment="" disabled=no protocol=tcp tcp-flags=fin,syn
add action=add-src-to-address-list address-list=port_scanners address-list-timeout=2w chain=input comment="" disabled=no protocol=tcp tcp-flags=syn,rst
add action=add-src-to-address-list address-list=port_scanners address-list-timeout=2w chain=input comment="" disabled=no protocol=tcp tcp-flags=fin,psh,urg,!syn,!rst,!ack
add action=add-src-to-address-list address-list=port_scanners address-list-timeout=2w chain=input comment="" disabled=no protocol=tcp tcp-flags=fin,syn,rst,psh,ack,urg
add action=add-src-to-address-list address-list=port_scanners address-list-timeout=2w chain=input comment="" disabled=no protocol=tcp tcp-flags=!fin,!syn,!rst,!psh,!ack,!urg
