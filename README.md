
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

## 问题
1. 如果提示is it a member or group, 试试logout 再login
```
ERROR:daemon_controller_delegate_linux.cc(101)] 2019-12-29 02:45:32,466:ERROR:Failed to access chrome-remote-desktop group. Is the user a member?
```
2. Teamviewer连不上，设置当前用户和root的密码，然后reboot虚拟机。  
设置当前用户密码：
```
sudo passwd
```
设置root密码：
```
sudo -i
sudo bash
passwd
```
