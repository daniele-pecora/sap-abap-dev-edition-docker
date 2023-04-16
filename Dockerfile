FROM opensuse/leap:latest

ENV LANG=en_US.UTF-8

RUN zypper --non-interactive install --replacefiles which hostname expect net-tools iputils wget vim iproute2 unrar less tar gzip uuidd tcsh libaio

# uuidd is needed by nw abap
RUN mkdir /run/uuidd && chown uuidd /var/run/uuidd && /usr/sbin/uuidd

# Copy resources
COPY /resources/INSTALL_README.MD /tmp/sapdownloads/
COPY sapdownloads /tmp/sapdownloads/


# FIXES
# missing packages
RUN zypper --non-interactive install --replacefiles gcc insserv-compat
# recognition of a valid SuSE distro
RUN echo -e "\
SUSE Linux Enterprise Server 12 (x86_64)\n\
VERSION = 12\n\
PATCHLEVEL = 1\n\
#this file is only required for SAP installation to recognize a SuSE release version\n\
" > /etc/SuSE-release
# 
COPY /resources/install-quiet.sh /tmp/sapdownloads/
COPY /resources/instructions /tmp/sapdownloads/
RUN mv /tmp/sapdownloads/install.sh /tmp/sapdownloads/org_install.sh
RUN ln -s /tmp/sapdownloads/install-quiet.sh /tmp/sapdownloads/install.sh
RUN ln /tmp/sapdownloads/instructions /root/.bashrc
# /FIXES



WORKDIR /tmp/sapdownloads

RUN chmod +x install-quiet.sh



# Important ports to be exposed (TCP):
# HTTP
EXPOSE 8000
# HTTPS
EXPOSE 44300
# ABAP in Eclipse
EXPOSE 3300
# SAP GUI
EXPOSE 3200
# SAP Cloud Connector
EXPOSE 8443

