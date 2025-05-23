// WinWinCAD/ViewModels/PencereTasarimViewModel.cs
using WinWinCAD.Core;
using WinWinCAD.Models;
using WinWinCAD.Services;
using System.Collections.ObjectModel;
using System.Collections.Specialized; // For INotifyCollectionChanged
using System.ComponentModel; // For PropertyChangedEventArgs
using System.Windows.Input;
using System.Linq;

namespace WinWinCAD.ViewModels
{
    public class PencereTasarimViewModel : ObservableObject
    {
        private readonly IProfilKutuphaneServisi _profilServisi;

        // Sabit Profil Kalınlıkları
        private const double KasaProfilKalinligi = 50.0; // mm
        private const double KanatProfilKalinligi = 30.0; // mm (Tek kenar için, toplamda 2*bu kadar daralma)

        private PencereTasarimModel _aktifTasarim;
        public PencereTasarimModel AktifTasarim
        {
            get => _aktifTasarim;
            set
            {
                if (_aktifTasarim != null)
                {
                    _aktifTasarim.PropertyChanged -= AktifTasarim_PropertyChanged;
                    if (_aktifTasarim.KanatlarListesi != null)
                    {
                        _aktifTasarim.KanatlarListesi.CollectionChanged -= KanatlarListesi_CollectionChanged;
                        foreach (var kanat in _aktifTasarim.KanatlarListesi)
                        {
                            kanat.PropertyChanged -= Kanat_PropertyChanged;
                        }
                    }
                }

                if (SetProperty(ref _aktifTasarim, value))
                {
                    if (_aktifTasarim != null)
                    {
                        _aktifTasarim.PropertyChanged += AktifTasarim_PropertyChanged;
                        if (_aktifTasarim.KanatlarListesi != null) // KanatlarListesi null olamaz constructor'da atanıyor.
                        {
                             _aktifTasarim.KanatlarListesi.CollectionChanged += KanatlarListesi_CollectionChanged;
                             foreach (var kanat in _aktifTasarim.KanatlarListesi)
                            {
                                kanat.PropertyChanged += Kanat_PropertyChanged;
                            }
                        }
                    }
                    OnPropertyChanged(nameof(NetIcGenislik));
                    OnPropertyChanged(nameof(NetIcYukseklik));
                    GuncelleCizimElemanlari();
                }
            }
        }

        // İç Alan Hesaplama Özellikleri
        public double NetIcGenislik => AktifTasarim != null ? AktifTasarim.GenelGenişlik - (2 * KasaProfilKalinligi) : 0;
        public double NetIcYukseklik => AktifTasarim != null ? AktifTasarim.GenelYükseklik - (2 * KasaProfilKalinligi) : 0;

        // Cizim Elemanları
        public ObservableCollection<CizimElemaniModel> CizimElemanlari { get; } = new ObservableCollection<CizimElemaniModel>();

        private ObservableCollection<ProfilModel> _kullanilabilirKasaProfilleri;
        public ObservableCollection<ProfilModel> KullanilabilirKasaProfilleri
        {
            get => _kullanilabilirKasaProfilleri;
            set => SetProperty(ref _kullanilabilirKasaProfilleri, value);
        }

        private ObservableCollection<ProfilModel> _kullanilabilirKanatProfilleri;
        public ObservableCollection<ProfilModel> KullanilabilirKanatProfilleri
        {
            get => _kullanilabilirKanatProfilleri;
            set => SetProperty(ref _kullanilabilirKanatProfilleri, value);
        }

        private KanatModel? _seciliKanat;
        public KanatModel? SeciliKanat
        {
            get => _seciliKanat;
            set
            {
                if (SetProperty(ref _seciliKanat, value))
                {
                    ((RelayCommand)SilKanatCommand).RaiseCanExecuteChanged();
                    GuncelleCizimElemanlari(); // Seçili kanat değişince çizimde vurgu vs. için
                }
            }
        }

        public ICommand YeniTasarimCommand { get; }
        public ICommand KanatEkleCommand { get; }
        public ICommand SilKanatCommand { get; }

