# Arch Install

因為系統理太多 Cache 類的東西，備份系統感覺都在備份 Cache 浪費空間浪費時間，所以把 ArchLinux 的安裝腳本化，方便以後裝機外也確保 SSD 掛掉我只要買新的 SSD、放著安裝系統、 `git clone` 就可以繼續上工。

目前只有 ThinkPad X230 ，所以只有 `x230-install.sh` 自用的環境。

## 使用方式

參考 [中文安裝手冊](https://wiki.archlinux.org/index.php/Installation_guide_(%E6%AD%A3%E9%AB%94%E4%B8%AD%E6%96%87)) 或 [英文安裝手冊](https://wiki.archlinux.org/index.php/Installation_guide) 或 [ArchLinux on ZFS](https://wiki.archlinux.org/index.php/Installing_Arch_Linux_on_ZFS) 安裝手冊，把硬碟切好格式化並掛到 `/mnt` 上後

```bash
x230-install.sh
```

## 備忘

紀錄一下可以替換的套件、還沒弄完的東西。

### 開機管理程式

目前 `grub` 安裝程式只考慮 UEFI 開機模式下， ESP 直接掛在 `/boot` 的情境。

### 檔案系統

`btrfs` 空間快滿時整個系統會很不穩定，但是 Copy-on-write 真的爽。

`zfs` 下次想試試看，畢竟 Copy-on-write 。

`xfs` 開 Docker 要在格式化的時候加參數，否則[會有問題](https://docs.docker.com/storage/storagedriver/overlayfs-driver/)

`ext4` 有點想回去用，雖然之前 SSD 上測試效能略低於 `xfs` 跟 `btrfs` 一點點。

### 網路管理

`Network Manager` 可以用 wicd 代替（如下）：
```
wicd wicd-gtk
```

但是 wicd 在商用 AP 環境下很難用（ 2 台 AP 支援 2.4/5.2GHz 並根據 VLAN 打個 2 個網路會看到 8 個 SSID）。

`netctl` 等有好用的 GUI 設定工具會考慮。

### 瀏覽器

`chromium-vaapi-bin` 純粹是 VA-API 對 X230 比較友善，透過 VDPAU 那個 CPU 用量會懷疑是不是設定錯誤沒開到硬體解碼。

如果原生支援 VDPAU 用 `chromium` 就好。

如果要 Google 整包 （主要是 Flash 與 DRM 影片播放） 就用 AUR 上的 `google-chrome` 

Flash 與 DRM 影片播放分別對應 AUR 上的 `pepper-flash` 跟 `chromium-widevine`。

### 驅動

參考了以下資訊

https://wiki.archlinux.org/index.php/Lenovo_ThinkPad_X230
https://wiki.archlinux.org/index.php/Intel_graphics
https://wiki.archlinux.org/index.php/Hardware_video_acceleration

省電機制、電池充電保護都還沒做。

VA-API 可以透過下面套件提供 VDPAU 介面並確認狀態，但不知道是沒成功還是單純效能不佳，吃 VDPAU 的 `chromium` 或 `google-chrome` 播放支援格式的影片 CPU 並沒有在 15% 以下。
```
libva-vdpau-driver
vdpauinfo
```

### 字體

`ttf-symbola` 用於顯示藏文還梵文的特殊符號，非自由軟體授權、不可商用。

如果有其他字體可以顯示 `ಠ` 符號就替換掉吧。

### 其他套件

`slack-desktop` 必要性好像不大，用瀏覽器開看看。