# OTT platform

[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)

## Description

This is an OTT platform just like other popular OTT platform.


## Setup
1. clone repo
2. Setup MySQL in `/server` configurations
3. install Node Modules `/server` by ```npm install```
4. Open `/ott_platform-main` Folder and run flutter App


# Setup Admin
curl  -X POST \
  'http://localhost:3000/auth/v1/signup' \
  --header 'Accept: */*' \
  --header 'Content-Type: application/x-www-form-urlencoded' \
  --data-urlencode 'email=admin@gmail.com' \
  --data-urlencode 'password=Admin123' \
  --data-urlencode 'firstName=Admin' \
  --data-urlencode 'lastName=Admin' \
  --data-urlencode 'usertype=admin' \
  --data-urlencode 'admin_secret=nodeott' \
  --data-urlencode 'username=admin'




