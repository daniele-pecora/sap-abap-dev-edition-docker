# Add content to docker image

Copy files to folder `/tmp/sapdownloads`
- `install-quiet.sh`
- `INSTALL_README.MD`

Create a soft link
```bash
ln -s /tmp/sapdownloads/install-quiet.sh /tmp/sapdownloads/install.sh
```


Copy file `instructions` to `/root/.bashrc`
or create a hard link
```bash
ln instructions /root/.bashrc
```

