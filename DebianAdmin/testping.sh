#!/bin/bash

#****************************************
# Script pout tester la connexion reseau
# suite de ping
# ecrit par Nicolas Ravit
#****************************************

# on initie une varible 'total' a '0' pour savoir combien de test son concluants
total=0
total6=0

echo "Adresse IP :"
ip a show dev ens192
echo "_________________________________________"

#****************************************
# chaque test on fais un ping sur une adresse IP
# si il est bon alors on cree sa propre varible
# et on incremente la variable 'total' de '+1'
#****************************************

#adresse IP d'un PC sur le vlan 10 (lui-même)
ping -c 1 10.1.10.100
if [[ ${?} == 0 ]]
then 
pc=1
total=$((total+1))
fi

#passerelle vlan 10
ping -c 1 10.1.10.254
if [[ ${?} == 0 ]]
then 
passerel10=1
total=$((total+1))
fi

#passerelle vlan 20
ping -c 1 10.1.20.254
if [[ ${?} == 0 ]]
then 
passerel20=1
total=$((total+1))
fi

#passerelle vlan 30
ping -c 1 10.1.30.254
if [[ ${?} == 0 ]]
then 
passerel30=1
total=$((total+1))
fi

#passerelle vlan 40
ping -c 1 10.1.40.254
if [[ ${?} == 0 ]]
then 
passerel40=1
total=$((total+1))
fi

#passerelle vlan 50
ping -c 1 10.1.50.254
if [[ ${?} == 0 ]]
then 
passerel50=1
total=$((total+1))
fi

#adresse IP switch cote switch/routeur Gi0/14
ping -c 1 10.1.0.1
if [[ ${?} == 0 ]]
then 
passerel0=1
total=$((total+1))
fi

#adresse IP du DNS
ping -c 1 srvdns    #10.1.40.15
if [[ ${?} == 0 ]]
then 
dns=1
total=$((total+1))
fi

#adresse dans /etc/hosts
#ici 10.1.20.11
ping -c 1 srvdns
if [[ ${?} == 0 ]]
then 
pcnom=1
total=$((total+1))
fi

#adresse IP routeur Fa0/1 (interne)
ping -c 1 10.1.0.254
if [[ ${?} == 0 ]]
then 
routerint=1
total=$((total+1))
fi

#adresse IP routeur Fa0/0 (externe)
#ping -c 1 192.168.141.2
#if [[ ${?} == 0 ]]
#then 
#routerext=1
#total=$((total+1))
#fi

#adresse IP DNS google
ping -c 1 www.google.com
if [[ ${?} == 0 ]]
then 
google=1
total=$((total+1))
fi

#adresse IP tunnel gre cote Valence
ping -c 1 10.0.12.2
if [[ ${?} == 0 ]]
then 
vpn=1
total=$((total+1))
fi

#adresse IP pc-val-1
ping -c 1 Pc-Val-1 #10.2.10.1
if [[ ${?} == 0 ]]
then 
pcval=1
total=$((total+1))
fi

#***** PARTIE IPv6 *****#

#adresse IP d'un PC sur le vlan 10
ping -c 1 2001:470:c84c:8100::100
if [[ ${?} == 0 ]]
then 
pc6=1
total6=$((total6+1))
fi
#passerelle vlan 10
ping -c 1 2001:470:c84c:8100::1
if [[ ${?} == 0 ]]
then
passerel106=1
total6=$((total6+1))
fi
#passerelle vlan 20
ping -c 1 2001:470:c84c:8200::1
if [[ ${?} == 0 ]]
then
passerel206=1
total6=$((total6+1))
fi
#passerelle vlan 30
ping -c 1 2001:470:c84c:8300::1
if [[ ${?} == 0 ]]
then
passerel306=1
total6=$((total6+1))
fi
#passerelle vlan 40
ping -c 1 2001:470:c84c:8400::1
if [[ ${?} == 0 ]]
then
passerel406=1
total6=$((total6+1))
fi
#passerelle vlan 50
ping -c 1 2001:470:c84c:8500::1
if [[ ${?} == 0 ]]
then
passerel506=1
total6=$((total6+1))
fi
#adresse IP switch cote switch/routeur Gi0/14
ping -c 1 2001:470:c84c:8000::2
if [[ ${?} == 0 ]]
then
passerel06=1
total6=$((total6+1))
fi
#adresse IP du DNS
ping -c 1 2001:470:c84c:8400::15
if [[ ${?} == 0 ]]
then
dns6=1
total6=$((total6+1))
fi
#adresse dans /etc/hosts

