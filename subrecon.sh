#!/bin/bash
# HomeBrewedByChickenN00dles

url=$1



if [ ! -d "$url" ];then
	mkdir $url
fi

if [ ! -d "$url/subdomain" ];then
	mkdir $url/subdomain
fi

if [ ! -d "$url/parameterfuzz" ];then
	mkdir $url/parameterfuzz
fi

if [ ! -d "$url/gau" ];then
	mkdir $url/gau
fi

if [ ! -d "$url/photon" ];then
	mkdir $url/photon
fi



function subdomainrecon(){
	cowsay "Subdomain Recon Starting Now. Please Wait!!!"
	assetfinder --subs-only $url >> $url/subdomain/assetfinder.subdomain.$url.txt
	subfinder -silent -d $url -o $url/subdomain/subfinder.subdomain.$url.txt
	sublist3r -d $url >> $url/subdomain/sublister.subdomain.$url.txt
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




function contentdiscovery() {
	while true; do

		cowsay "Do you want to DISCOVER TECH INFORMATIONS in these subdomains?" | lolcat
		echo "++++++++[Y]es or [N]o++++++++"
		read content
		if [[ $content == "Y" || $content == "y" ]]; then
			/root/go/bin/httpx -status-code -title -tech-detect -list $url/subdomain/alivesubdomains.txt
			break
		elif [[ $content == "N" || $content == "n" ]]; then

			echo " "
			echo " "
			echo "Aight understandable have a good day" | lolcat
			echo " "
			echo " "
			break
		else
			echo " "
			echo "Bruh Really? Can't you choose Y and N?" | lolcat
			continue
		fi
	done
}
contentdiscovery


function subtakeover() {
    while true; do
        cowsay "Do you want to test for SUBDOMAIN TAKEOVER?" | lolcat
        echo "++++++++[Y]es or [N]o++++++++"
        read subtakeover
        if [[ $subtakeover == "Y" || $subtakeover == "y" ]]; then
            subjack -w $url/subdomain/alivesubdomains.txt -v
	    break
        elif [[ $subtakeover == "N" || $subtakeover == "n" ]]; then
            echo " "
            echo "Aight Understandable have a good day" | lolcat
            break
        else
            echo " "
            echo "Bruh Really? Can't you choose Y and N?" | lolcat
            continue
        fi
    done
}

subtakeover




function paramharvester() {
    while true; do
        cowsay "Do you want to Harvest the parameters for XSS Fuzzing for later?" | lolcat
        echo "++++++++[Y]es or [N]o++++++++"
        echo " "
        read paramharvesterchoice
        if [[ $paramharvesterchoice == "Y" || $paramharvesterchoice == "y" ]]; then
            echo "Do you want all the subdomain or just the domain {S}ubdomain {D}omain" | lolcat
            read subdomainchoice
            if [[ $subdomainchoice == "D" || $subdomainchoice == "d" ]]; then
                paramspider -d $url
                mv results/$url.txt $url/parameterfuzz
                rm -r results
            elif [[ $subdomainchoice == "S" || $subdomainchoice == "s" ]]; then
                paramspider -l $url/subdomain/alivesubdomains.txt
                mv results/*.txt $url/parameterfuzz
            else
                echo " "
                echo "Bruh you gotta be shitting me imma head out" | lolcat
                exit
            fi
        elif [[ $paramharvesterchoice == "N" || $paramharvesterchoice == "n" ]]; then
            echo " "
            echo "Aight moving forward" | lolcat
            break
        else
            echo "Bruh Really? Please enter 'Y' or 'N'."
            echo " "
            continue
        fi

		echo " "
		echo " "
		echo " "
        echo "Do you want to scan again? [Y]es/[N]o" | lolcat
        read scanagainchoice
        if [[ $scanagainchoice == "Y" || $scanagainchoice == "y" ]]; then
            continue
        elif [[ $scanagainchoice == "N" || $scanagainchoice == "n" ]]; then
            echo " "
            echo "Aight, understandable have a good day" | lolcat
            break
        else
            echo "Bruh Really? Please enter 'Y' or 'N'."
            echo " "
            continue
        fi
    done
}

paramharvester



function gauresults(){
	while true; do
	echo " "
	echo " "
	echo " We are now scanning the below!"
	echo "[+] Getting URL's using GAU (.php .asa .inc .sql .zip .tar .pdf .txt Extenstions Only)"  | lolcat
	echo " [Y]es [N]o"
	read gauchoice


	 if [[ $gauchoice == "Y" || $gauchoice == "y" ]]; then

			/root/go/bin/gau  --fc 404,302 $url | grep ".php" >> $url/gau/$url.PHP_extentionurl.txt
			/root/go/bin/gau  --fc 404,302 $url | grep ".asa" >> $url/gau/$url.ASA_extentionurl.txt
			/root/go/bin/gau  --fc 404,302 $url | grep ".inc" >> $url/gau/$url.INC_extentionurl.txt
			/root/go/bin/gau  --fc 404,302 $url | grep ".sql" >> $url/gau/$url.SQL_extentionurl.txt
			/root/go/bin/gau  --fc 404,302 $url | grep ".zip" >> $url/gau/$url.ZIP_extentionurl.txt
			/root/go/bin/gau  --fc 404,302 $url | grep ".tar" >> $url/gau/$url.TAR_extentionurl.txt
			/root/go/bin/gau  --fc 404,302 $url | grep ".pdf" >> $url/gau/$url.PDF_extentionurl.txt
			/root/go/bin/gau  --fc 404,302 $url | grep ".txt" >> $url/gau/$url.TXT_extentionurl.txt
			break
        elif [[ $gauchoice == "N" || $gauchoice == "n" ]]; then
            echo " "
            echo "Aight, understandable have a good day" | lolcat
            break
        else
            echo "Bruh Really? Please enter 'Y' or 'N'."
            echo " "
			continue
	fi
done

}
gauresults


function photonchoice(){
	while true; do
	echo " "
	echo " "
	echo " Do you wanna perform Data Dig Extration Something like that?" | lolcat
	echo " [Y]es [N]o"
	read photonchoice
	
	
	if [[ $photonchoice == "Y" || $photonchoice == "y" ]]; then

			photon --url $url --keys --only-urls -l 3 -t 100 --wayback 
			mv $url/*.txt $url/photon
			break
        elif [[ $photonchoice == "N" || $photonchoice == "n" ]]; then
            echo " "
            echo "Aight, understandable have a good day" | lolcat
            break
        else
            echo "Bruh Really? Please enter 'Y' or 'N'."
            echo " "
			continue
	fi	
		
	

done

}
photonchoice



echo " " 
echo " " 
echo " "
cowsay -f dragon "Thank You Happy Hacking" | lolcat

