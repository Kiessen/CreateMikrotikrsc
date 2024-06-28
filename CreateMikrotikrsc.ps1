
$defaultArr = @(
($portSsh = 22),
($portTelnet = 23),
($portWww = 80),
($portWwwSsl = 443),
($portApi = 8728),
($portApiSsl = 8729),
($portFtp = 21)
)

$userInputArr = @(
("Port Ssh",$usrPortSSh),
("Port Telnet",$usrTelnet),
("Port Www",$usrPortWww),
("Port Www SSL",$usrPortWwwSsl),
("Port Api",$usrPortApi),
("Port Api SSL",$usrPortApiSsl),
("Port Ftp",$usrPortFtp)
)
Write-Output "============================================="
Write-Output "Masukan Input Port & Nama Interface"
Write-Output "============================================="
For ($x=0;$x -lt $userInputArr.length; $x++){
    Write-Output "$($userInputArr[$x][0]) : "
    if(($userInputArr[$x][1] = Read-Host "Press enter to accept default value $($defaultArr[$x])") -eq ''){$userInputArr[$x][1]=$defaultArr[$x]}
    Write-Output "-------------------------------"
}
Invoke-Expression clear
Write-Output "Daftar Port & Nama Interface"
For ($x=0;$x -lt $userInputArr.length; $x++){
    Write-Output $($userInputArr[$x][0]+" : "+$userInputArr[$x][1])
}

Read-Host -Prompt "Press any key to continue"

$script = @"
/tool mac-server
set allowed-interface-list=none
mac-winbox set allowed-interface-list=none
ping set enabled=no

/ip neighbor discovery-settings set discover-interface-list=none
/tool bandwidth-server set enabled=no
/ip dns set allow-remote-requests=no

/ip service
ssh port=$($userInputArr[0][1]) disabled=yes
telnet port=$($userInputArr[1][1]) disabled=yes
www port=$($userInputArr[2][1]) disabled=yes
www-ssl port=$($userInputArr[3][1]) disabled=yes
api port=$($userInputArr[4][1]) disabled=yes
api-ssl port=$($userInputArr[5][1]) disabled=yes
ftp port=$($userInputArr[6][1]) disabled=yes

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
add action=drop chain=input comment="drop FTP Brute Forcers" disabled=no dst-port=$($userInputArr[6][1]) protocol=tcp src-address-list=FTP_BlackList
add action=drop chain=input comment="" disabled=no dst-port=$($userInputArr[6][1]) protocol=tcp src-address-list=FTP_BlackList
add action=accept chain=output comment="" content="530 Login incorrect" disabled=no dst-limit=1/1m,9,dst-address/1m protocol=tcp
add action=add-dst-to-address-list address-list=FTP_BlackList address-list-timeout=1d chain=output comment="" content="530 Login incorrect" disabled=no protocol=tcp
add action=drop chain=input comment="drop SSH&TELNET Brute Forcers" disabled=no dst-port=$($userInputArr[0][1]),$($userInputArr[1][1]) protocol=tcp src-address-list=IP_BlackList
add action=add-src-to-address-list address-list=IP_BlackList address-list-timeout=1d chain=input comment="" connection-state=new disabled=no dst-port=$($userInputArr[0][1]),$($userInputArr[1][1]) protocol=tcp src-address-list=SSH_BlackList_3
add action=add-src-to-address-list address-list=SSH_BlackList_3 address-list-timeout=1m chain=input comment="" connection-state=new disabled=no dst-port=$($userInputArr[0][1]),$($userInputArr[1][1]) protocol=tcp src-address-list=SSH_BlackList_2
add action=add-src-to-address-list address-list=SSH_BlackList_2 address-list-timeout=1m chain=input comment="" connection-state=new disabled=no dst-port=$($userInputArr[0][1]),$($userInputArr[1][1]) protocol=tcp src-address-list=SSH_BlackList_1
add action=add-src-to-address-list address-list=SSH_BlackList_1 address-list-timeout=1m chain=input comment="" connection-state=new disabled=no dst-port=$($userInputArr[0][1]),$($userInputArr[1][1]) protocol=tcp
add action=drop chain=input comment="drop port scanners" disabled=no src-address-list=port_scanners
add action=add-src-to-address-list address-list=port_scanners address-list-timeout=2w chain=input comment="" disabled=no protocol=tcp tcp-flags=fin,!syn,!rst,!psh,!ack,!urg
add action=add-src-to-address-list address-list=port_scanners address-list-timeout=2w chain=input comment="" disabled=no protocol=tcp tcp-flags=fin,syn
add action=add-src-to-address-list address-list=port_scanners address-list-timeout=2w chain=input comment="" disabled=no protocol=tcp tcp-flags=syn,rst
add action=add-src-to-address-list address-list=port_scanners address-list-timeout=2w chain=input comment="" disabled=no protocol=tcp tcp-flags=fin,psh,urg,!syn,!rst,!ack
add action=add-src-to-address-list address-list=port_scanners address-list-timeout=2w chain=input comment="" disabled=no protocol=tcp tcp-flags=fin,syn,rst,psh,ack,urg
add action=add-src-to-address-list address-list=port_scanners address-list-timeout=2w chain=input comment="" disabled=no protocol=tcp tcp-flags=!fin,!syn,!rst,!psh,!ack,!urg
"@

$script > .\newScript.rsc
