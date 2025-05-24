import json
import uuid
import os
from typing import List, Dict, Optional
from .models import Profil, Cam, PencereOgesi, Kanat, OrtaKayit # Added PencereOgesi, Kanat, OrtaKayit for future use

class KutuphaneYoneticisi:
    def profilleri_yukle(self, dosya_yolu: str) -> List[Profil]:
        profiller: List[Profil] = []
        try:
            with open(dosya_yolu, 'r', encoding='utf-8') as f:
                data = json.load(f)
                for profil_data in data:
                    profiller.append(Profil(**profil_data))
        except FileNotFoundError:
            print(f"Hata: Profil dosyası bulunamadı: {dosya_yolu}")
            # Alternatif olarak: raise
        except json.JSONDecodeError:
            print(f"Hata: Profil dosyası JSON formatında değil: {dosya_yolu}")
            # Alternatif olarak: raise
        except Exception as e:
            print(f"Profil yüklenirken beklenmedik bir hata oluştu: {e}")
            # Alternatif olarak: raise
        return profiller

    def camlari_yukle(self, dosya_yolu: str) -> List[Cam]:
        camlar: List[Cam] = []
        try:
            with open(dosya_yolu, 'r', encoding='utf-8') as f:
                data = json.load(f)
                for cam_data in data:
                    camlar.append(Cam(**cam_data))
        except FileNotFoundError:
            print(f"Hata: Cam dosyası bulunamadı: {dosya_yolu}")
            # Alternatif olarak: raise
        except json.JSONDecodeError:
            print(f"Hata: Cam dosyası JSON formatında değil: {dosya_yolu}")
            # Alternatif olarak: raise
        except Exception as e:
            print(f"Cam yüklenirken beklenmedik bir hata oluştu: {e}")
            # Alternatif olarak: raise
        return camlar

class ProjeYoneticisi:
    def __init__(self, profil_dosya_yolu: str = "data/profiller.json", cam_dosya_yolu: str = "data/camlar.json"):
        self.pencere_ogeleri: List[PencereOgesi] = []
        self.kutuphane_yoneticisi = KutuphaneYoneticisi()

        # Adjust paths to be relative to the script's directory if they are not absolute
        base_dir = os.path.dirname(os.path.abspath(__file__)) 
        
        if not os.path.isabs(profil_dosya_yolu):
            profil_dosya_yolu = os.path.join(base_dir, profil_dosya_yolu)
        if not os.path.isabs(cam_dosya_yolu):
            cam_dosya_yolu = os.path.join(base_dir, cam_dosya_yolu)
            
        self.profiller = self.kutuphane_yoneticisi.profilleri_yukle(profil_dosya_yolu)
        self.camlar = self.kutuphane_yoneticisi.camlari_yukle(cam_dosya_yolu)

    def yeni_proje(self):
        self.pencere_ogeleri.clear()
        # Reset other project-specific information if necessary
        print("Yeni proje oluşturuldu.")

    def proje_ac(self, dosya_yolu: str):
        # Placeholder for loading project from JSON
        print(f"Proje açma özelliği henüz implemente edilmedi: {dosya_yolu}")
        pass

    def proje_kaydet(self, dosya_yolu: str):
        # Placeholder for saving project to JSON
        print(f"Proje kaydetme özelliği henüz implemente edilmedi: {dosya_yolu}")
        pass

    def yeni_pencere_ogesi_ekle(self, genel_genislik: float, genel_yukseklik: float, ad: str, profil_tipi_adi: str, cam_tipi_adi: str, adet: int = 1) -> Optional[PencereOgesi]:
        secilen_profil: Optional[Profil] = None
        for profil in self.profiller:
            if profil.ad == profil_tipi_adi: # Assuming 'ad' is unique identifier for selection for now
                secilen_profil = profil
                break
        
        secilen_cam: Optional[Cam] = None
        for cam in self.camlar:
            if cam.ad == cam_tipi_adi: # Assuming 'ad' is unique for selection
                secilen_cam = cam
                break

        if not secilen_profil:
            print(f"Hata: Profil tipi bulunamadı: {profil_tipi_adi}")
            return None
        if not secilen_cam:
            print(f"Hata: Cam tipi bulunamadı: {cam_tipi_adi}") # This was missing in the original thought process, adding for completeness
            return None

        yeni_id = str(uuid.uuid4())
        yeni_pencere = PencereOgesi(id=yeni_id, ad=ad, genel_genislik=genel_genislik, genel_yukseklik=genel_yukseklik, profil_tipi=secilen_profil, adet=adet)
        
        # Optional: Add a default 'fixed' Kanat
        # For simplicity, this part is kept basic. Profile thickness deduction would be needed for accurate inner dimensions.
        # kanat_genislik = genel_genislik - 2 * secilen_profil.kesit_geometrisi.get('genislik', 50) # Example deduction
        # kanat_yukseklik = genel_yukseklik - 2 * secilen_profil.kesit_geometrisi.get('yukseklik', 50) # Example deduction
        # if kanat_genislik > 0 and kanat_yukseklik > 0:
        #     varsayilan_kanat = Kanat(tip="sabit", genislik=kanat_genislik, yukseklik=kanat_yukseklik, cam=secilen_cam)
        #     yeni_pencere.kanatlar.append(varsayilan_kanat)

        self.pencere_ogeleri.append(yeni_pencere)
        print(f"Yeni pencere öğesi eklendi: {ad}, ID: {yeni_id}")
        return yeni_pencere

