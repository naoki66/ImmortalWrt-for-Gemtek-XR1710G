# ImmortalWrt for Gemtek XR1710G

适用于 Gemtek XR1710G / W1700K 的 ImmortalWrt 定制固件

## 设备规格

| 项目 | 规格 |
|------|------|
| 型号 | Gemtek XR1710G / W1700K |
| SoC | Airoha AN7581 |
| CPU | ARM Cortex-A53 四核 |
| 内存 | 2GB DDR4 |
| 闪存 | 256MB NAND |
| WiFi | MT7996 WiFi 7 三频 (2.4G/5G/6G) |
| 网口 | 1× 10G (WAN) +1× 10G (LAN) ，2× 1G (LAN) |
| 风扇 | NCT7802 温控风扇 |

## 功能特性

- ✅ 完整的 XR1710G / W1700K 设备树支持
- ✅ WiFi 7 三频支持 (2.4G/5G/6G)
- ✅ 风扇自动调速 (基于 NCT7802 温度传感器)
- ✅ 流量卸载优化 (flow-offload + nft-offload)
- ✅ 10G 万兆网口支持
- ✅ 网络调试工具

## 编译指南

### 环境要求

- Ubuntu 22.04+ / Debian 12+
- 至少 8GB 内存
- 至少 100GB 磁盘空间
- Git, build-essential, etc.

### 编译步骤

```bash
# 克隆仓库
git clone https://github.com/naoki66/ImmortalWrt-for-Gemtek-XR1710G.git
cd ImmortalWrt-for-Gemtek-XR1710G

# 更新并安装依赖
./scripts/feeds update -a
./scripts/feeds install -a

# 配置编译选项
make menuconfig

# 目标平台选择
# Target System  → Airoha
# Subtarget      → an7581
# Target Profile → Gemtek XR1710G (U-Boot layout)

# 开始编译
make -j$(nproc)
```

## 安装指南

### U-Boot 方式

1. 通过 UART 进入 U-Boot
2. 将固件上传到内存
3. 刷写固件到 NAND

```bash
# 在 U-Boot 中
tftpboot 0x40000000 openwrt-airoha-an7581-gemtek_xr1710g-ubi-squashfs-sysupgrade.bin
nand erase.part ubi
nand write 0x40000000 ubi ${filesize}
reset
```

### Sysupgrade 方式

```bash
scp openwrt-airoha-an7581-gemtek_xr1710g-ubi-squashfs-sysupgrade.bin root@192.168.1.1:/tmp/
ssh root@192.168.1.1 sysupgrade /tmp/openwrt-airoha-an7581-gemtek_xr1710g-ubi-squashfs-sysupgrade.bin
```

## 默认配置

### 网络

- LAN: 192.168.1.1/24
- WAN: DHCP
- 网口映射: LAN2/LAN3/LAN4 为局域网，WAN 为广域网

### WiFi

| 频段 | SSID | 加密方式 | 默认密码 |
|------|------|----------|----------|
| 2.4G | W1700K(XR1710G)-2G | WPA/WPA2 | 12345678 |
| 5G | W1700K(XR1710G)-5G | WPA3 SAE | 12345678 |
| 6G | W1700K(XR1710G)-6G | WPA3 SAE | 12345678 |

> ⚠️ 首次登录后请修改默认密码和 WiFi 配置

## U-Boot

本仓库包含 XR1710G 专用的 U-Boot 分支作为子模块，支持 HTTP Recovery 功能：

### U-Boot 特性

- ✅ 10GbE 支持
- ✅ HTTP Recovery (网页恢复模式)
- ✅ 内置 DHCP 服务器
- ✅ 恢复页面地址: `http://192.168.255.1`

### 进入 HTTP Recovery

1. 将 PC 连接到 10GbE 网口，设置为 DHCP 自动获取
2. 上电开机
3. 10GbE 网口 LED 开始闪烁后，按住 reset 按钮
4. 状态 LED 从红色变为流动模式，表示进入恢复模式
5. 在浏览器中打开 `http://192.168.255.1`

### 编译 U-Boot

```bash
# 进入子模块
cd u-boot

# 设置交叉编译工具链
export CROSS_COMPILE=aarch64-none-linux-gnu-

# 配置 XR1710G
make xr1710g_defconfig

# 编译
make -j$(nproc)

# 生成链加载器镜像
./build-chainloader-fit.sh
```

### 刷写 U-Boot

```bash
# 将 xr1710g-chainloader-slot.bin 复制到设备 /tmp
scp out/xr1710g-chainloader-slot.bin root@192.168.1.1:/tmp/

# 在设备上刷写 chainloader 分区
flash_erase /dev/mtd2 0 8
nandwrite -p /dev/mtd2 /tmp/xr1710g-chainloader-slot.bin
sync
reboot
```

## 上游仓库

本仓库基于以下上游项目：

- **ImmortalWrt 官方**: [https://github.com/immortalwrt/immortalwrt](https://github.com/immortalwrt/immortalwrt)
- **YYH2913 设备源**: [https://github.com/YYH2913/openwrt](https://github.com/YYH2913/openwrt)
- **lvcdy XR1710G**: [https://github.com/lvcdy/openwrt_xr1710g](https://github.com/lvcdy/openwrt_xr1710g)
- **YYH2913 U-Boot**: [https://github.com/YYH2913/http-uboot-xr1710g](https://github.com/YYH2913/http-uboot-xr1710g)

## 同步流程

```bash
# 抓取所有远程更新
git fetch --all

# 同步 ImmortalWrt 官方主线
git checkout master
git merge upstream/master --no-edit

# 同步 YYH2913 设备驱动
git checkout -b temp_yyh yyh_source/main
git checkout master
git checkout temp_yyh -- target/linux/airoha/
git commit -m "同步 YYH2913 设备驱动更新"

# 同步 lvcdy XR1710G 优化
git checkout -b temp_lvcdy lvcdy_source/main
git checkout master
git checkout temp_lvcdy -- target/linux/airoha/
git commit -m "同步 lvcdy XR1710G 优化"

# 推送
git push origin master

# 清理临时分支
git branch -D temp_yyh temp_lvcdy
```

## 许可证

本项目遵循 OpenWrt / ImmortalWrt 的许可证条款。

## 贡献

欢迎提交 Issue 和 Pull Request！
