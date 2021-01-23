This script is a wrapper around nmap, it performs a full nmap scan, then a -sV/-sC scan in open ports, and finally a UDP scan on top 100 ports. Typical scanning tool when targeting a single box (HTB, OSCP...)

**"mynmap.sh"** send nmap outputs to stdout, and create 3 files in the current directory :
- nmap.txt.full (raw full scan)
- nmap.txt (smart scan on discovered ports only)
- nmap.udp.txt (top 100 UPD)
