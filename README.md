# windesign
 --------------------------------------------------------------------------------
# İŞ GEREKSİNİMLERİ DOKÜMANI (BRD)

**Proje Adı:** Windesign Web Tabanlı Pencere Üretim ve Teklif Yönetim Sistemi

**Versiyon:** 1.0

## 1. GİRİŞ VE AMAÇ

Windesign, pencere üreticileri ve satıcıları için tasarlanmış yeni bir pencere üretim ve teklif programıdır [1]. Bu dokümanın amacı, programın tamamen web tabanlı yapısından, teknik çizim detaylarına ve maliyet analizine kadar tüm işlevsel gereksinimlerini tanımlamaktır.

## 2. İŞ GEREKSİNİMLERİ (Yüksek Seviye)

| ID | Gereksinim | Açıklama | Kaynak |
| :--- | :--- | :--- | :--- |
| **BR-001** | **Web Tabanlı Erişim ve Kullanım** | Programın tamamen web tabanlı çalışması gereklidir. İnternetin olduğu her yerden, cihaz bağımsız (cep telefonu, tablet, Mac veya Windows bilgisayar) erişim sağlanmalıdır [1]. | [1] |
| **BR-002** | **Güvenlik ve Süreklilik** | Sistem virüslerden etkilenmemeli ve kullanıcıdan herhangi bir yedekleme talep etmemelidir. Kullanıcılar üyelik sistemi üzerinden (e-posta onayı sonrası) şifreyle giriş yapabilmelidir [1, 2]. | [1, 2] |
| **BR-003** | **Proje Yönetimi** | Kullanıcı, yeni siparişler girebilmeli ve projeleri bayi, müşteri ve alt müşteri olmak üzere **üç farklı kademede** takip edebilmelidir [2]. | [2] |
| **BR-004** | **Çoklu Malzeme Desteği** | Sistem, aynı proje içinde **PVC, alüminyum doğrama** ve **cam balkon** sistemlerinin çizim ve siparişini desteklemelidir [3, 4]. | [3, 4] |

## 3. FONKSİYONEL GEREKSİNİMLER (FG)

### 3.1. Sipariş ve Proje Girişi (FG-SP)

| ID | Gereksinim | Açıklama | Kaynak |
| :--- | :--- | :--- | :--- |
| **FG-SP-01** | Proje İsimlendirme | Projeye referans numarası (Örn: S10220) veya kullanıcı tanımlı isim (Örn: "üst kat salon") verilebilmelidir [2, 5]. | [2, 5] |
| **FG-SP-02** | Görünürlük Kontrolü | İmalat personelinin buradaki proje isimlerini görmesini istememe seçeneği sunulmalıdır [2]. | [2] |
| **FG-SP-03** | Hizmet Kapsamı | Siparişte montajın ve cam tedarikinin projeye dahil olup olmadığı kapatılıp/açılabilmelidir [2]. | [2] |
| **FG-SP-04** | Ölçü Tipi | Sipariş, imalat ölçüsü (açık bırakılır) veya teklif ölçüsü (kapalı bırakılır) seçenekleri ile açılabilmelidir [2]. | [2] |

### 3.2. Çizim ve Geometri (FG-ÇG)

| ID | Gereksinim | Açıklama | Kaynak |
| :--- | :--- | :--- | :--- |
| **FG-ÇG-01** | Temel Giriş | Kapı çizimleri için genişlik (Örn: 950) ve yükseklik (Örn: 2200) gibi net ölçüler belirlenebilmelidir [5]. | [5] |
| **FG-ÇG-02** | Şekilli Çizim | 2500x2500 balkon kapama gibi şekilli çizimler yapılabilmelidir [6]. | [6] |
| **FG-ÇG-03** | Kemerli Çizim | Kemer yüksekliği belirtilerek (Örn: 600) kemerli çizimler desteklenmelidir [7]. | [7] |
| **FG-ÇG-04** | Eğim ve Kiriş | Çizime kiriş eklenebilmeli ve sağ tarafa doğru eğim (slop) verilebilmelidir; eğimin ölçüsü (Örn: -200) ayarlanabilmelidir [6]. | [6] |
| **FG-ÇG-05** | Doğrama Kesme | Çizimdeki doğramayı ortadan kesme özelliği bulunmalıdır [6]. | [6] |
| **FG-ÇG-06** | Topal Ekleme | Mevcut çizimin yanına yeni bir kare çizim (topal) eklenip ölçülendirme yapılabilmelidir [8]. | [8] |

