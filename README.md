<div align="center">

<img src="https://wiki.orangefox.tech/banner.svg" width="420" alt="OrangeFox Recovery"/>

# OrangeFox Recovery for Lava Blaze Curve 5G

**Codename: `LXX505`** · MediaTek Dimensity 7050 (MT6877) · Android 14

[![OrangeFox Build](https://github.com/Ray-Senpai07/orangefox_device_lava_LXX505/actions/workflows/ofox.yml/badge.svg)](https://github.com/Ray-Senpai07/orangefox_device_lava_LXX505/actions/workflows/ofox.yml)
[![TWRP Build](https://github.com/Ray-Senpai07/orangefox_device_lava_LXX505/actions/workflows/twrp.yml/badge.svg)](https://github.com/Ray-Senpai07/orangefox_device_lava_LXX505/actions/workflows/twrp.yml)
![Status](https://img.shields.io/badge/status-unofficial-orange)
![Decryption](https://img.shields.io/badge/FBE%20decryption-working-brightgreen)

<img src="images/LXX505.png" width="300" alt="Lava Blaze Curve 5G"/>

</div>

---

> [!WARNING]
> **This is a boot image, not a recovery image.**
> The Blaze Curve 5G is a Virtual A/B device with **no recovery partition**, so OrangeFox lives inside `boot`.
> Flash it to `boot_a` / `boot_b` only. Never flash it anywhere else.

## ✨ Features

| | Feature | Status |
|---|---|:---:|
| 🖥️ | Display & touch | ✅ |
| 🔐 | Data decryption (FBE v2 + metadata, TrustKernel TEE) | ✅ |
| 🔌 | ADB | ✅ |
| 💾 | USB OTG | ✅ |
| 📱 | Boots Android normally with OrangeFox installed | ✅ |
| 🔋 | Battery status | ✅ |
| 📂 | MTP | ⚠️ works, but switches ADB off (re-enable in **ADB & Sideload**) |
| ⚡ | Fastbootd | ❓ untested |
| 📦 | Flashing ZIPs / ROMs | ❓ untested |

## 📥 Installation

> [!NOTE]
> You need an **unlocked bootloader**, and keep a copy of your stock `boot.img` and `vbmeta.img` from the official firmware.

1. Download `ofox.img` from [**Releases**](https://github.com/Ray-Senpai07/orangefox_device_lava_LXX505/releases).
2. Reboot to the bootloader: hold **Vol Up + Power** and choose **Fastboot** (or run `adb reboot bootloader`).
3. Disable verified boot (once):
   ```sh
   fastboot --disable-verity --disable-verification flash vbmeta vbmeta.img
   ```
4. Check your active slot and flash OrangeFox to it:
   ```sh
   fastboot getvar current-slot
   fastboot flash boot_a ofox.img      # use boot_b if your slot is b
   ```
5. Boot into OrangeFox:
   ```sh
   fastboot reboot recovery
   ```

To enter OrangeFox later, hold **Vol Up + Power** and choose **Recovery**.
Choosing **Reboot → System** inside OrangeFox starts Android normally.

> [!CAUTION]
> OrangeFox reports a far-future security patch date (needed for decryption).
> After Android has booted with OrangeFox installed, flashing the **stock** `boot.img` back may require a **data wipe**.

## 📋 Device Specifications

| | Specification |
|---|---|
| **Chipset** | MediaTek Dimensity 7050 (6 nm), MT6877 |
| **CPU** | 2× Cortex-A78 @ 2.6 GHz + 6× Cortex-A55 @ 2.0 GHz |
| **GPU** | Mali-G68 MC4 |
| **Display** | 6.67" curved AMOLED, 1080 × 2400, 120 Hz |
| **Memory** | 8 GB LPDDR5 |
| **Storage** | 128 / 256 GB UFS 3.1 (no microSD) |
| **Rear Camera** | 64 MP main + 8 MP ultra-wide + 2 MP macro |
| **Front Camera** | 32 MP |
| **Battery** | 5000 mAh, 33 W charging |
| **Android** | Launched with 13, tested on 14 (`LAVA_LXX505_SW_A14_V09`) |
| **Kernel** | 4.19.191 (prebuilt, non-GKI) |
| **Partitions** | Virtual A/B (compressed), dynamic `super`, no recovery partition |
| **TEE** | TrustKernel (keymaster 4.1) |

## 🛠️ Building

This tree builds automatically with **GitHub Actions**, so no PC setup is needed:

**Actions → OrangeFox Recovery Build → Run workflow**

The finished `ofox.img` appears under **Releases**.

<details>
<summary>Building locally</summary>

```sh
# OrangeFox fox_12.1 source (Ubuntu 22.04 recommended, ~80-100 GB free space)
git clone https://gitlab.com/OrangeFox/sync.git
cd sync && ./orangefox_sync.sh --branch 12.1 --path ~/fox_12.1
cd ~/fox_12.1
git clone https://github.com/Ray-Senpai07/orangefox_device_lava_LXX505 device/lava/LXX505
source build/envsetup.sh
export ALLOW_MISSING_DEPENDENCIES=true
lunch omni_LXX505-eng
mka adbd bootimage
```

Output: `out/target/product/LXX505/boot.img`

</details>

## 🆘 Recovering from problems

- **Stuck on the OrangeFox logo:** hold **Power** for about 15 s, then **Vol Up + Power → Fastboot**, and flash a known-good `ofox.img` or your stock `boot.img`.
- **ADB disappears after MTP starts:** open **ADB & Sideload** in OrangeFox and toggle **ADB** on.
- **Full unbrick:** use SP Flash Tool with the official firmware in **Download Only** or **Firmware Upgrade** mode.
  ⚠️ **Never use "Format All + Download"**: it erases your IMEI/NVRAM.

## 🙏 Credits

- [**OrangeFox Recovery Project**](https://orangefox.tech) and [**TeamWin**](https://twrp.me)
- [**ayusc**](https://github.com/ayusc/orangefox_device_lava_LXX503): Lava Blaze 5G (LXX503) tree this one is based on
- [**ADeadTrousers**](https://github.com/ADeadTrousers/twrp_device_Unihertz_Atom_LXL): TrustKernel recovery reference
- [**SebaUbuntu**](https://github.com/twrpdtgen/twrpdtgen): twrpdtgen

<div align="center">

**Maintainer:** [Ray-Senpai07](https://github.com/Ray-Senpai07)

*Unofficial build. Use at your own risk; you are responsible for your device.*

</div>
