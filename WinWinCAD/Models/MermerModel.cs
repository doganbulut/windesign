// WinWinCAD/Models/MermerModel.cs
using WinWinCAD.Core;

namespace WinWinCAD.Models
{
    public class MermerModel : ObservableObject
    {
        private string _ad = string.Empty; // Örn: "Akşehir Siyah Mermer", "Granit Denizlik"
        public string Ad
        {
            get => _ad;
            set => SetProperty(ref _ad, value);
        }

        private string _malzeme = string.Empty; // Mermer, Granit, Kompozit vb.
        public string Malzeme
        {
            get => _malzeme;
            set => SetProperty(ref _malzeme, value);
        }

        private double _kalinlik; // cm
        public double Kalinlik
        {
            get => _kalinlik;
            set => SetProperty(ref _kalinlik, value);
        }

        private double _derinlik; // cm (Pencere dışına taşma miktarı)
        public double Derinlik
        {
            get => _derinlik;
            set => SetProperty(ref _derinlik, value);
        }

        private double _birimFiyat; // Metre veya m² başına fiyat (kullanıma göre değişir)
        public double BirimFiyat
        {
            get => _birimFiyat;
            set => SetProperty(ref _birimFiyat, value);
        }
    }
}