### 3.3. Profil ve Aksesuar Detaylandırma (FG-PA)

| ID | Gereksinim | Açıklama | Kaynak |
| :--- | :--- | :--- | :--- |
| **FG-PA-01** | Kanat ve Açılım | Çift kanat adaptörlü çizimler, çift açılım ve içe açılım kitli kapı profili gibi sistemler seçilebilmelidir [5]. | [5] |
| **FG-PA-02** | Eşiksiz Tasarım | Alt profil eşiksiz olarak ayarlanabilmelidir [8]. | [8] |
| **FG-PA-03** | Orta Kayıt Kontrolü | Orta kayıtlar eklenebilmeli ve alttan ölçüsü (Örn: -900) girilerek pozisyonu belirlenebilmelidir [8]. | [8] |
| **FG-PA-04** | Eşitleme İşlevi | Birden fazla orta kayıt arasındaki camların genişliklerini veya mesafelerini eşitleme butonu sunulmalıdır [7]. | [7] |
| **FG-PA-05** | Dolgu Yönetimi | Cam bölmelere panel (Örn: 24 mm) eklenebilmeli ve bu dolgu tekrar cama geri çevrilebilmelidir [3, 7]. | [3, 7] |
| **FG-PA-06** | Aksesuar Ekleme | Çevresine pervaz, altına mermer ve sineklik eklenebilmelidir [5]. | [5] |
| **FG-PA-07** | Dekoratif Elemanlar | Karolajlar orta kayıt gibi atılabilmeli ve pozisyonları belirlenebilmelidir. Lamri (dikey veya yatay) ve cam içi jaluzi eklenebilmelidir [5, 8]. | [5, 8] |
| **FG-PA-08** | Alüminyum Detayları | Alüminyum çiziminde kapı cinsi seçimi ve etek profili kullanımı desteklenmelidir [3]. | [3] |

### 3.4. Cam Balkon Çizimi (FG-CB)

| ID | Gereksinim | Açıklama | Kaynak |
| :--- | :--- | :--- | :--- |
| **FG-CB-01** | Marka ve Ölçü | Cam balkon markası seçimi ve yükseklik/genişlik belirlenebilmelidir (Örn: 1650 yükseklik) [4]. | [4] |
| **FG-CB-02** | Kanat Önerisi | Program otomatik olarak kanat önerisi sunabilmelidir (Örn: 4 kanat) [4]. | [4] |
| **FG-CB-03** | Köşe Dönüşü | L şeklinde dönüşler için dönüş (artı ile) verilebilmeli ve dönüş genişliği (Örn: 1200) belirlenebilmelidir [4]. | [4] |

### 3.5. Teklif ve Fiyatlandırma (FG-TF)

| ID | Gereksinim | Açıklama | Kaynak |
| :--- | :--- | :--- | :--- |
| **FG-TF-01** | Toplu Teklif | Tüm projeden tek seferde teklif alınabilmelidir [4]. | [4] |
| **FG-TF-02** | Fiyatlandırma Bazları | Fiyatlandırma, PVC/Alüminyum için **metretül** bazında, Alüminyum için isteğe bağlı olarak **ağırlıktan** ve Cam balkon için **metrekare** üzerinden yapılabilmelidir (Örn: 2500 TL/m²) [4, 9]. | [4, 9] |
| **FG-TF-03** | Aksesuar Fiyatlama | Standart aksesuarlar fiyata dahil edilebilir veya özel açılımlar için ayrı fiyat girilebilmelidir [9]. | [9] |
| **FG-TF-04** | Fiyat Kayıt Mekanizması | Girilen fiyatlar, kalıcı fiyat listesini güncellemek (sarı tuş) veya sadece o müşteri için kaydetmek (yeşil tuş) üzere iki farklı şekilde kaydedilebilmelidir [9]. | [9] |

