
# 在 Compute Engine 上设置 Chrome 远程桌面
本教程介绍如何在 Compute Engine 中的 Debian Linux 虚拟机 (VM) 实例上设置 Chrome 远程桌面服务。Chrome 远程桌面可让您从本地计算机或移动设备使用图形界面远程访问应用。对于此方法，您无需打开防火墙端口，而是使用 Google 帐号进行身份验证和授权。

>注意：此解决方案不适用于图形密集型应用，因为此类应用通常需要硬件图形加速，以及具备高带宽和低延迟特性的网络。如果要远程运行图形密集型应用，请参阅创建 GPU 加速的虚拟 Linux 工作站教程，以获取替代解决方案。
本教程假定您熟悉 Linux 命令行，知道如何安装 Debian 软件包。

## 目标
1. 创建无外设 Compute Engine 虚拟机实例，以在其上运行 Chrome 远程桌面。
2. 在虚拟机实例上安装和配置 Chrome 远程桌面服务。
3. 在虚拟机实例中设置 X Window System 桌面环境。
4. 在本地计算机上安装和配置 Chrome 远程桌面客户端。
5. 从本地计算机连接到虚拟机实例上的桌面环境。

# 步骤
1. 执行setremote.sh脚本设置虚拟机的基本环境；
2. 在本地计算机上，使用 Chrome 浏览器，转到 Chrome 远程桌面命令行设置页面：https://remotedesktop.google.com/headless
3. 如果您尚未登录，请使用 Google 帐号登录。这是将用于授权远程访问的帐号。
4. 在再设置一台计算机页面上，点击开始。
5. 在下载并安装 Chrome 远程桌面 (Download and install Chrome Remote Desktop) 页面上，点击下一步。
6. 点击授权。
7. 将命令复制到与您的实例连接的 SSH 窗口，然后运行该命令。
8. 当系统提示您输入计算机的名称时，请输入实例名称 (crdhost)。
9. 出现提示时，输入一个 6 位数的 PIN 码。稍后连接时，您需要使用此号码进行额外的授权。

# 连接到虚拟机实例
1. 您可以使用 Chrome 远程桌面（https://remotedesktop.google.com/） Web 应用连接到虚拟机实例。
2. 在本地计算机上，转到 Chrome 远程桌面网站。点击远程访问
3. 如果您尚未登录 Google，请使用您用于设置 Chrome 远程桌面服务的同一 Google 帐号进行登录。
4. 您可以在远程设备列表中看到此新虚拟机实例。
5. 点击远程桌面实例的名称。
6. 收到系统提示时，请输入您之前创建的 PIN 码，然后点击箭头按钮进行连接。
7. 现在，您已连接到远程 Compute Engine 实例上的桌面环境。
8. 如果您安装的是 Xfce 桌面，则首次连接时，系统会提示您设置桌面面板。点击使用默认配置 (Use Default Config)，以在顶部显示标准任务栏并在底部显示快速启动面板。

# 改善远程桌面体验
1. 在应用 (Applications) 菜单中，选择设置 (Settings) > 屏保 (Screensaver)。
2. 将模式 (Mode) 设置为停用屏保 (Disable Screen Saver)。
3. Compute Engine 创建的用户帐号没有密码，大多数锁屏应用无法为没有密码的用户解锁屏幕。但是，即使屏保被停用，仍然可以从应用 (Applications) 菜单锁定屏幕。
4. 为避免被锁定而无法使用远程桌面，您可以为用户设置密码：
5. 使用 SSH 连接到实例，方法与第一次设置实例时相同。
6. 为用户创建密码：
```
sudo passwd
```

## 提高桌面分辨率
如果您使用的是超高分辨率监视器，您可能会发现 1600 x 1200 的默认最大远程桌面尺寸太小。如果是这样，您可以将其提高到您的显示器的分辨率大小。

