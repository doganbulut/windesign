// WinWinCAD/Services/ProfilKutuphaneServisi.cs
using WinWinCAD.Models;
using System.Collections.Generic;
using System.Collections.ObjectModel; // ObservableCollection için
using System.Linq; // Linq sorguları için

namespace WinWinCAD.Services
{
    public interface IProfilKutuphaneServisi
    {
        ObservableCollection<ProfilModel> GetProfiller();
        ProfilModel? GetProfilById(string ad); // ID olarak Ad kullanıyoruz, daha sonra int Id eklenebilir
        void AddProfil(ProfilModel profil);
        void UpdateProfil(ProfilModel profil);
        void DeleteProfil(string ad);
        // Ileride JSON/XML'e kaydetme/yükleme metotları eklenebilir
        // void SaveProfillerToLocalFile(string filePath);
        // ObservableCollection<ProfilModel> LoadProfillerFromLocalFile(string filePath);
    }

    public class ProfilKutuphaneServisi : IProfilKutuphaneServisi
    {
        private readonly ObservableCollection<ProfilModel> _profiller;

        public ProfilKutuphaneServisi()
        {
            // Başlangıç verileri burada yüklenebilir veya ViewModel'dan buraya taşınabilir.
            // Şimdilik ViewModel'daki örnek verileri kullanacağız, bu servis ViewModel tarafından doldurulacak
            // ya da servis kendi başlangıç verilerini yükleyecek.
            // Bu örnekte, servisin kendi örnek verilerini yönetmesini sağlayalım.
            _profiller = new ObservableCollection<ProfilModel>
            {
                new ProfilModel { Ad = "7000 Kasa Profili S", Tip = ProfilTip.Kasa, KesitGenisligi = 70, KesitYuksekligi = 58, BirimFiyat = 155, Malzeme = "PVC", Renkler = new ObservableCollection<string>{"Beyaz", "Altın Meşe"} },
                new ProfilModel { Ad = "7000 Z Kanat Profili S", Tip = ProfilTip.Kanat, KesitGenisligi = 78, KesitYuksekligi = 58, BirimFiyat = 185, Malzeme = "PVC", Renkler = new ObservableCollection<string>{"Beyaz"} },
                new ProfilModel { Ad = "7000 Orta Kayıt T S", Tip = ProfilTip.OrtaKayit, KesitGenisligi = 70, KesitYuksekligi = 70, BirimFiyat = 165, Malzeme = "PVC", Renkler = new ObservableCollection<string>{"Beyaz", "Antrasit Gri"} }
            };
        }

        public ObservableCollection<ProfilModel> GetProfiller()
        {
            return _profiller;
        }

        public ProfilModel? GetProfilById(string ad)
        {
            return _profiller.FirstOrDefault(p => p.Ad == ad);
        }

        public void AddProfil(ProfilModel profil)
        {
            if (profil != null && !_profiller.Any(p => p.Ad == profil.Ad)) // Basit bir benzersizlik kontrolü
            {
                _profiller.Add(profil);
            }
            // Else: Handle error or duplicate entry
        }

        public void UpdateProfil(ProfilModel profil)
        {
            if (profil == null) return;

            var existingProfil = _profiller.FirstOrDefault(p => p.Ad == profil.Ad);
            if (existingProfil != null)
            {
                // ObservableObject'tan geldiği için özelliklerin tek tek güncellenmesi
                // UI'ın otomatik güncellenmesini sağlar.
                // Ya da nesneyi listeden çıkarıp yenisini ekleyebiliriz ama bu seçimi etkileyebilir.
                // Bu örnekte, var olan nesnenin özelliklerini güncelleyelim.
                existingProfil.Tip = profil.Tip;
                existingProfil.KesitGenisligi = profil.KesitGenisligi;
                existingProfil.KesitYuksekligi = profil.KesitYuksekligi;
                existingProfil.BirimFiyat = profil.BirimFiyat;
                existingProfil.Malzeme = profil.Malzeme;
                existingProfil.Renkler = profil.Renkler; // Bu, ObservableCollection'ın kendisini değiştirir.
                                                       // Eğer renkler koleksiyonu içindeki item'lar değişiyorsa,
                                                       // Renkler özelliği için de OnPropertyChanged çağrılmalı.
            }
        }

        public void DeleteProfil(string ad)
        {
            var profilToRemove = _profiller.FirstOrDefault(p => p.Ad == ad);
            if (profilToRemove != null)
            {
                _profiller.Remove(profilToRemove);
            }
        }
    }
}
