from typing import List, Dict, Optional

class Profil:
    def __init__(self, ad: str, tip: str, kesit_geometrisi: Dict[str, float], birim_fiyat: float, renk: str):
        self.ad = ad
        self.tip = tip
        self.kesit_geometrisi = kesit_geometrisi  # e.g., {'genislik': 60, 'yukseklik': 50}
        self.birim_fiyat = birim_fiyat
        self.renk = renk

    def __repr__(self):
        return f"Profil(ad='{self.ad}', tip='{self.tip}')"

class Cam:
    def __init__(self, ad: str, tip: str, kalinlik_str: str, birim_metrekare_fiyat: float, u_degeri: Optional[float] = None):
        self.ad = ad
        self.tip = tip
        self.kalinlik_str = kalinlik_str  # e.g., '4+16+4'
        self.birim_metrekare_fiyat = birim_metrekare_fiyat
        self.u_degeri = u_degeri

    def __repr__(self):
        return f"Cam(ad='{self.ad}', tip='{self.tip}', kalinlik='{self.kalinlik_str}')"

class Kanat:
    def __init__(self, tip: str, genislik: float, yukseklik: float, cam: Cam):
        self.tip = tip  # e.g., 'tek_acilir_sag', 'sabit'
        self.genislik = genislik
        self.yukseklik = yukseklik
        self.cam = cam  # Cam object
        self.acilim_yonu_cizgileri: List[Dict[str, float]] = []  # Placeholder for opening direction lines coordinates

    def __repr__(self):
        return f"Kanat(tip='{self.tip}', genislik={self.genislik}, yukseklik={self.yukseklik})"

class OrtaKayit:
    def __init__(self, tip: str, pozisyon: float, profil_tipi: Profil):
        self.tip = tip  # e.g., 'dikey', 'yatay'
        self.pozisyon = pozisyon  # Distance or proportional value from the edge it's attached to
        self.profil_tipi = profil_tipi # Profil object

    def __repr__(self):
        return f"OrtaKayit(tip='{self.tip}', pozisyon={self.pozisyon})"

class PencereOgesi:
    def __init__(self, id: str, ad: str, genel_genislik: float, genel_yukseklik: float, profil_tipi: Profil, adet: int = 1):
        self.id = id
        self.ad = ad
        self.genel_genislik = genel_genislik
        self.genel_yukseklik = genel_yukseklik
        self.profil_tipi = profil_tipi  # Profil object
        self.kanatlar: List[Kanat] = []
        self.orta_kayitlar: List[OrtaKayit] = []
        self.adet = adet

    def __repr__(self):
        return f"PencereOgesi(id='{self.id}', ad='{self.ad}', genislik={self.genel_genislik}, yukseklik={self.genel_yukseklik})"

if __name__ == '__main__':
    # Example Usage (Optional - for testing purposes)
    profil_60x50 = Profil(ad="P6050", tip="Kasa Profili", kesit_geometrisi={'genislik': 60, 'yukseklik': 50}, birim_fiyat=150.0, renk="Beyaz")
    cam_4_16_4 = Cam(ad="C4164", tip="Isıcam", kalinlik_str="4+16+4", birim_metrekare_fiyat=250.0, u_degeri=1.1)
    
    pencere_1 = PencereOgesi(id="P001", ad="Salon Penceresi", genel_genislik=1500.0, genel_yukseklik=1200.0, profil_tipi=profil_60x50, adet=2)
    
    kanat_sabit = Kanat(tip="sabit", genislik=700.0, yukseklik=1100.0, cam=cam_4_16_4)
    pencere_1.kanatlar.append(kanat_sabit)
    
    orta_kayit_dikey = OrtaKayit(tip="dikey", pozisyon=750.0, profil_tipi=profil_60x50)
    pencere_1.orta_kayitlar.append(orta_kayit_dikey)
    
    print(profil_60x50)
    print(cam_4_16_4)
    print(pencere_1)
    print(pencere_1.kanatlar)
    print(pencere_1.orta_kayitlar)