        public PencereTasarimViewModel(IProfilKutuphaneServisi profilServisi)
        {
            _profilServisi = profilServisi;
            _aktifTasarim = new PencereTasarimModel(); // Başlangıçta boş bir tasarım
            _aktifTasarim.PropertyChanged += AktifTasarim_PropertyChanged;
            _aktifTasarim.KanatlarListesi.CollectionChanged += KanatlarListesi_CollectionChanged;

            _kullanilabilirKasaProfilleri = new ObservableCollection<ProfilModel>();
            _kullanilabilirKanatProfilleri = new ObservableCollection<ProfilModel>();

            YeniTasarimCommand = new RelayCommand(p =>
            {
                AktifTasarim = new PencereTasarimModel(); // Bu, setter aracılığıyla eventleri yeniden bağlar.
                LoadKutuphaneVerileri();
                SeciliKanat = null;
                // GuncelleCizimElemanlari(); AktifTasarim setter'ı zaten çağırıyor.
            });
            KanatEkleCommand = new RelayCommand(EkleYeniKanat, CanEkleYeniKanat);
            SilKanatCommand = new RelayCommand(MevcutKanatiSil, () => SeciliKanat != null && AktifTasarim != null && AktifTasarim.KanatlarListesi.Contains(SeciliKanat));

            LoadKutuphaneVerileri();
            GuncelleCizimElemanlari(); // İlk çizimi oluştur
        }

        public PencereTasarimViewModel() : this(new ProfilKutuphaneServisi()) { }

        private void AktifTasarim_PropertyChanged(object? sender, PropertyChangedEventArgs e)
        {
            if (e.PropertyName == nameof(AktifTasarim.GenelGenişlik) || e.PropertyName == nameof(AktifTasarim.GenelYükseklik))
            {
                OnPropertyChanged(nameof(NetIcGenislik));
                OnPropertyChanged(nameof(NetIcYukseklik));
                // Genişlik/Yükseklik değiştiğinde kanatları yeniden boyutlandır/konumlandır
                KanatlariYenidenBoyutlandirVeKonumlandir();
                GuncelleCizimElemanlari();
            }
            if (e.PropertyName == nameof(AktifTasarim.SecilenKasaProfili))
            {
                GuncelleCizimElemanlari();
            }
        }

        private void KanatlarListesi_CollectionChanged(object? sender, NotifyCollectionChangedEventArgs e)
        {
            if (e.Action == NotifyCollectionChangedAction.Add && e.NewItems != null)
            {
                foreach (KanatModel kanat in e.NewItems)
                {
                    kanat.PropertyChanged += Kanat_PropertyChanged;
                }
            }
            else if (e.Action == NotifyCollectionChangedAction.Remove && e.OldItems != null)
            {
                foreach (KanatModel kanat in e.OldItems)
                {
                    kanat.PropertyChanged -= Kanat_PropertyChanged;
                }
            }
            else if (e.Action == NotifyCollectionChangedAction.Reset) // Clear
            {
                 // Eğer eski liste varsa ve temizleniyorsa, onlardan da abonelik kalkmalı
                 // Ancak CollectionChanged bu durumda OldItems sağlamaz.
                 // Bu yüzden AktifTasarim'ın setter'ında eski kanatların abonelikten çıkarılması önemli.
            }

            // Kanat listesi değiştiğinde kanatları yeniden boyutlandır/konumlandır ve çizimi güncelle
            KanatlariYenidenBoyutlandirVeKonumlandir();
            GuncelleCizimElemanlari();
        }

        private void Kanat_PropertyChanged(object? sender, PropertyChangedEventArgs e)
        {
            // Kanadın hangi özellikleri değiştiğinde çizimin güncellenmesi gerektiğine karar ver.
            // Örneğin: Tip, SecilenKanatProfili, SecilenCam
            if (e.PropertyName == nameof(KanatModel.Tip) ||
                e.PropertyName == nameof(KanatModel.SecilenKanatProfili) ||
                e.PropertyName == nameof(KanatModel.SecilenCam) ||
                e.PropertyName == nameof(KanatModel.Genislik) || // Genişlik/Yükseklik değişirse de çizim güncellenmeli
                e.PropertyName == nameof(KanatModel.Yukseklik) ||
                e.PropertyName == nameof(KanatModel.PozisyonX) ||
                e.PropertyName == nameof(KanatModel.PozisyonY) )
            {
                GuncelleCizimElemanlari();
            }
        }

