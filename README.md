# SAP ABAP Developer Edition 7.52 SP04

Use this to gain and test your ABAP skills.  

You may either pull and run it directly read from Docker-Hub (variant #1)  
or create image and container yourself (variant #2)  

## Requirements

Already installed Docker.  
Min 100Gb free harddrive space and min 16Gb RAM.  


## 1) Install from Docker-Hub

Pull image and create a container directly from Docker-Hub.  
Here the SAP ABAP Developer Edition 7.52 SP04 are already contained.  
The images has a size of 15GB and will grow to 60GB a.m. after installation.

```bash
$ docker run -p 8000:8000 -p 44300:44300 -p 3300:3300 -p 3200:3200 -h vhcalnplci --name sap-abap-dev-edition -it yoraco/sap-dev-edition-7.52-sp04 /bin/bash
```

## 2) Build and create it yourself

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

### Build Docker Image
```bash
$ docker build -t sap-abap-dev-edition-7.52-sp04:latest .
```

### Run / Create Docker Container

Pull image and create a container
```bash
$ docker run -p 8000:8000 -p 44300:44300 -p 3300:3300 -p 3200:3200 -h vhcalnplci --name sap-abap-dev-edition -it sap-abap-dev-edition-7.52-sp04:latest /bin/bash
```

### Start Docker Container
After first pull and the first container is created 

```bash
$ docker start -i sap-abap-dev-edition
```


## After installation 

Checkout `INSTALL_README.MD` for instruction how to install and run SAP Developer Edition 7.52 SP04

```bash
$ cat /tmp/sapdownloads/INSTALL_README.MD
```