ping6 -c 1 srvdns
if [[ ${?} == 0 ]]
then
pcnom6=1
total6=$((total6+1))
fi
#adresse IP routeur Fa0/1 (interne)
ping -c 1 2001:470:c84c:8000::1
if [[ ${?} == 0 ]]
then
routerint6=1
total6=$((total6+1))
fi
#adresse IP routeur Fa0/0 (externe)
#ping -c 1 2001:470:c84c:7:5e5e:abff:fe96:5980
#if [[ ${?} == 0 ]]
#then
#routerext6=1
#total6=$((total6+1))
#fi


#adresse IP DNS google
ping -c 1 2001:4860:4860::8888
if [[ ${?} == 0 ]]
then
google6=1
total6=$((total6+1))
fi

#adresse IP tunnel gre cote Valence
ping -c 1 2001:470:c84c:87ff::2
if [[ ${?} == 0 ]]
then 
vpn6=1
total6=$((total6+1))
fi

#adresse IP pc-val-1
ping6 -c 1 Pc-Val-1
if [[ ${?} == 0 ]]
then 
pcval6=1
total6=$((total6+1))
fi


#******************************************************

echo ""
echo -e "tests \t\t\t\t IPv4 \t IPv6"
echo "______________________________________________"

#****************************************
# une fois tous les tests finalise
# on test leurs variable individuelle
# si il est bon on marque OK sinon NON OK
#****************************************

if [[ $pc == 1 ]]
then
	if [[ $pc6 == 1 ]]
	then
	echo -e "ping lui-meme \t\t\t OK \t OK"
	else
	echo -e "ping lui-meme \t\t\t OK \t NON"
	fi
else
	if [[ $pc6 == 1 ]]
	then
	echo -e "ping lui-meme \t\t\t OK \t OK"
	else
	echo -e "ping lui-meme \t\t\t OK \t NON"
	fi
fi

if [[ $passerel10 == 1 ]]
then
	if [[ $passerel106 == 1 ]]
	then
	echo -e "ping passerelle vlan 10 \t OK \t OK"
	else
	echo -e "ping passerelle vlan 10 \t OK \t NON"
	fi
else
	if [[ $passerel106 == 1 ]]
        then
        echo -e "ping passerelle vlan 10 \t NON \t OK"
        else
        echo -e "ping passerelle vlan 10 \t NON \t NON"
        fi
fi

if [[ $passerel20 == 1 ]]
then
	if [[ $passerel206 == 1 ]]
	then
	echo -e "ping passerelle vlan 20 \t OK \t OK"
	else
	echo -e "ping passerelle vlan 20 \t OK \t NON"
	fi
else
	if [[ $passerel206 == 1 ]]
        then
        echo -e "ping passerelle vlan 20 \t NON \t OK"
        else
        echo -e "ping passerelle vlan 20 \t NON \t NON"
        fi
fi

if [[ $passerel30 == 1 ]]
then
	if [[ $passerel306 == 1 ]]
        then
        echo -e "ping passerelle vlan 30 \t OK \t OK"
        else
        echo -e "ping passerelle vlan 30 \t OK \t NON"
        fi
else
	if [[ $passerel306 == 1 ]]
        then
        echo -e "ping passerelle vlan 30 \t NON \t OK"
        else
        echo -e "ping passerelle vlan 30 \t NON \t NON"
        fi
fi

if [[ $passerel40 == 1 ]]
then
	if [[ $passerel406 == 1 ]]
        then
        echo -e "ping passerelle vlan 40 \t OK \t OK"
        else
        echo -e "ping passerelle vlan 40 \t OK \t NON"
        fi
else
	if [[ $passerel406 == 1 ]]
        then
        echo -e "ping passerelle vlan 40 \t NON \t OK"
        else
        echo -e "ping passerelle vlan 40 \t NON \t NON"
        fi
fi

if [[ $passerel50 == 1 ]]
then
	if [[ $passerel506 == 1 ]]
        then
        echo -e "ping passerelle vlan 50 \t OK \t OK"
        else
        echo -e "ping passerelle vlan 50 \t OK \t NON"
        fi
