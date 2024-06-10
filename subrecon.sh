#!/bin/bash
# HomeBrewedByChickenN00dles

url=$1



if [ ! -d "$url" ];then
	mkdir $url
fi

if [ ! -d "$url/subdomain" ];then
	mkdir $url/subdomain
fi


function subdomainrecon(){
	cowsay "Subdomain Recon Starting Now. Please Wait!!!"
	assetfinder --subs-only $url >> $url/subdomain/assetfinder.subdomain.$url.txt
	subfinder -silent -d $url -o $url/subdomain/subfinder.subdomain.$url.txt
	python3 /opt/Sublist3r/sublist3r.py -d $url >> $url/subdomain/sublister.subdomain.$url.txt
	curl -s https://crt.sh/\?q\=%25.$url\&output\=json | jq -r '.[].name_value' | sed 's/\*\.//g' | sort -u >> $url/subdomain/crt.subdomain.$url.txt
	
	cat $url/subdomain/assetfinder.subdomain.$url.txt $url/subdomain/subfinder.subdomain.$url.txt $url/subdomain/crt.subdomain.$url.txt $url/subdomain/sublister.subdomain.$url.txt >> $url/subdomain/complete.txt
	
	cat $url/subdomain/complete.txt | sort | uniq | httprobe -c 50 >> $url/subdomain/alivesubdomains.txt
	
	
	rm $url/subdomain/assetfinder.subdomain.$url.txt $url/subdomain/subfinder.subdomain.$url.txt $url/subdomain/sublister.subdomain.$url.txt $url/subdomain/crt.subdomain.$url.txt $url/subdomain/complete.txt
	
	sleep 3
	echo -n "Finishing please wait: " | lolcat
	for i in {1..50}; do
	    echo -n "#"
	    sleep 0.1
	done | pv -lep -s 50 > /dev/null
	echo -e "\nProcess completed!" | lolcat
	echo " "
	echo " "
	echo " "


}
subdomainrecon

function paste(){
	echo " "
	echo " "
	echo " "
	
	sleep 3
	echo -n "Compiling Result" | lolcat
	for i in {1..50}; do
	    echo -n "#"
	    sleep 0.1
	done | pv -lep -s 50 > /dev/null
	echo -e "Pasting Result Please Wait" | lolcat
	echo " "
	echo " "
	
	cat $url/subdomain/alivesubdomains.txt

}
paste




function contentdiscovery(){
	cowsay "Do you want to discover what informations are in these subdomains?"
	echo "++++++++[Y]es or [N]o++++++++"
	read content
	if [[ $content == "Y" || $content == "y" ]]; then
	/root/go/bin/httpx -status-code -title -tech-detect -list $url/subdomain/alivesubdomains.txt
	else
	cowsay -f dragon "Thank You Happy Hacking"
	fi


}

contentdiscovery

