# Structure of my Script

My script can mainly be divided into 4 parts:

1. Bash functions for each tool
2. Parsing command line arguments
3. Argument validation and preparation
4. Calling the functions based on the arguments

## **Bash functions for each tool**

By using bash functions, I can easily call the functions by passing the arguments and I can reuse them in any where in my script and also in other scripts.

## _Whois_

`whois` is a command line utility that can be used to find out the registration information of a domain name or an IP address.

-   The script I have written is capable of getting the whois information of a given target and saving the output in a file.

```bash
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
```

**The script can be executed as follows:**

```bash
whois_scan <target_list> <output_file>
```

### Function explanation

-   First, I have used `tput` to change the color of the text to cyan. Then, I have printed 'Scanning the target using whois...' in the terminal.
-   Then, I have used an if statement to check if the output file is given or not. If the output file is not given, then the scan results will be printed in the terminal.
-   Since the whois command can only take one target at a time, I have used a while loop to read the target list file line by line and scan each target.
-   If the output file is given, then the scan results will be saved in the given file.

## _Nslookup_

`nslookup` is a network administration command-line tool available for many computer operating systems for querying the Domain Name System (DNS) to obtain domain name or IP address mapping, or other DNS records.

```bash
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
```

**The script can be executed as follows:**

```bash
nslookup_scan <target_list> <output_file>
```

### Function explanation

-   First, I have used `tput` to change the color of the text to cyan. Then, I have printed 'Scanning the target using nslookup...' in the terminal.
-   Then, I have used an if statement to check if the output file is given or not. If the output file is not given, then the scan results will be printed in the terminal.
-   Since the nslookup command can only take one target at a time, I have used a while loop to read the target list file line by line and scan each target.
-   If the output file is given, then the scan results will be saved in the given file.

## _WhatWeb_

`WhatWeb` is a next generation web scanner. WhatWeb recognizes web technologies including content management systems (CMS), blogging platforms, statistic/analytics packages, JavaScript libraries, web servers, and embedded devices. WhatWeb has over 1800 plugins, each to recognize something different. WhatWeb also identifies version numbers, email addresses, account IDs, web framework modules, SQL errors, and more.

```bash
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
```

**The script can be executed as follows:**

```bash
whatweb_scan <target_list> <output_file>
```

### Function explanation

-   First, I have used `tput` to change the color of the text to cyan. Then, I have printed 'Scanning the target using whatweb...' in the terminal.
-   Then, I have used an if statement to check if the output file is given or not. If the output file is not given, then the scan results will be printed in the terminal.
-   Since the whatweb command can only take one target at a time, I have used a while loop to read the target list file line by line and scan each target.
-   If the output file is given, then the scan results will be saved in the given file.

## _Nmap_

`nmap` is a network scanner that can be used to discover open ports, hosts and services on a computer network by sending packets and analyzing the responses.

-   The script I have written is capable of scanning given target list and saving the output in a file.

```bash
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
```

**The script can be executed as follows:**

```bash
nmap_scan <target_list> <output_file>
```

### Function explanation

-   First, I have used `tput` to change the color of the text to cyan. Then, I have printed 'Scanning the target using nmap...' in the terminal.
-   Then, I have used an if statement to check if the output file is given or not. If the output file is not given, then the scan results will be printed in the terminal. If the output file is given, then the scan results will be saved in the given file.
-   Finally, I have used `tput` to reset the color of the text to default.

## _GoBuster_

`GoBuster` is a tool used to brute-force URIs (directories and files) in web sites and DNS subdomains (with wildcard support) - essentially a directory/file & DNS busting tool.

```bash
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
```

**The script can be executed as follows:**

```bash
gobuster_scan <target_list> <wordlist> <output_file>
```

### Function explanation

-   First, I have used `tput` to change the color of the text to cyan. Then, I have printed 'Scanning the target using gobuster...' in the terminal.
-   Then, I have used an if statement to check if the output file is given or not. If the output file is not given, then the scan results will be printed in the terminal.
-   Since the gobuster command can only take one target at a time, I have used a while loop to read the target list file line by line and scan each target.
-   If the output file is given, then the scan results will be saved in the given file.

