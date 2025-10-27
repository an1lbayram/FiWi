# FiWi
Instantly reveal saved WiFi passwords on Windows lightweight CMD tool. - Windows’ta kayıtlı WiFi şifrelerini anında görüntüleyin.

# FiWi - WiFi Password Manager for Windows (CMD)

🔍 **TR:** Windows'ta kayıtlı WiFi şifrelerini anında görüntüleyen basit, taşınabilir bir batch aracı.  
🔍 **EN:** Instantly reveal your saved WiFi passwords on Windows using a simple portable batch tool.

---

## 📘 Hakkında / About

**TR:**  
FiWi, Windows üzerinde `netsh` komutunu kullanarak cihazınızda daha önce kaydedilmiş WiFi profillerini listeleyen ve seçilen profilin şifresini gösteren küçük, taşınabilir bir CMD (.bat) aracıdır.  
Tamamen yerel çalışır; hiçbir veri dışarı gönderilmez.

**EN:**  
FiWi is a small portable CMD (.bat) tool that lists saved WiFi profiles on your Windows machine using `netsh` and displays the password for the selected profile.  
It runs fully locally; no data is sent outside.

---

## ✨ Özellikler / Features

**TR:**
- Kayıtlı WiFi profillerini listeler  
- Seçilen profilin (kaydedilmişse) şifresini gösterir  
- CLI renk temaları (isteğe bağlı)  
- Tek dosya, kurulum gerektirmez  
- İnternet bağlantısı gerekmez  

**EN:**
- Lists saved WiFi profiles  
- Reveals the password of the selected profile (if available)  
- CLI color themes (optional)  
- Single-file, no installation required  
- Works fully offline  

---

## ⚙️ Gereksinimler / Requirements

**TR:**
- Windows 7 veya üzeri  
- `netsh` komutunun sistemde bulunması  
- Bazı ağlar için yönetici izni gerekebilir  

**EN:**
- Windows 7 or newer  
- `netsh` command must be available  
- Some networks may require admin privileges  

---

## 🚀 Kullanım / Usage

**TR:**
1. `fiwi.bat` dosyasını indirin.  
2. Dosyaya sağ tıklayıp **“Yönetici olarak çalıştırın”** (gerekirse).  
3. Menüden işlem seçin: ağ listesini görüntüleyin veya bir profil seçip şifresini görün.  

**EN:**
1. Download the `fiwi.bat` file.  
2. Right-click → **“Run as administrator”** (if needed).  
3. From the menu, choose to list networks or view a password.  

---

## 💡 Alternatif (PowerShell üzerinden çalıştırma) / Alternative (via PowerShell)

**TR / EN:**
```powershell
curl -O https://github.com/an1lbayram/FiWi/raw/main/fiwi.bat
.\fiwi.bat
```

---

🧩 Örnek Çıktı / Example Output

TR:

1- HomeWiFi
2- OfficeNetwork
3- MobileHotspot

Seçiminizi girin: 2
Seçilen WiFi Ağı: OfficeNetwork
Şifre: work@2025


EN:

1- HomeWiFi
2- OfficeNetwork
3- MobileHotspot

Enter your selection: 2
Selected WiFi: OfficeNetwork
Password: work@2025

---

⚠️ Uyarı / Disclaimer

TR:
Bu araç yalnızca kendi cihazınızda kayıtlı WiFi profillerini görüntülemek içindir.
Başkalarının ağlarına ait bilgileri izinsiz görüntülemek veya paylaşmak etik değildir ve yasal sorumluluk doğurabilir.
FiWi geliştiricisi bu tür kullanımlardan sorumlu tutulamaz.

EN:
This tool is intended only for viewing WiFi profiles saved on your own device.
Viewing or sharing credentials from networks without permission is unethical and may be illegal.
The FiWi author is not responsible for misuse.

---

🧾 Lisans / License

TR:
Bu proje MIT Lisansı
 ile yayımlanmıştır. Ayrıntılar için LICENSE dosyasına bakabilirsiniz.

EN:
This project is released under the MIT License
. See the LICENSE file for details.

---

🤝 Katkı / Contributing

TR:
Hatalar, öneriler veya PR’lar için GitHub Issues bölümünü kullanabilirsiniz.
Büyük değişiklikler için önce bir Issue açıp tartışmanız önerilir.

EN:
Please use GitHub Issues for bugs, suggestions or pull requests.
For major changes, open an Issue first to discuss.

---

👨‍💻 Geliştirici / Developer

Developed by an1lbayram
- GitHub: https://github.com/an1lbayram
- LinkedIn: https://www.linkedin.com/in/an1lbayram
- Medium: https://medium.com/@anl1bayram
- Mail: anilbayram48@gmail.com

---

⭐ Eğer bu aracı faydalı bulduysanız, projeye bir star bırakmayı unutmayın!
If you find this tool useful, don’t forget to give it a star ⭐
