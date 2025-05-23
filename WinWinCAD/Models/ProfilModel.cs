// WinWinCAD/Models/ProfilModel.cs
using WinWinCAD.Core;
using System.Collections.ObjectModel; // Renkler için

namespace WinWinCAD.Models
{
    public enum ProfilTip { Kasa, Kanat, OrtaKayit, Diger }

    public class ProfilModel : ObservableObject
    {
        private string _ad = string.Empty;
        public string Ad
        {
            get => _ad;
            set => SetProperty(ref _ad, value);
        }

        private ProfilTip _tip;
        public ProfilTip Tip
        {
            get => _tip;
            set => SetProperty(ref _tip, value);
        }

        private double _kesitGenisligi; // mm
        public double KesitGenisligi
        {
            get => _kesitGenisligi;
            set => SetProperty(ref _kesitGenisligi, value);
        }

        private double _kesitYuksekligi; // mm
        public double KesitYuksekligi
        {
            get => _kesitYuksekligi;
            set => SetProperty(ref _kesitYuksekligi, value);
        }

        private double _birimFiyat; // Metre başına fiyat
        public double BirimFiyat
        {
            get => _birimFiyat;
            set => SetProperty(ref _birimFiyat, value);
        }

        private ObservableCollection<string>? _renkler;
        public ObservableCollection<string>? Renkler // RAL kodları veya renk adları
        {
            get => _renkler;
            set => SetProperty(ref _renkler, value);
        }

        // Ek özellikler eklenebilir: Malzeme, Et Kalınlığı, U Değeri vb.
        private string _malzeme = string.Empty;
        public string Malzeme
        {
            get => _malzeme;
            set => SetProperty(ref _malzeme, value);
        }
    }
}