### 3.6. Raporlama ve Çıktılar (FG-RT)

| ID | Gereksinim | Açıklama | Kaynak |
| :--- | :--- | :--- | :--- |
| **FG-RT-01** | Entegre Teklif Çıktısı | Alüminyum, cam balkon ve diğer doğrama teklifleri tek bir teklif içinde çıkmalıdır [10]. | [10] |
| **FG-RT-02** | Çıktı Özelleştirme | Teklife kapak sayfası eklenebilmeli ve teklif formatı (Örn: sadece çizim ve fiyatlar) değiştirilebilmelidir (Teklif 4) [10]. | [10] |
| **FG-RT-03** | Detay Seviyesi | Malzemelerin fiyatlandırma şeklini göstermek amacıyla malzeme toplamları detayı açılabilmelidir [10]. | [10] |
| **FG-RT-04** | Teknik Raporlama | Müteahhitler için izolasyon değerleri ile birlikte basım yapılabilmelidir. Alüminyumcular için kesitleri içeren çıktılar (Versiyon 6) alınabilmelidir [10]. | [10] |
| **FG-RT-05** | Dışa Aktarım | Teklif çıktısı, **resimli** olarak Excel'e aktarılabilmeli ve Excel üzerinde değişiklik yapılıp müşteriye gönderilebilmelidir [10, 11]. | [10, 11] |

## 4. TEKNİK ÇİZİM STANDARTLARI (FG-TS)

Sistem, teknik çizim uygulamalarında PVC Doğrama standartlarına uygun çıktı üretebilmelidir.

| ID | Gereksinim | Açıklama | Kaynak |
| :--- | :--- | :--- | :--- |
| **FG-TS-01** | Çizim Tipleri | PVC pencere ve kapı görünüş çizimleri ile X-X ve Y-Y doğrultusunda kesitler alınarak detaylandırma yapılabilmelidir [12-14]. | [12-14] |
| **FG-TS-02** | Ölçek Yönetimi | Görünüş ve kesitler için 1/10 veya 1/20 ölçekleri, detaylar için ise 1/2 veya 1/1 ölçekleri kullanılabilmelidir [13-16]. | [13-16] |
| **FG-TS-03** | Detay Açıklamaları | Çizimi yapılan detayın her parçasına ait gerekli bütün açıklamalar ve kullanılan her malzemenin ismi ayrı ayrı yazılmalıdır [17, 18]. | [17, 18] |
| **FG-TS-04** | Profil Tanımlaması | Pencerelerde detay şekilleri; kasa profilleri, pencere kanat profilleri, orta kayıt profilleri ve yardımcı profiller olmak üzere dört bölümde incelenebilmelidir [19]. | [19] |
| **FG-TS-05** | Detaylandırma İşlemleri | Kesit resimlerinde önemli görülen yerler belirlenip isimlendirilerek detay resimleri çizilmelidir [13, 20]. Çizimi yapılan detayın her parçasının taramaları yapılmalıdır [17]. | [13, 17, 20] |

---

> **Özetleyici Analoji:** Windesign'in sunduğu tüm bu işlevler, bir inşaat projesinin sadece mimari tasarımını değil, aynı zamanda hakediş, envanter yönetimi ve lojistik aşamalarını da tek bir web uygulaması üzerinden yöneten entegre bir sistem olmasına benzetilebilir. Bu sayede, saha ve ofis arasındaki bilgi akışı kesintisiz hale gelir.
