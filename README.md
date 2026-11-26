# 📶 FiWi v1.1 - WiFi Password Manager for Windows

![Windows](https://img.shields.io/badge/OS-Windows%207%2B-blue?logo=windows)
![Batch](https://img.shields.io/badge/Language-Batch%20%2F%20CMD-4D5B99)
![License](https://img.shields.io/badge/License-MIT-green)

> **Instantly reveal saved WiFi passwords on Windows lightweight CMD tool.**  
> *Windows’ta kayıtlı WiFi şifrelerini anında görüntüleyin.*

🔹 **TR:** Windows üzerinde `netsh` komutunu kullanarak cihazınızda daha önce kaydedilmiş WiFi profillerini listeleyen ve seçilen profilin şifresini gösteren hafif, taşınabilir bir batch (.bat) aracı.  
🔹 **EN:** A lightweight portable CMD (.bat) tool that lists saved WiFi profiles on your Windows machine using `netsh` and displays the password for the selected profile.

---

## ✨ Özellikler / Features

| TR | EN |
|---|---|
| 📋 Kayıtlı WiFi profillerini listeleme | Lists all saved WiFi profiles |
| 🔑 Seçilen ağın şifresini görüntüleme | Reveals the password of the selected profile |
| 🎨 Özelleştirilebilir CLI renk temaları | Optional CLI color themes |
| 🌐 TR / EN çoklu dil desteği (v1.1) | Full TR/EN language selection |
| ⚡ Tek dosya, kurulum gerektirmez | Single-file, zero installation |
| 🔒 Tamamen yerel ve offline çalışır | 100% local, works fully offline |

---

## 💻 Sistem Gereksinimleri / Requirements

- **Windows 7 / 8 / 10 / 11**
- `netsh` komutunun sistemde kullanılabilir olması (Windows'ta varsayılandır).
- Bazı sistemlerde kayıtlı şifreleri okumak için **Yönetici Yetkisi** gerekebilir.

---

## 🚀 Kurulum ve Çalıştırma / Quick Start

### ⚡ Tek Satırda İndir ve Çalıştır (PowerShell One-Liner)

PowerShell uygulamanızı açıp aşağıdaki **tek komut satırını** kopyalayıp yapıştırarak FiWi'yi anında indirip çalıştırabilirsiniz:

```powershell
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/an1lbayram/FiWi/main/FiWi.bat" -OutFile "FiWi.bat"; .\FiWi.bat
```

*(Git kullananlar için tek satır klonlama):*
```powershell
git clone https://github.com/an1lbayram/FiWi.git; cd FiWi; .\FiWi.bat
```

---

### 📋 Adım Adım Kurulum (Hiç Bilmeyenler İçin / Step-by-Step)

#### 1️⃣ Terminali / Komut İstemcisini Açın
- Başlat menüsüne **PowerShell** veya **CMD** yazın.
- Sağ tıklayıp **"Yönetici olarak çalıştır"** deyin.

#### 2️⃣ `FiWi.bat` Dosyasını İndirin
[GitHub Deposu](https://github.com/an1lbayram/FiWi) üzerinden `FiWi.bat` dosyasını bilgisayarınıza indirin veya yukarıdaki `Invoke-WebRequest` komutunu çalıştırın.

#### 3️⃣ Dosyayı Çalıştırın
Komut satırında indirilen dizine geçip dosyayı çalıştırın:
```cmd
FiWi.bat
```

#### 4️⃣ Menüden İşleminizi Seçin
Uygulama açıldığında:
1. **Dil Seçimi:** `1` (Türkçe) veya `2` (English) tuşlayın.
2. **İşlem Seçimi:** Kayıtlı ağ listesinden görmek istediğiniz WiFi ağının numarasını girin. Seçtiğiniz ağın parolası ekranda görüntülenecektir!

---

## 🧩 Örnek Çıktı / Example Output

```text
========================================
1- HomeWiFi
2- OfficeNetwork
3- MobileHotspot
========================================

Seçiminizi girin / Enter selection: 2

[+] Seçilen WiFi Ağı: OfficeNetwork
[+] Parola / Password: work@2025
```

---

## ⚠️ Yasal Uyarı / Disclaimer

Bu araç yalnızca kendi cihazınızda daha önce kaydedilmiş WiFi ağlarına ait parolaları görüntülemek amacıyla tasarlanmıştır. İzin almadan başkalarına ait ağ bilgilerini erişmek veya paylaşmak yasa dışı olabilir. Geliştirici kötüye kullanımlardan sorumlu tutulamaz.

---

## 📄 Lisans / License

Bu proje [MIT Lisansı](LICENSE) altında yayımlanmıştır.

**Geliştirici:** [Anıl Bayram](https://an1lbayram.vercel.app/) | [GitHub](https://github.com/an1lbayram)
