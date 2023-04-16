

Donwload SAP ABAP Developer Edition 7.52 SP04 from  
https://developers.sap.com/trials-downloads.html

Extract archives into director `sapdownloads` so the content has the structure like: 
```
    /sapdownloads/
        - /client/
        - /img/
        - /server/
        - /install.sh
        - /readme.html
        - /SAP_COMMUNITY_DEVELOPER_License
```

## Build
```bash
$ docker build -t yoraco/sap-dev-edition-7.52-sp04:latest .
```

## Run 
Pull image and create a container
```bash
$ docker run -p 8000:8000 -p 44300:44300 -p 3300:3300 -p 3200:3200 -h vhcalnplci --name sap-dev-edition-7.52-sp04 -it yoraco/sap-dev-edition-7.52-sp04 /bin/bash
```

## Start
After first pull and the first container is created 

```bash
$ docker start -i sap-dev-edition-7.52-sp04
```