        private void LoadKutuphaneVerileri()
        {
            var tumProfiller = _profilServisi.GetProfiller();
            KullanilabilirKasaProfilleri.Clear();
            foreach (var profil in tumProfiller.Where(p => p.Tip == ProfilTip.Kasa || p.Tip == ProfilTip.Diger))
            {
                KullanilabilirKasaProfilleri.Add(profil);
            }
            KullanilabilirKanatProfilleri.Clear();
            foreach (var profil in tumProfiller.Where(p => p.Tip == ProfilTip.Kanat || p.Tip == ProfilTip.Diger))
            {
                KullanilabilirKanatProfilleri.Add(profil);
            }

            if (AktifTasarim != null && KullanilabilirKasaProfilleri.Any() && AktifTasarim.SecilenKasaProfili == null)
            {
                AktifTasarim.SecilenKasaProfili = KullanilabilirKasaProfilleri.First();
            }
        }

        private bool CanEkleYeniKanat(object? parametre)
        {
            return AktifTasarim != null && NetIcGenislik > 0 && NetIcYukseklik > 0;
        }

        private void EkleYeniKanat(object? parametre)
        {
            if (!CanEkleYeniKanat(parametre) || AktifTasarim == null) return;

            var yeniKanat = new KanatModel
            {
                Ad = $"Kanat {AktifTasarim.KanatlarListesi.Count + 1}",
                // Yükseklik ve PozisyonY başlangıçta iç alanı doldurur
                Yukseklik = NetIcYukseklik, 
                PozisyonY = 0 // İç alanın tepesine göre
            };

            if (KullanilabilirKanatProfilleri.Any())
            {
                yeniKanat.SecilenKanatProfili = KullanilabilirKanatProfilleri.First();
            }
            
            AktifTasarim.KanatlarListesi.Add(yeniKanat); // Bu, CollectionChanged event'ini tetikler,
                                                        // o da KanatlariYenidenBoyutlandirVeKonumlandir ve GuncelleCizimElemanlari'nı çağırır.
            SeciliKanat = yeniKanat;
        }

        private void MevcutKanatiSil(object? parametre)
        {
            if (SeciliKanat != null && AktifTasarim != null && AktifTasarim.KanatlarListesi.Contains(SeciliKanat))
            {
                AktifTasarim.KanatlarListesi.Remove(SeciliKanat); // Bu, CollectionChanged event'ini tetikler.
                SeciliKanat = null;
            }
        }
        
        private void KanatlariYenidenBoyutlandirVeKonumlandir()
        {
            if (AktifTasarim == null || !AktifTasarim.KanatlarListesi.Any())
            {
                GuncelleCizimElemanlari(); // Kanat yoksa bile çizimi temizle/güncelle
                return;
            }

            double toplamKanatSayisi = AktifTasarim.KanatlarListesi.Count;
            double herKanatIcGenisligi = NetIcGenislik / toplamKanatSayisi;
            double currentX = 0;

            foreach(var kanat in AktifTasarim.KanatlarListesi)
            {
                kanat.Genislik = herKanatIcGenisligi; // Kanadın dıştan dışa genişliği (profil dahil)
                kanat.Yukseklik = NetIcYukseklik;   // Kanadın dıştan dışa yüksekliği (profil dahil)
                kanat.PozisyonX = currentX;         // Kanadın iç alana göre X konumu
                kanat.PozisyonY = 0;                // Kanadın iç alana göre Y konumu
                currentX += herKanatIcGenisligi;
            }
            // GuncelleCizimElemanlari(); // Bu metot CollectionChanged'den veya bu metodu çağıran yerden çağrılacak.
        }

