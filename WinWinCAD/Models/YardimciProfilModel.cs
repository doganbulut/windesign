// WinWinCAD/Models/YardimciProfilModel.cs
using WinWinCAD.Core;

namespace WinWinCAD.Models
{
    public enum YardimciProfilTip { BirlesimProfili, KoseDonusProfili, KutuProfil, GYukseltme, Diger }

    public class YardimciProfilModel : ObservableObject
    {
        private string _ad = string.Empty;
        public string Ad
        {
            get => _ad;
            set => SetProperty(ref _ad, value);
        }

        private YardimciProfilTip _tip;
        public YardimciProfilTip Tip
        {
            get => _tip;
            set => SetProperty(ref _tip, value);
        }

        private double _kesitBilgisiA; // Kesite göre değişir, örneğin genişlik
        public double KesitBilgisiA
        {
            get => _kesitBilgisiA;
            set => SetProperty(ref _kesitBilgisiA, value);
        }

        private double _kesitBilgisiB; // Kesite göre değişir, örneğin yükseklik
        public double KesitBilgisiB
        {
            get => _kesitBilgisiB;
            set => SetProperty(ref _kesitBilgisiB, value);
        }

        private double _birimFiyat; // Metre başına fiyat
        public double BirimFiyat
        {
            get => _birimFiyat;
            set => SetProperty(ref _birimFiyat, value);
        }
    }
}
