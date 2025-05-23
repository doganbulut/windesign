// WinWinCAD/Models/CamModel.cs
using WinWinCAD.Core;

namespace WinWinCAD.Models
{
    public enum CamTip { Duz, Isicam, IsicamKonfor, IsicamSinus, UcPlusBir, Akustik, Lamine, Temperli, Diger }

    public class CamModel : ObservableObject
    {
        private string _ad = string.Empty;
        public string Ad
        {
            get => _ad;
            set => SetProperty(ref _ad, value);
        }

        private double _kalinlik; // mm (örn: 4, 24 (4+16+4 için), 30)
        public double Kalinlik
        {
            get => _kalinlik;
            set => SetProperty(ref _kalinlik, value);
        }

        private CamTip _tip;
        public CamTip Tip
        {
            get => _tip;
            set => SetProperty(ref _tip, value);
        }

        private double _birimFiyat; // m² başına fiyat
        public double BirimFiyat
        {
            get => _birimFiyat;
            set => SetProperty(ref _birimFiyat, value);
        }

        private double _uDegeri; // W/m²K
        public double UDegeri
        {
            get => _uDegeri;
            set => SetProperty(ref _uDegeri, value);
        }
    }
}
