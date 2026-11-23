# Gamepower-Control-Linux
First, install the required packages:
sudo pacman -S --needed pipewire pipewire-pulse wireplumber curl


Extract the ZIP archive, navigate to the extracted directory, and run:
chmod +x install.sh uninstall.sh scripts/check-status.sh
./install.sh


During installation, a list of audio outputs will appear. Select the USB headset output identified as Gamepower Ranger.
Usage
1. Open GNOME Settings → Sound → Output.
2. Select Surround 7.1.
3. The initial volume is set to 30% for safety. Increase it gradually.
4. In your game's audio settings, select 7.1 / 8-channel / surround audio output. If the game has its own headphone virtualization feature, disable it and compare the results.
5. You can switch back to your regular headset output for stereo music and browser audio.
Cinema and Bass Boost are also available as alternative virtual audio outputs.
Status Check
Run the following command to check the installation status:
./scripts/check-status.sh


If you encounter any issues, inspect the service logs:
journalctl --user -u filter-chain -n 100 --no-pager
journalctl --user -u headset-surround -n 100 --no-pager


Uninstallation
To remove the package:
./uninstall.sh


The installation script removes the PipeWire filter configurations it created and attempts to restore the previous default audio output.

Backups are stored in:
~/.local/share/headset-surround/backup/


Sources & Licensing
The virtual surround engine uses installation logic derived from the following open-source MIT-licensed project:
- https://github.com/gok8lp/headset-surround-linux
- Pinned source commit: bd9c465fde8b42da19c6fbba5623e4467624eb5c
- HRTF data: libmysofa / MIT KEMAR
This package is not published by Gamepower and is not affiliated with Gamepower.
Known Limitations
This solution provides software-based virtual 7.1 surround sound.

It does not port Gamepower's proprietary Windows application features, including:
- Hardware-specific RGB control.
- Microphone DSP processing.
- Firmware management.
- Proprietary USB control commands.
Porting these features would require further investigation of the Ranger headset's USB VID:PID identifiers and proprietary USB control protocol.
