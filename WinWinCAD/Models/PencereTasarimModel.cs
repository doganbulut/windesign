// WinWinCAD/Models/PencereTasarimModel.cs
using WinWinCAD.Core;
using System.Collections.ObjectModel;

namespace WinWinCAD.Models
{
    public class PencereTasarimModel : ObservableObject
    {
        private string _projeAdi = "Yeni Pencere Projesi";
        public string ProjeAdi
        {
            get => _projeAdi;
            set => SetProperty(ref _projeAdi, value);
        }

        private double _genelGenişlik = 1000; // mm
        public double GenelGenişlik
        {
            get => _genelGenişlik;
            set
            {
                if (SetProperty(ref _genelGenişlik, value))
                {
                    // Genişlik değiştiğinde ilgili hesaplamalar veya çizim güncellemeleri tetiklenebilir.
                    OnPropertyChanged(nameof(Alan)); // Örnek bir bağımlı özellik
                }
            }
        }

        private double _genelYükseklik = 1200; // mm
        public double GenelYükseklik
        {
            get => _genelYükseklik;
            set
            {
                if (SetProperty(ref _genelYükseklik, value))
                {
                    // Yükseklik değiştiğinde ilgili hesaplamalar veya çizim güncellemeleri tetiklenebilir.
                    OnPropertyChanged(nameof(Alan)); // Örnek bir bağımlı özellik
                }
            }
        }

        public double Alan => GenelGenişlik * GenelYükseklik / 1000000.0; // m² cinsinden

        private ProfilModel? _secilenKasaProfili;
        public ProfilModel? SecilenKasaProfili
        {
            get => _secilenKasaProfili;
            set => SetProperty(ref _secilenKasaProfili, value);
        }
        
        private ObservableCollection<KanatModel> _kanatlarListesi;
        public ObservableCollection<KanatModel> KanatlarListesi
        {
            get => _kanatlarListesi;
            set => SetProperty(ref _kanatlarListesi, value);
        }

        // İleride eklenebilecekler:
        // private ObservableCollection<OrtaKayitModel> _ortaKayitlarListesi;
        // private MermerModel? _secilenMermer;
        // private PervazModel? _secilenIcPerfaz;
        // private PervazModel? _secilenDisPerfaz;

        public PencereTasarimModel()
        {
            KanatlarListesi = new ObservableCollection<KanatModel>();
            // OrtaKayitlarListesi = new ObservableCollection<OrtaKayitModel>();
        }
    }
}
