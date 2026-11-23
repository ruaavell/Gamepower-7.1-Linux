# Gamepower Ranger Virtual 7.1 for Linux

Arch Linux + GNOME + Wayland + PipeWire için hazırlanmış kurulum paketi.

## Ne kuruyor?

Bu paket, kulaklığa özel Windows DSP sürücüsünü port ettiğini iddia etmez. Bunun yerine tüm stereo kulaklıklarda çalışabilen açık kaynak PipeWire sanal surround motorunu kullanır:

- Oyunların görebileceği 8 kanallı (7.1) sanal ses çıkışı
- PipeWire SOFA/HRTF ile arka ve yan kanalların binaural stereo konumlandırılması
- `Surround 7.1`, `Cinema` ve `Bass Boost` sanal çıkışları
- Gerçek kulaklık çıkışına yönlendirme
- Yapılandırma dosyalarının yedeklenmesi
- Kaldırma betiği

HRTF desteği PipeWire derlemesindeki SOFA eklentisine bağlıdır. Eklenti bulunamazsa upstream araç daha basit ITD/ILD yedek yöntemine düşebilir. Bu nedenle kurulumdan sonra günlükleri kontrol etmek önemlidir.

## Arch Linux kurulumu

Önce temel paketleri yükle:

```bash
sudo pacman -S --needed pipewire pipewire-pulse wireplumber curl
```

ZIP'i çıkart ve klasörde:

```bash
chmod +x install.sh uninstall.sh scripts/check-status.sh
./install.sh
```

Kurulum sırasında ses çıkış listesi gelecek. **Gamepower Ranger** olarak görünen USB kulaklık çıkışını seç.

## Kullanım

1. GNOME Ayarlar → Ses → Çıkış bölümünü aç.
2. `Surround 7.1` çıkışını seç.
3. Ses seviyesi güvenlik amacıyla %30'dan başlar. Yavaşça artır.
4. Oyun ses ayarlarında çıkış biçimi olarak 7.1 / 8 kanal / surround seç. Oyunun ayrıca kulaklık sanallaştırması varsa kapatıp karşılaştır.
5. Stereo müzik ve tarayıcı sesi için normal kulaklık çıkışına geri dönebilirsin.

`Cinema` ve `Bass Boost` da alternatif sanal çıkışlar olarak görünür.

## Durum kontrolü

```bash
./scripts/check-status.sh
```

Sorun varsa:

```bash
journalctl --user -u filter-chain -n 100 --no-pager
journalctl --user -u headset-surround -n 100 --no-pager
```

## Kaldırma

```bash
./uninstall.sh
```

Kurulum betiği kendi oluşturduğu PipeWire filtre yapılandırmalarını kaldırır ve önceki varsayılan çıkışı geri yüklemeye çalışır. Yedekler `~/.local/share/headset-surround/backup/` altında tutulur.

## Kaynak ve lisans

Sanal surround motoru, MIT lisanslı şu açık kaynak projeden alınan kurulum mantığıyla çalışır:

- https://github.com/gok8lp/headset-surround-linux
- Sabitlenen kaynak commit: `bd9c465fde8b42da19c6fbba5623e4467624eb5c`
- HRTF verisi: libmysofa / MIT KEMAR

Bu paket Gamepower tarafından yayımlanmamıştır ve Gamepower ile bağlantılı değildir.

## Bilinen sınır

Bu çözüm **yazılımsal sanal 7.1** sağlar. Gamepower'ın Windows uygulamasındaki donanıma özel RGB, mikrofon DSP'si, firmware veya USB kontrol komutlarını Linux'a taşımaz. Bunun için Ranger'ın USB VID:PID ve kontrol protokolünün ayrıca incelenmesi gerekir.
