// WinWinCAD/Models/CitaModel.cs
using WinWinCAD.Core;

namespace WinWinCAD.Models
{
    public class CitaModel : ObservableObject
    {
        private string _ad = string.Empty;
        public string Ad
        {
            get => _ad;
            set => SetProperty(ref _ad, value);
        }

        private string _tip = string.Empty; // Örn: "4mm Cam Çıtası", "24mm Isıcam Çıtası"
        public string Tip
        {
            get => _tip;
            set => SetProperty(ref _tip, value);
        }

        private string? _uyumluProfilSerisi; // Hangi profil serileriyle uyumlu olduğu (opsiyonel)
        public string? UyumluProfilSerisi
        {
            get => _uyumluProfilSerisi;
            set => SetProperty(ref _uyumluProfilSerisi, value);
        }

        private double _birimFiyat; // Metre başına fiyat
        public double BirimFiyat
        {
            get => _birimFiyat;
            set => SetProperty(ref _birimFiyat, value);
        }

        private string _malzeme = string.Empty;
        public string Malzeme
        {
            get => _malzeme;
            set => SetProperty(ref _malzeme, value); // PVC, Alüminyum
        }
    }
}
