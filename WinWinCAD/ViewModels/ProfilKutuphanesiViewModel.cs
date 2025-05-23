// WinWinCAD/ViewModels/ProfilKutuphanesiViewModel.cs
using WinWinCAD.Core;
using WinWinCAD.Models;
using WinWinCAD.Services; // Servisi kullanmak için eklendi
using System.Collections.ObjectModel;
using System.Windows.Input;

namespace WinWinCAD.ViewModels
{
    public class ProfilKutuphanesiViewModel : ObservableObject
    {
        private readonly IProfilKutuphaneServisi _profilServisi; // Servis referansı

        private ObservableCollection<ProfilModel> _profiller;
        public ObservableCollection<ProfilModel> Profiller
        {
            get => _profiller;
            set => SetProperty(ref _profiller, value);
        }

        private ProfilModel? _seciliProfil;
        public ProfilModel? SeciliProfil
        {
            get => _seciliProfil;
            set
            {
                // SetProperty, değer gerçekten değiştiyse true döner.
                if (SetProperty(ref _seciliProfil, value)) 
                {
                    if (_seciliProfil != null)
                    {
                        // Seçili profili düzenleme formuna kopyala
                        DuzenlenenProfil = new ProfilModel 
                        {
                            Ad = _seciliProfil.Ad,
                            Tip = _seciliProfil.Tip,
                            KesitGenisligi = _seciliProfil.KesitGenisligi,
                            KesitYuksekligi = _seciliProfil.KesitYuksekligi,
                            BirimFiyat = _seciliProfil.BirimFiyat,
                            Malzeme = _seciliProfil.Malzeme,
                            Renkler = _seciliProfil.Renkler != null ? new ObservableCollection<string>(_seciliProfil.Renkler) : new ObservableCollection<string>()
                        };
                    }
                    else
                    {
                        // Seçim kalkınca düzenleme formunu temizle.
                        YeniProfilMetodu(null); // Bu, DuzenlenenProfil'i temizler ve SeciliProfil'i (zaten null ise) tekrar null yapmaya çalışmaz.
                    }
                    ((RelayCommand)SilProfilCommand).RaiseCanExecuteChanged();
                    // DuzenlenenProfil değiştiğinde Kaydet komutunun durumu onun setter'ı tarafından güncellenir.
                    // ((RelayCommand)KaydetProfilCommand).RaiseCanExecuteChanged(); // Bu satır DuzenlenenProfil'in setter'ında olmalı.
                }
            }
        }

        private ProfilModel _duzenlenenProfil;
        public ProfilModel DuzenlenenProfil
        {
            get => _duzenlenenProfil;
            set 
            {
                if (SetProperty(ref _duzenlenenProfil, value))
                {
                    // DuzenlenenProfil değiştiğinde Kaydet komutunun durumu güncellenmeli.
                    ((RelayCommand)KaydetProfilCommand).RaiseCanExecuteChanged();
                }
            }
        }

        public ICommand YeniProfilCommand { get; }
        public ICommand SilProfilCommand { get; }
        public ICommand KaydetProfilCommand { get; }

        public ProfilKutuphanesiViewModel(IProfilKutuphaneServisi profilServisi)
        {
            _profilServisi = profilServisi;
            _profiller = _profilServisi.GetProfiller(); 
            _duzenlenenProfil = new ProfilModel { Renkler = new ObservableCollection<string>() };

            YeniProfilCommand = new RelayCommand(YeniProfilMetodu);
            SilProfilCommand = new RelayCommand(SilProfilMetodu, () => SeciliProfil != null); 
            KaydetProfilCommand = new RelayCommand(KaydetProfilMetodu, CanKaydetProfilMetodu);
            
            YeniProfilMetodu(null); // Başlangıçta formu temizle
        }
        
        public ProfilKutuphanesiViewModel() : this(new ProfilKutuphaneServisi())
        {
        }

        private void YeniProfilMetodu(object? parametre)
        {
            DuzenlenenProfil = new ProfilModel { Renkler = new ObservableCollection<string>() };
            // Eğer bir seçim varsa, Yeni'ye basıldığında bu seçimi kaldırmak mantıklıdır.
            // Bu, SeciliProfil'in setter'ını tetikleyerek ilgili komutların (örn: Sil) CanExecute durumunu günceller.
            if (_seciliProfil != null) // Sadece _seciliProfil alanı null değilse SeciliProfil özelliğini null yap.
            {
                SeciliProfil = null; 
            }
            // DuzenlenenProfil değiştiği için Kaydet komutunun durumu zaten setter'ı tarafından güncellenir.
        }

        private void SilProfilMetodu(object? parametre)
        {
            if (SeciliProfil != null)
            {
                _profilServisi.DeleteProfil(SeciliProfil.Ad);
                // _profiller koleksiyonu servisteki ObservableCollection'a referans verdiği için
                // ve servis bu koleksiyonu doğrudan değiştirdiği için UI otomatik güncellenir.
                SeciliProfil = null; // Bu, setter üzerinden DuzenlenenProfil'i temizler ve Sil butonunu devre dışı bırakır.
            }
        }

        private void KaydetProfilMetodu(object? parametre)
        {
            if (DuzenlenenProfil == null || string.IsNullOrWhiteSpace(DuzenlenenProfil.Ad)) return;

            var mevcutProfilServiste = _profilServisi.GetProfilById(DuzenlenenProfil.Ad);

            // Durum 1: DuzenlenenProfil.Ad ile serviste bir kayıt var (mevcutProfilServiste != null)
            if (mevcutProfilServiste != null)
            {
                // Eğer SeciliProfil null ise VEYA SeciliProfil.Ad, DuzenlenenProfil.Ad'dan farklıysa,
                // bu, kullanıcının yeni girdiği Ad'ın zaten BAŞKA BİR kayda ait olduğu anlamına gelir. Bu bir çakışma.
                if (SeciliProfil == null || (SeciliProfil != null && SeciliProfil.Ad != DuzenlenenProfil.Ad))
                {
                    // Hata: "Bu isimde bir profil zaten mevcut, farklı bir isim deneyin."
                    // Kullanıcıya bu durumu bildirmek iyi olurdu. Şimdilik işlemi iptal ediyoruz.
                    // Örneğin bir mesaj kutusu gösterilebilir.
                    // System.Windows.MessageBox.Show("Bu 'Ad' ile başka bir profil zaten mevcut. Lütfen farklı bir ad seçin.", "Çakışma", MessageBoxButton.OK, MessageBoxImage.Warning);
                    return; 
                }
                // Eğer SeciliProfil.Ad, DuzenlenenProfil.Ad ile aynıysa, bu net bir GÜNCELLEME işlemidir.
                _profilServisi.UpdateProfil(DuzenlenenProfil);
            }
            // Durum 2: DuzenlenenProfil.Ad ile serviste bir kayıt YOK (mevcutProfilServiste == null)
            // Bu, yeni bir kayıt EKLEME anlamına gelir.
            else 
            {
                _profilServisi.AddProfil(DuzenlenenProfil);
            }
            
            // İşlem sonrası formu temizle ve seçimi kaldır.
            YeniProfilMetodu(null);
            // Profiller listesi servisteki ObservableCollection olduğu için UI zaten güncel olmalı.
        }

        private bool CanKaydetProfilMetodu(object? parametre)
        {
            return DuzenlenenProfil != null && !string.IsNullOrWhiteSpace(DuzenlenenProfil.Ad);
        }
    }
}
