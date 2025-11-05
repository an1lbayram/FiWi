# FiWi 1.1
Instantly reveal saved WiFi passwords on Windows lightweight CMD tool. - Windows’ta kayıtlı WiFi şifrelerini anında görüntüleyin.

# FiWi 1.1 - WiFi Password Manager for Windows (CMD)

🔹 Now with full Turkish & English language support!
🔹 Artık Türkçe ve İngilizce dil desteğiyle!

🔍 TR: Windows'ta kayıtlı WiFi şifrelerini anında görüntüleyen basit, taşınabilir bir batch aracı.
🔍 EN: Instantly reveal your saved WiFi passwords on Windows using a simple portable batch tool.

---

## 📘 Hakkında / About

**TR:**  
FiWi, Windows üzerinde `netsh` komutunu kullanarak cihazınızda daha önce kaydedilmiş WiFi profillerini listeleyen ve seçilen profilin şifresini gösteren küçük, taşınabilir bir CMD (.bat) aracıdır. 
Bu sürümle birlikte, Türkçe ve İngilizce dil seçenekleri eklenmiştir.
Tamamen yerel çalışır; hiçbir veri dışarı gönderilmez.

**EN:**  
FiWi is a small portable CMD (.bat) tool that lists saved WiFi profiles on your Windows machine using `netsh` and displays the password for the selected profile.
This version introduces Turkish and English language support.
It runs fully locally; no data is sent outside.

---

## ✨ Özellikler / Features

TR:

Kayıtlı WiFi profillerini listeler

Seçilen profilin (kaydedilmişse) şifresini gösterir

CLI renk temaları (isteğe bağlı)

TR/EN dil seçeneği (1.1 ile yeni)

Tek dosya, kurulum gerektirmez

İnternet bağlantısı gerekmez

EN:

Lists saved WiFi profiles

Reveals the password of the selected profile (if available)

CLI color themes (optional)

TR/EN language selection (new in 1.1)

Single-file, no installation required

Works fully offline 

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

💡 Alternatif (PowerShell üzerinden çalıştırma) / Alternative (via PowerShell)

TR:
FiWi’yi doğrudan PowerShell üzerinden indirip çalıştırabilirsiniz. Aşağıdaki komutlardan birini kullanın:

EN:
You can directly download and run FiWi via PowerShell. Use one of the commands below:

**TR / EN:**
# Seçenek 1 – Curl yöntemi (Windows 10+ veya Git Bash kullanıcıları için)
# Option 1 – Using Curl (for Windows 10+ or Git Bash users)
```powershell
curl -O https://github.com/an1lbayram/FiWi/raw/main/FiWi.bat
.\FiWi.bat
```

# Seçenek 2 – PowerShell’in yerel yöntemi (her sürümde çalışır)
# Option 2 – Native PowerShell method (works on all versions)
```powershell
Invoke-WebRequest -Uri "https://github.com/an1lbayram/FiWi/raw/main/FiWi.bat" -OutFile "FiWi.bat"
.\FiWi.bat
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
