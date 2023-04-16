# Install SAP Developer Edition 7.52 - SP04

This project is based on the project:
https://github.com/nzamani/sap-nw-abap-trial-docker

## 1. Create and run Docker container

```bash
$ docker run -p 8000:8000 -p 44300:44300 -p 3300:3300 -p 3200:3200 -h vhcalnplci --name sap-dev-edition-7.52-sp04 -it yoraco/sap-dev-edition-7.52-sp04 /bin/bash
```
_(if your are inside the docker container terminal then you already have successfully completed this step)_


## 2. Install SAP Developer Edition 7.52 - SP04
```bash
$ cd /tmp/sapdownloads
$ ./install.sh -k
```

When installation is completed successufully the following message will appear in terminal
```bash
Installation of NPL successful
```

## 3. After Installation 

Start the container and SAP
```bash
# start the container
$ docker start -i <container-name>
# 
$ /usr/sbin/uuidd
$ su npladm
$ startsap ALL
```

Stop SAP and the container
```bash
$ su npladm
$ stopsap ALL
$ exit
# exit again to stop the container
$ exit
```

## 4. SAP GUI Client
Set connection string for GUI Client for connection type `Web AS ABAP`
```
conn=/H/127.0.0.1/S/3200
```

## 5. Important Post Installation Steps

1. Updating License

    - Open SAP GUI and logon
        - **User:** SAP*
        - **Password:** Down1oad
        - **Client:** 000

    - Open Transaction `SLICENSE`
    - From the Screen copy the value of field `Active Hardware Key`
    - Go to [SAP License Keys for Preview, Evaluation, and Developer Versions](https://go.support.sap.com/minisap/#/minisap) in your browser
    - Choose `NPL - SAP NetWeaver 7.x (Sybase ASE)`
    - Fill out the fields. Use the `Hardware Key` you copied from `SLICENSE`
    - Keep the downloaded file `NPL.txt` and go back to the `SLICENSE`
    - Delete the `Installed License` from the table
    - Press the button `Install` below the table
    - Choose the downloaded file `NPL.txt`
    - Done - happy learning. Now logon with the dev user.

    You can now logon to `client 001` with any of the following users (all share the same password `Down1oad`, typically you would work with `DEVELOPER`):

      - **User:** DEVELOPER (Developer User)
      - **User:** BWDEVELOPER (Developer User)
      - **User:** DDIC (Data Dictionary User)
      - **User:** SAP* (SAP Administrator)

1. Generating Test Data

    Execute the following to generate some test data:

      - **Report:** SAPBC_DATA_GENERATOR
      - **Transaction Code:** SEPM_DG

1. Suggestion: Activate the good old ping service

    - Go to Transaction `SICF`
    - Activate the node `/sap/public/ping` (default_host)
    - Test the HTTP and HTTPS connection with your browser

        - **HTTP:**  [http://localhost:8000/sap/public/ping](http://localhost:8000/sap/public/ping)
        - **HTTPS:** [https://localhost:44300/sap/public/ping](https://localhost:44300/sap/public/ping)


_Source: https://github.com/tobiashofmann/sap-nw-abap-docker/blob/master/README.md_

---

## Explanation of modifications

This are some modification that were made to make the installation routing work

### Installation file

The file `install-quiet.sh` is a slightly modified version of `install.sh` where
- License agreement is suppressed - line 1090
- Password is set fixed to `Down1oad` - line 1101
- Extracting archives is only done once, once they are already extracted - line 1111
- Compatibility with kernel version higher then 5.4.X is restored [(Source link)](https://blogs.sap.com/2021/06/07/adjusting-installer-script-for-sap-netweaver-dev-edition-for-distros-with-kernel-version-5.4-or-higher/
) - line 1114 
- Create a flag file for a successfully completed installation - line 1136
- Remove the flag file for a successfully completed installation on failure - line 349
- We use `-k` argument when executing `install.sh` to prevent calling `calculate_sysctl` SAP installation failing when setting `sysctl -w vm.max_map_count=1000000` - line 878


### Operating System
This are the changes that were made after docker build:

1) Installed missing packages
    ```bash
    $ zypper install gcc insserv-compat
    ```
2) Create a file `/etc/SuSE-release` to make SAP installation recognize this os as a SuSE distribution
    ```bash
    echo -e "\
    SUSE Linux Enterprise Server 12 (x86_64)\n\
    VERSION = 12\n\
    PATCHLEVEL = 1\n\
    #this file is only required for SAP installation to recognize a SuSE release version\n\
    " > /etc/SuSE-release
    ```
3) Added container IP and full qualified host name to file `/etc/hosts`
    ```bash
    echo "172.17.0.2      vhcalnplci.dummy.nodomain       vhcalnplci" >> /etc/hosts
    ```
    this is not needed when running with docker with `-h vhcalnplci`