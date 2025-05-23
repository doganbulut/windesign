// WinWinCAD/Models/PervazModel.cs
using WinWinCAD.Core;

namespace WinWinCAD.Models
{
    public enum PervazKonum { Ic, Dis, CiftTarafli }

    public class PervazModel : ObservableObject
    {
        private string _ad = string.Empty;
        public string Ad
        {
            get => _ad;
            set => SetProperty(ref _ad, value);
        }

        private string _tip = string.Empty; // Örn: "Düz Pervaz", "Kendinden Contalı Pervaz"
        public string Tip
        {
            get => _tip;
            set => SetProperty(ref _tip, value);
        }

        private PervazKonum _konum;
        public PervazKonum Konum
        {
            get => _konum;
            set => SetProperty(ref _konum, value);
        }

        private double _genislik; // mm
        public double Genislik
        {
            get => _genislik;
            set => SetProperty(ref _genislik, value);
        }

        private double _birimFiyat; // Metre başına fiyat
        public double BirimFiyat
        {
            get => _birimFiyat;
            set => SetProperty(ref _birimFiyat, value);
        }
    }
}