## _Nikto_

`Nikto` is an Open Source (GPL) web server scanner which performs comprehensive tests against web servers for multiple items, including over 6700 potentially dangerous files/programs, checks for outdated versions of over 1250 servers, and version specific problems on over 270 servers.

```bash
nikto_scan() {
    tput setaf 6
    echo "Scanning the target using nikto...\n"

    if [ -z "$2" ]; then
        while IFS= read -r url; do
            nikto -h $url
        done <$1
        echo "Scan completed.\n"

    else
        while IFS= read -r url; do
            nikto -h $url >> $2
        done <$1
        echo "Scan completed. Results are saved to: $2\n"
    fi

    tput sgr0
}
```

**The script can be executed as follows:**

```bash
nikto_scan <target_list> <output_file>
```

### Function explanation

-   First, I have used `tput` to change the color of the text to cyan. Then, I have printed 'Scanning the target using nikto...' in the terminal.
-   Then, I have used an if statement to check if the output file is given or not. If the output file is not given, then the scan results will be printed in the terminal.
-   Since the nikto command can only take one target at a time, I have used a while loop to read the target list file line by line and scan each target.
-   If the output file is given, then the scan results will be saved in the given file.

## _Dmitry_

`Dmitry` is a Deepmagic Information Gathering Tool. It is a command line application coded in C. Its main purpose is to gather information about a target host. It can be used to gather information about DNS, Whois, Web Site, Web Server, Web Technologies and IP Address space.

```bash
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
```

**The script can be executed as follows:**

```bash
dmitry_scan <target_list> <output_file>
```

### Function explanation

-   First, I have used `tput` to change the color of the text to cyan. Then, I have printed 'Scanning the target using dmitry...' in the terminal.
-   Then, I have used an if statement to check if the output file is given or not. If the output file is not given, then the scan results will be printed in the terminal.
-   Since the dmitry command can only take one target at a time, I have used a while loop to read the target list file line by line and scan each target.
-   If the output file is given, then the scan results will be saved in the given file.

## **Parsing command line arguments**

I have used `getopts` to parse the command line arguments. `getopts` is a built-in command in bash that parses command line arguments. It is used to parse short options (e.g. -h) and long options (e.g. --help).

```bash
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
```

-   Argument `t` is used to specify the _target_.
-   Argument `l` is used to specify the _target list_.
-   Argument `o` is used to specify the _output file_.

## **Argument validation and preparation**

At any time either the target or the target list must be given. If both are given, then the target list will be used. If none of them are given, then the script will exit with an error message.

```bash
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
```

-   If the target is given, then the target will be saved in a temporary file and the target list will be set to the temporary file. This is because the functions I have written can only take the target list as an argument.

-   Then the script will ask for a folder name to save the results. If the folder name is not given, then the folder name will be set to default.

-   Then the script will create a folder with the given folder name.

## **Calling the functions based on the arguments**

```bash
if [ -z "$output" ]; then
    whois_scan $list
    nslookup_scan $list
    whatweb_scan $list
    nmap_scan $list
    gobuster_scan $list $wordlist
    nikto_scan $list
    dmitry_scan $list
else
    whois_scan $list $output/whois.txt
    nslookup_scan $list $output/nslookup.txt
    whatweb_scan $list $output/whatweb.txt
    nmap_scan $list $output/nmap.txt
    gobuster_scan $list $wordlist $output/gobuster.txt
    nikto_scan $list $output/nikto.txt
    dmitry_scan $list $output/dmitry.txt
fi
```

- First, I have used an if statement to check if the output dir is given or not. If the output dir is not given, then the scan results will be printed in the terminal. If the output file is given, then the scan results will be saved in the given file.


# Script Output

## _Whois Scan_

## _Nslookup Scan_

## _WhatWeb Scan_

## _Nmap Scan_

## _Gobuster Scan_

## _Nikto Scan_

## _Dmitry Scan_



