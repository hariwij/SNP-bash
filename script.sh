#!/bin/bash

# whois_scan() function
whois_scan() {
    tput setaf 6
    echo "Scanning the target using whois...\n"

    if [ -z "$2" ]; then
        # read the file containg urls and scan each url
        while IFS= read -r url; do
            whois $url
        done <$1
        echo "Scan completed.\n"
    else
        while IFS= read -r url; do
            whois $url >> $2
        done <$1
        echo "Scan completed. Results are saved to: $2\n"
    fi
    tput sgr0
}

# nslookup_scan() function
nslookup_scan() {
    tput setaf 6
    echo "Scanning the target using nslookup...\n"

    if [ -z "$2" ]; then
        while IFS= read -r url; do
            nslookup -type=any $url
        done <$1
        echo "Scan completed.\n"

    else
        while IFS= read -r url; do
            nslookup -type=any $url >> $2
        done <$1
        echo "Scan completed. Results are saved to: $2\n"
    fi

    tput sgr0
}

# whatweb_scan() function
whatweb_scan() {
    tput setaf 6
    echo "Scanning the target using whatweb...\n"

    if [ -z "$2" ]; then
        while IFS= read -r url; do
            whatweb $url
        done <$1
        echo "Scan completed.\n"

    else
        while IFS= read -r url; do
            whatweb $url >> $2
        done <$1
        echo "Scan completed. Results are saved to: $2\n"
    fi

    tput sgr0
}

# nmap_scan() function
nmap_scan() {
    tput setaf 6
    echo "Scanning the target/s using nmap...\n"

    if [ -z "$2" ]; then
        nmap -sS -iL $1
        echo "Scan completed.\n"
    else
        nmap -sS -iL $1 -oN $2
        echo "Scan completed. Results are saved to: $2\n"
    fi

    tput sgr0
}

# gobuster_scan() function
gobuster_scan() {
    tput setaf 6
    echo "Scanning the target using gobuster...\n"

    if [ -z "$3" ]; then
        while IFS= read -r url; do
            gobuster dir -u $url -w $2
        done <$1
        echo "Scan completed.\n"

    else
        while IFS= read -r url; do
            gobuster dir -u $url -w $2 >> $3
        done <$1
        echo "Scan completed. Results are saved to: $3\n"
    fi

    tput sgr0
}

# nikto_scan() function
nikto_scan() {
    tput setaf 6
    echo "Scanning the target using nikto...\n"

    if [ -z "$2" ]; then
        while IFS= read -r url; do
            nikto --host $url
        done <$1
        echo "Scan completed.\n"

    else
        while IFS= read -r url; do
            nikto --host $url >> $2
        done <$1
        echo "Scan completed. Results are saved to: $2\n"
    fi

    tput sgr0
}

# dmitry_scan() function
dmitry_scan() {
    tput setaf 6
    echo "Scanning the target using dmitry...\n"

    if [ -z "$2" ]; then
        while IFS= read -r url; do
            dmitry -winsepfb $url
        done <$1
        echo "Scan completed.\n"

    else
        while IFS= read -r url; do
            dmitry -winsepfb $url >> $2
        done <$1
        echo "Scan completed. Results are saved to: $2\n"
    fi

    tput sgr0
}

# Parsing command line arguments
while getopts ":t:l:o:" opt; do
    case $opt in
    t) target="$OPTARG" ;;
    l) list="$OPTARG" ;;
    o) output="$OPTARG" ;;
    \?)
        echo "Invalid option -$OPTARG" >&2
        ;;
    esac
done

# Argument validation and preparation
if [ -z "$target" ] && [ -z "$list" ]; then
    tput setaf 1
    echo "Either the target or the target list must be given."
    tput sgr0
    exit 1
fi
if [ ! -z "$target" ] && [ ! -z "$list" ]; then
    tput setaf 3
    echo "Both the target and the target list are given. The target list will be used."
    target=""
    tput sgr0
fi

if [ ! -z "$target" ]; then
    echo $target >tmp.txt
    list="tmp.txt"
fi

if [ ! -z "$output" ]; then
    mkdir -p $output
fi

# Calling the functions based on the arguments
if [ -z "$output" ]; then
    whois_scan $list
    nslookup_scan $list
    whatweb_scan $list
    nmap_scan $list
    gobuster_scan $list ./common.txt
    nikto_scan $list
    dmitry_scan $list
else
    whois_scan $list $output/whois.txt
    nslookup_scan $list $output/nslookup.txt
    whatweb_scan $list $output/whatweb.txt
    nmap_scan $list $output/nmap.txt
    gobuster_scan $list ./common.txt $output/gobuster.txt
    nikto_scan $list $output/nikto.txt
    dmitry_scan $list $output/dmitry.txt
fi

