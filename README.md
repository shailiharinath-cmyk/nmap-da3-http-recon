# Beyond the Title Tag: Enhanced Nmap NSE Scripts

## Project Overview

This project extends Nmap's official `http-title.nse` script through two custom scripts for authorized HTTP reconnaissance.

### Enhancement 1: HTTP Status Code and Title

`http-title-enhancement-1.nse` retrieves the HTTP response status code and webpage title.

### Enhancement 2: Title and Meta Description

`http-title-enhancement-2.nse` retrieves the webpage title and HTML meta description.

## Files

- `http-title-enhancement-1.nse` — retrieves the HTTP status code and title.
- `http-title-enhancement-2.nse` — retrieves the title and meta description.
- `index.html` — local test webpage.

## Requirements

- Nmap with Nmap Scripting Engine (NSE)
- Python 3

## Local Testing

Start a Python HTTP server in the folder containing `index.html`:

`python3 -m http.server 8080`

Run Enhancement 1:

`nmap -sV -p 8080 --script ./http-title-enhancement-1.nse 127.0.0.1`

Run Enhancement 2:

`nmap -sV -p 8080 --script ./http-title-enhancement-2.nse 127.0.0.1`

These commands assume the script files are in your current terminal directory. The test server must be running separately.

## Reference

Official Nmap `http-title.nse` script: https://svn.nmap.org/nmap/scripts/http-title.nse

## Author

Shaili H

The scripts were tested against a locally hosted webpage. Scan only systems for which you have permission.
