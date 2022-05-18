#!/bin/bash

tab[0]=10.1.10.254
tab[1]=10.1.20.254
tab[2]=10.1.30.254
tab[3]=10.1.40.254
tab[4]=10.1.50.254
tab[5]=10.1.0.1
tab[6]=10.1.0.254
tab[7]=10.1.40.10
tab[8]=10.0.12.1
tab[9]=10.0.12.2
tab[10]=10.2.10.254
tab[11]=10.2.10.1
tab[12]=srvdns
tab[13]=Pc-Val-1
tab[14]=192.168.141.2
tab[15]=192.168.170.154
tab[16]=8.8.8.8
tab[17]=www.google.fr

i=1
while (( $i < ${#tab[*]} )); do
ping -4 -c 1 ${tab[$i]} -q
tabR[$i]=${?};
i=$((i+1));
done

tab6[0]=2001:470:c84c:8100::1
tab6[1]=2001:470:c84c:8200::1
tab6[2]=2001:470:c84c:8300::1
tab6[3]=2001:470:c84c:8400::1
tab6[4]=2001:470:c84c:8500::1
tab6[5]=2001:470:c84c:8000::2
tab6[6]=2001:470:c84c:8000::1
tab6[7]=2001:470:c84c:8400::2
tab6[8]=2001:470:c84c:87ff::1
tab6[9]=2001:470:c84c:87ff::2
tab6[10]=2001:470:c84c:a100::1
tab6[11]=2001:470:c84c:a100::10
tab6[12]=srvdns
tab6[13]=Pc-Val-1
tab6[14]=2001:470:c84c:7:5e5e:abff:fe96:5980
tab6[15]=2001:470:c84c:8:20c:29ff:fe72:cfbe
tab6[16]=2001:4860:4860::8888
tab6[17]=www.google.fr

i=1
while (( $i < ${#tab6[*]} )); do
ping -6 -c 1 ${tab6[$i]} -q
tabR6[$i]=${?};
i=$((i+1));
done

clear
i=1
while (( $i < ${#tab[*]} )); do
if [ ${tabR[$i]} -eq 0 ];
then echo " ${tab[$i]} ping OK"
tabR[$i]="OK "
else echo " ${tab[$i]} ne répond pas, l'erreur peut venir de cette étape."
tabR[$i]="NON"
fi
i=$((i+1));
done

echo ""
echo "####### IPv6 #######"
echo ""

i=1
while (( $i < ${#tab6[*]} )); do
if [ ${tabR6[$i]} -eq 0 ];
then echo " ${tab6[$i]} ping IPv6 OK. "
tabR6[$i]="OK "
else echo " ${tab6[$i]} ne répond pas, l'erreur peut venir de cette étape."
tabR6[$i]="NON"
fi
i=$((i+1));
done

echo ""
echo "####### recapitulatif #######"
echo ""

i=1
espace="    "
echo -e "@IPv4 \t\t     | @IPv6"
echo "______________________________________________________________"
while (( $i < ${#tab6[*]} )); do
echo -e "${tab[$i]: 0:15} \t ${tabR[$i]} | ${tab6[$i]: 0:35} \t ${tabR6[$i]}"
i=$((i+1));
done