1. 使用 SSH 连接到实例。
2. 将 CHROME_REMOTE_DESKTOP_DEFAULT_DESKTOP_SIZES 环境变量设置为包含您的显示器的分辨率大小：
```
echo "export CHROME_REMOTE_DESKTOP_DEFAULT_DESKTOP_SIZES=1600x1200,1920x1080,3840x2560" \
    >> ~/.profile
```
3. 重启服务：
```
sudo systemctl restart chrome-remote-desktop
```
## 问题
1. 如果在上述的第6步骤之后，ssh终端上提示is it a member or group, 试试logout 再login
```
ERROR:daemon_controller_delegate_linux.cc(101)] 2019-12-29 02:45:32,466:ERROR:Failed to access chrome-remote-desktop group. Is the user a member?
```
2. Teamviewer连不上，设置当前用户和root的密码，然后reboot虚拟机。
- 设置当前用户密码：
```
sudo passwd
```
- 设置root密码：
```
sudo -i
sudo bash
passwd
```
## 安装Anydesk
Anydesk需要有虚拟显示器
1. 运行insgnome.sh安装Ubuntu18.04的桌面环境和虚拟显示驱动。
2. 设置当前和root用户的密码。
3. 运行insanydesk.sh安装Anydesk。
4. Run sudo su for the next command:
```
echo welovelinuxandlongpasswords | anydesk --set-password 
Note: you can change the password to anything you wish.
anydesk --get-id
Note: This will return the 9 digit code that you will use on your Anydesk client to connect to the server. Save this code.
```
5. Reboot the system. sudo reboot
6. Once it boots back up — connect via Anydesk to your desktop.
## 配置Google vm的https for sourcegraph
1. install libnss3-tools
```
sudo apt install libnss3-tools
```
2. Install Homebrew
```
sudo chown -R $USER ~/.cache
/bin/bash -c "$(curl -sudo CAROOT=~/.sourcegraph/config mkcert -install https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
```
3. install mkcert
```
brew install mkcert
```
4. Create the root CA by running:
```
sudo CAROOT=~/.sourcegraph/config /home/linuxbrew/.linuxbrew/bin/mkcert -install
```
5. Creating the self-signed certificate
```
sudo CAROOT=~/.sourcegraph/config /home/linuxbrew/.linuxbrew/bin/mkcert \
  -cert-file ~/.sourcegraph/config/sourcegraph.crt \
  -key-file ~/.sourcegraph/config/sourcegraph.key \
  beyond2002.hopto.org
```
6. Adding SSL support to NGINX
Edit the default ~/.sourcegraph/config/nginx.conf, so that port 7080 redirects to 7443 and 7443 is served with SSL. It should look like this:
```
...
http {
    ...
    server {
        listen 7080;
        return 301 https://$host:7433$request_uri;
    }

    server {
        # Do not remove. The contents of sourcegraph_server.conf can change
        # between versions and may include improvements to the configuration.
        include nginx/sourcegraph_server.conf;

        listen 7443 ssl;
        server_name sourcegraph.example.com;  # change to your URL
        ssl_certificate         sourcegraph.crt;
        ssl_certificate_key     sourcegraph.key;

        location / {
            ...
        }
    }
}
```
7. Changing the Sourcegraph container to listen on port 443
NOTE: If the Sourcegraph container is still running, stop it before reading on.
```
docker stop $(docker ps | grep sourcegraph/server | awk '{ print $1 }')
```
Now that NGINX is listening on port 7443, we need to configure the Sourcegraph container to forward 443 to 7443 by adding --publish 443:7443 to the docker run command:
```
docker container run \
  --rm  \
  --publish 7080:7080 \
  --publish 443:7443 \
  \
  --volume ~/.sourcegraph/config:/etc/sourcegraph  \
  --volume ~/.sourcegraph/data:/var/opt/sourcegraph  \
  sourcegraph/server:3.16.1
```
NOTE: We recommend removing --publish 7080:7080 as it’s not needed and traffic sent to that port is un-encrypted.
Run the new Docker command, then validate by opening your browser at https://$HOSTNAME_OR_IP.
If running Sourcegraph locally, the certificate will be valid because mkcert added the root CA to the list trusted by your OS.