if __name__ == '__main__':
    # Test KutuphaneYoneticisi
    # Paths are now relative to this manager.py file for testing
    current_dir = os.path.dirname(os.path.abspath(__file__))
    profiller_test_path = os.path.join(current_dir, "profiller.json")
    camlar_test_path = os.path.join(current_dir, "camlar.json")

    # Create dummy files if they don't exist for testing KutuphaneYoneticisi directly
    if not os.path.exists(profiller_test_path):
        with open(profiller_test_path, 'w') as pf:
            json.dump([{"ad": "Test Profil", "tip": "test_kasa", "kesit_geometrisi": {"genislik": 60, "yukseklik": 50}, "birim_fiyat": 100, "renk": "Beyaz"}], pf)
    if not os.path.exists(camlar_test_path):
        with open(camlar_test_path, 'w') as cf:
            json.dump([{"ad": "Test Cam", "tip": "test_cift", "kalinlik_str": "4+16+4", "birim_metrekare_fiyat": 200}], cf)
            
    kutuphane_yoneticisi = KutuphaneYoneticisi()
    profiller = kutuphane_yoneticisi.profilleri_yukle(profiller_test_path)
    camlar = kutuphane_yoneticisi.camlari_yukle(camlar_test_path)
    print("Kütüphane Yöneticisi Test:")
    print(f"Yüklenen Profiller: {profiller}")
    print(f"Yüklenen Camlar: {camlar}")
    print("-" * 20)

    # Test ProjeYoneticisi
    # ProjeYoneticisi will use its default paths "data/profiller.json" and "data/camlar.json"
    # which are relative to the location of manager.py
    # Ensure these files exist in the "data" subdirectory relative to manager.py for this test to pass
    # For this example, we'll assume they are correctly located by the ProjeYoneticisi's __init__
    
    # To make this test self-contained for ProjeYoneticisi, let's ensure the paths are correct
    # for where the JSON files were created in the previous step (PencerePyCAD/data/)
    # This means ProjeYoneticisi should be instantiated with paths relative to the project root,
    # or the test should ensure files are in "PencerePyCAD/data/data/" if manager.py is in "PencerePyCAD/data/"
    
    # Assuming the script is run from PencerePyCAD directory or manager.py is in PencerePyCAD/data
    project_base_dir = os.path.dirname(os.path.dirname(os.path.abspath(__file__))) # Moves up to PencerePyCAD
    profiller_json_path = os.path.join(project_base_dir, "data", "profiller.json")
    camlar_json_path = os.path.join(project_base_dir, "data", "camlar.json")

    # Ensure the actual data files exist for ProjeYoneticisi test
    # This is a bit redundant with the previous step, but good for clarity
    os.makedirs(os.path.join(project_base_dir, "data"), exist_ok=True)
    if not os.path.exists(profiller_json_path):
         with open(profiller_json_path, 'w') as pf:
            json.dump([{"ad": "Kasa Profili 60mm", "tip": "kasa_60mm", "kesit_geometrisi": {"genislik": 60, "yukseklik": 50}, "birim_fiyat": 100, "renk": "Beyaz"}], pf)
    if not os.path.exists(camlar_json_path):
        with open(camlar_json_path, 'w') as cf:
            json.dump([{"ad": "Çift Cam Standart", "tip": "cift_cam_standart", "kalinlik_str": "4+16+4", "birim_metrekare_fiyat": 250}], cf)


    print("\nProje Yöneticisi Test:")
    # Pass the correct paths to ProjeYoneticisi for testing
    proje_yoneticisi = ProjeYoneticisi(profil_dosya_yolu=profiller_json_path, cam_dosya_yolu=camlar_json_path)
    print(f"Başlangıç Profilleri: {proje_yoneticisi.profiller}")
    print(f"Başlangıç Camları: {proje_yoneticisi.camlar}")

    proje_yoneticisi.yeni_proje()
    
    pencere_ogesi_1 = proje_yoneticisi.yeni_pencere_ogesi_ekle(
        genel_genislik=1500, 
        genel_yukseklik=1200, 
        ad="Salon Penceresi 1", 
        profil_tipi_adi="Kasa Profili 60mm", # Must match an "ad" in profiller.json
        cam_tipi_adi="Çift Cam Standart"    # Must match an "ad" in camlar.json
    )
    
    if pencere_ogesi_1:
        print(f"Eklenen Pencere Ögesi: {pencere_ogesi_1}")
        print(f"Projedeki Pencere Öğeleri: {proje_yoneticisi.pencere_ogeleri}")

    pencere_ogesi_2 = proje_yoneticisi.yeni_pencere_ogesi_ekle(
        genel_genislik=800, 
        genel_yukseklik=1000, 
        ad="Mutfak Penceresi", 
        profil_tipi_adi="Kanat Profili 70mm", # This might fail if not in profiller.json
        cam_tipi_adi="Konfor Cam" # This might fail if not in camlar.json
    )
    if pencere_ogesi_2:
        print(f"Eklenen Pencere Ögesi: {pencere_ogesi_2}")
    else:
        print("Mutfak penceresi eklenemedi (profil veya cam bulunamadı).")

    print(f"Projedeki toplam pencere öğesi: {len(proje_yoneticisi.pencere_ogeleri)}")

