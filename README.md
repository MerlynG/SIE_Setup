# VM setup for SIE
cuz it never works

## Download Ubuntu image file
Download latest stable version (LTS) on : https://ubuntu.com/download/desktop  
You should now have a `ubuntu-<version>-desktop-amd64.iso` file.

> **Note**  
> Version 22.04 looks like this : `ubuntu-22.04.2-desktop-amd64.iso`

## VM Setup
In VirtualBox, click on "New".  
![](Assets/annotely_image.png)

Enter a name and select the `.iso` file, then check the "Skip Unattended Installation" box.  
![](Assets/annotely_image%20(1).png)

> **Warning**  
> BE SURE TO CHECK THE "Skip Unattended Installation" BOX. IF IT IS NOT CHECKED, YOU WILL NEED TO ERASE AND RECREATE A NEW VIRTUAL MACHINE

**Click on "Next".**

Set the "Base Memory" to 4096 MB if possible (2048 MB if not).  
Set the "Processors" to 2 if possible (1 if not).

**Click on "Next".**

Keep Disk Size at 20 GB minimum.  
![](Assets/annotely_image%20(2).png)

**Click on "Next" and finally "Finish".**

## Inside the VM
Select "Try or Install Ubuntu"  
![](Assets/Screenshot%20from%202023-02-27%2013-56-06.png)

Select "Install Ubuntu"  
![](Assets/annotely_image%20(3).png)

Click on "Continue" and "Install now" until you can create a user.

Create a user and click on "Continue". (Keep the password simple)

After the system installation, click on "Restart Now".

When the following screen appears, just press <kbd>Enter</kbd>  
![](Assets/Screenshot%20from%202023-02-27%2014-07-40.png)

> **Note**  
> It is recommanded to open the rest of this tutorial in the VM Browser

> **Note**  
> You can skip the rest of the installation by running theses 2 commands
> ```
> wget https://raw.githubusercontent.com/MerlynG/SIE_Setup/main/omega_script.sh && chmod +x omega_script.sh
> ```
> And in the following command, replace the `<odoo_admin_passwd>` with the admin password you want to use
> ```
> ./omega_script.sh <odoo_admin_passwd>
> ```

Open a terminal with <kbd>Ctrl</kbd> + <kbd>Alt</kbd> + <kbd>T</kbd>

Then type
```
sudo apt update && sudo apt upgrade
```

### Odoo

Open the VM menu and go to "Machine" > "Take a Snapshot".  
If something goes wrong you can reload this Snapshot.

Download odoo's installation script with
```
sudo wget https://raw.githubusercontent.com/Yenthe666/InstallScript/16.0/odoo_install.sh
```

Then type
```
sudo nano odoo_install.sh
```

Make sure that  
`INSTALL_WKHTMLOPDF` is set to `"True"`  
`GENERATE_RANDOM_PASSWORD` is set to `"False"`  
![](Assets/annotely_image(1).png)

Save with <kbd>Ctrl</kbd> + <kbd>O</kbd> and <kbd>Ctrl</kbd> + <kbd>X</kbd>

In the terminal, type
```
sudo chmod +x odoo_install.sh
```
and
```
./odoo_install.sh
```

Press <kbd>Enter</kbd> when asked until the script ends.

**Odoo is now installed**

You can change the admin passoword by typing
```
sudo nano /etc/odoo-server.conf
```

Edit the `admin_passwd` variable

Restart the service
```
sudo service odoo-server restart
```

When you restart your VM, if odoo is not running, you can rerun the last command with `start` in place of `restart`, you can also stop it with `stop`.

You can now access Odoo via `localhost:8069` in your browser.

### Bonita

> **Warning**  
> Do not submit your real informations to download

Download latest version on : https://www.bonitasoft.com/downloads  
You should have a `BonitaStudioCommunity-<version>-x86_64.run` file

> **Note**  
> 2022 version looks like this : `BonitaStudioCommunity-2022.2-u0-x86_64.run`

Go in your download folder and type
```
chmod +x BonitaStudioCommunity-<version>-x86_64.run
```
and
```
./BonitaStudioCommunity-<version>-x86_64.run
```

Follow the UI Wizard instructions.

**Bonita is now installed**


# Troubleshooting

### My terminal is not working

Try to change your system language from English US to English UK, if it works, it probably means that you did not skip the unattended installation when creating the VM. You will need to delete it and recreate a new one.

### My user is not in the sudoers list

This is a non correct installation of the VM. You will need to delete it and recreate a new one.

> **Note**  
> If you want to fix it anyway, just type
> ```
> su root
> ```
> enter your password and type
> ```
> sudo nano /etc/sudoers
> ```
> In the file add the following line
> ```
> <your_username> ALL=(ALL) ALL
> ```
> *Example:*
> ```
> merlin ALL=(ALL) ALL
> ```

### Odoo says that UTF-8 is not compatible with my default language

Your locales are probably not installed correctly, it probably means that you did not skip the unattended installation when creating the VM. You will need to delete it and recreate a new one.

### Bonita's icon can't run

If the Bonita icon on your desktop cannot be run.  
![](Assets/Screenshot%20from%202023-02-27%2015-33-31.png)

Right click on it and select "Allow Lauching".  
![](Assets/annotely_image(2).png)

It should now look like this and can now be run.  
![](Assets/Screenshot%20from%202023-02-27%2015-34-01.png)