        private void GuncelleCizimElemanlari()
        {
            CizimElemanlari.Clear();
            if (AktifTasarim == null) return;

            // 1. Kasa Çizimi
            if (AktifTasarim.GenelGenişlik > 0 && AktifTasarim.GenelYükseklik > 0)
            {
                CizimElemanlari.Add(new CizimElemaniModel 
                { 
                    Tip = "KasaCerceve", X = 0, Y = 0, 
                    Genislik = AktifTasarim.GenelGenişlik, Yukseklik = AktifTasarim.GenelYükseklik, 
                    Renk = "DarkGray", Kalinlik = 2, IliskiliModel = AktifTasarim 
                });
            }

            // 2. İç Alan Çizimi (Kasa profilinin içini temsil eder)
            if (NetIcGenislik > 0 && NetIcYukseklik > 0)
            {
                CizimElemanlari.Add(new CizimElemaniModel 
                { 
                    Tip = "IcAlanCerceve", X = KasaProfilKalinligi, Y = KasaProfilKalinligi, 
                    Genislik = NetIcGenislik, Yukseklik = NetIcYukseklik, 
                    Renk = "LightGray", Kalinlik = 1, IliskiliModel = AktifTasarim 
                });

                // 3. Kanat Çizimleri (İç alanın içine yerleşir)
                foreach (var kanat in AktifTasarim.KanatlarListesi)
                {
                    double kanatDisX = KasaProfilKalinligi + kanat.PozisyonX;
                    double kanatDisY = KasaProfilKalinligi + kanat.PozisyonY;

                    // Kanat Çerçevesi
                    CizimElemanlari.Add(new CizimElemaniModel 
                    { 
                        Tip = "KanatCerceve", X = kanatDisX, Y = kanatDisY, 
                        Genislik = kanat.Genislik, Yukseklik = kanat.Yukseklik, 
                        Renk = (SeciliKanat == kanat) ? "Orange" : "Blue", Kalinlik = 2, IliskiliModel = kanat 
                    });

                    // Kanat İç Alanı (Cam Alanı)
                    double camAlaniX = kanatDisX + KanatProfilKalinligi;
                    double camAlaniY = kanatDisY + KanatProfilKalinligi;
                    double camAlaniGenislik = kanat.Genislik - (2 * KanatProfilKalinligi);
                    double camAlaniYukseklik = kanat.Yukseklik - (2 * KanatProfilKalinligi);

                    if (camAlaniGenislik > 0 && camAlaniYukseklik > 0)
                    {
                        CizimElemanlari.Add(new CizimElemaniModel 
                        { 
                            Tip = "CamAlan", X = camAlaniX, Y = camAlaniY, 
                            Genislik = camAlaniGenislik, Yukseklik = camAlaniYukseklik, 
                            Renk = "LightBlue", Kalinlik = 1, IliskiliModel = kanat 
                        });
                    }
                    
                    // Açılış Yönü Çizgileri (Basit Örnekler)
                    // Bu çizgiler cam alanının ortasına göre veya kenarlarına göre çizilebilir.
                    // Koordinatlar cam alanına göre değil, genel çizim alanına (0,0 sol üst) göre olmalı.
                    double ortaX = camAlaniX + camAlaniGenislik / 2;
                    double ortaY = camAlaniY + camAlaniYukseklik / 2;

                    switch (kanat.Tip)
                    {
                        case KanatTip.IceAcilirSol: // Menteşe solda, içe açılır
                            CizimElemanlari.Add(new CizimElemaniModel { Tip = "AcilisYonuCizgisi", X = camAlaniX, Y = ortaY, X2 = camAlaniX + camAlaniGenislik, Y2 = ortaY, Renk = "Black", Kalinlik = 0.5 }); // Yatay çizgi
                            CizimElemanlari.Add(new CizimElemaniModel { Tip = "AcilisYonuCizgisi", X = camAlaniX, Y = camAlaniY, X2 = camAlaniX, Y2 = camAlaniY + camAlaniYukseklik, Renk = "Black", Kalinlik = 0.5 }); // Menteşe çizgisi
                            break;
                        case KanatTip.IceAcilirSag: // Menteşe sağda, içe açılır
                             CizimElemanlari.Add(new CizimElemaniModel { Tip = "AcilisYonuCizgisi", X = camAlaniX, Y = ortaY, X2 = camAlaniX + camAlaniGenislik, Y2 = ortaY, Renk = "Black", Kalinlik = 0.5 });
                             CizimElemanlari.Add(new CizimElemaniModel { Tip = "AcilisYonuCizgisi", X = camAlaniX + camAlaniGenislik, Y = camAlaniY, X2 = camAlaniX + camAlaniGenislik, Y2 = camAlaniY + camAlaniYukseklik, Renk = "Black", Kalinlik = 0.5 });
                            break;
                        case KanatTip.Vasistas: // Alt menteşe, üste açılır
                            CizimElemanlari.Add(new CizimElemaniModel { Tip = "AcilisYonuCizgisi", X = camAlaniX, Y = camAlaniY + camAlaniYukseklik, X2 = ortaX, Y2 = camAlaniY, Renk = "Black", Kalinlik = 0.5 });
                            CizimElemanlari.Add(new CizimElemaniModel { Tip = "AcilisYonuCizgisi", X = camAlaniX + camAlaniGenislik, Y = camAlaniY + camAlaniYukseklik, X2 = ortaX, Y2 = camAlaniY, Renk = "Black", Kalinlik = 0.5 });
                            break;
                        // Diğer kanat tipleri için de benzer çizgiler eklenebilir.
                    }
                }
            }
        }
    }
}