else
	if [[ $passerel506 == 1 ]]
        then
        echo -e "ping passerelle vlan 50 \t NON \t OK"
        else
        echo -e "ping passerelle vlan 50 \t NON \t NON"
        fi
fi

if [[ $passerel0 == 1 ]]
then
	if [[ $passerel06 == 1 ]]
        then
        echo -e "ping passerelle switch/router \t OK \t OK"
        else
        echo -e "ping passerelle switch/router \t OK \t NON"
        fi
else
        if [[ $passerel06 == 1 ]]
        then
        echo -e "ping passerelle switch/router \t NON \t OK"
        else
        echo -e "ping passerelle switch/router \t NON \t NON"
        fi
fi

if [[ $dns == 1 ]]
then
        if [[ $dns6 == 1 ]]
        then
        echo -e "ping serveur DNS \t\t OK \t OK"
        else
        echo -e "ping serveur DNS \t\t OK \t NON"
        fi
else
        if [[ $dns6 == 1 ]]
        then
        echo -e "ping serveur DNS \t\t NON \t OK"
        else
        echo -e "ping serveur DNS \t\t NON \t NON"
        fi
fi

if [[ $pcnom == 1 ]]
then
        if [[ $pcnom6 == 1 ]]
        then
        echo -e "ping pc resolution de nom \t OK \t OK"
        else
        echo -e "ping pc resolution de nom \t OK \t NON"
        fi
else
        if [[ $pcnom6 == 1 ]]
        then
        echo -e "ping pc resolution de nom \t NON \t OK"
        else
        echo -e "ping pc resolution de nom \t NON \t NON"
        fi
fi

if [[ $routerint == 1 ]]
then
        if [[ $routerint6 == 1 ]]
        then
        echo -e "ping interface interne router \t OK \t OK"
        else
        echo -e "ping interface interne router \t OK \t NON"
        fi
else
        if [[ $routerint6 == 1 ]]
        then
        echo -e "ping interface interne router \t NON \t OK"
        else
        echo -e "ping interface interne router \t NON \t NON"
        fi
fi

#if [[ $routerext == 1 ]]
#then
 #       if [[ $routerext6 == 1 ]]
  #      then
   #     echo -e "ping interface externe router \t OK \t OK"
    #    else
     #   echo -e "ping interface externe router \t OK \t NON"
      #  fi
#else
 #       if [[ $routerext6 == 1 ]]
  #      then
  #      echo -e "ping interface externe router \t NON \t OK"
   #     else
    #    echo -e "ping interface externe router \t NON \t NON"
     #   fi
#fi

if [[ $google == 1 ]]
then
        if [[ $google6 == 1 ]]
        then
        echo -e "ping google \t\t\t OK \t OK"
        else
        echo -e "ping google \t\t\t OK \t NON"
        fi
else
        if [[ $google6 == 1 ]]
        then
        echo -e "ping google \t\t\t NON \t OK"
        else
        echo -e "ping google \t\t\t NON \t NON"
        fi
fi

if [[ $vpn == 1 ]]
then
        if [[ $vpn6 == 1 ]]
        then
        echo -e "ping vpn \t\t\t OK \t OK"
        else
        echo -e "ping vpn \t\t\t OK \t NON"
        fi
else
        if [[ $vpn6 == 1 ]]
        then
        echo -e "ping vpn \t\t\t NON \t OK"
        else
        echo -e "ping vpn \t\t\t NON \t NON"
        fi
fi

if [[ $pcval == 1 ]]
then
        if [[ $pcval6 == 1 ]]
        then
        echo -e "ping pc-val-1 \t\t\t OK \t OK"
        else
        echo -e "ping pc-val-1 \t\t\t OK \t NON"
        fi
else
        if [[ $pcvla6 == 1 ]]
        then
        echo -e "ping pc-val-1 \t\t\t NON \t OK"
        else
        echo -e "ping pc-val-1 \t\t\t NON \t NON"
        fi
fi


#ici on marque le total des tests abouties
echo ""
echo "IPv4 : " $total "sur 13"
if [[ $total == 13 ]]
then
echo -e "Test OK"
fi
echo "IPv6 : " $total6 "sur 13"
