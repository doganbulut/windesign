// WinWinCAD/Models/AksesuarModel.cs
using WinWinCAD.Core;

namespace WinWinCAD.Models
{
    public enum AksesuarTip { Kol, Mentes, Ispanyolet, Kilit, CiftAcilimMekanizmasi, VasistasMekanizmasi, SurmeMekanizmasi, Diger }

    public class AksesuarModel : ObservableObject
    {
        private string _ad = string.Empty;
        public string Ad
        {
            get => _ad;
            set => SetProperty(ref _ad, value);
        }

        private AksesuarTip _tip;
        public AksesuarTip Tip
        {
            get => _tip;
            set => SetProperty(ref _tip, value);
        }

        private double _birimFiyat; // Adet veya takım başına fiyat
        public double BirimFiyat
        {
            get => _birimFiyat;
            set => SetProperty(ref _birimFiyat, value);
        }

        private string _marka = string.Empty;
        public string Marka
        {
            get => _marka;
            set => SetProperty(ref _marka, value);
        }

        private string _modelKodu = string.Empty;
        public string ModelKodu
        {
            get => _modelKodu;
            set => SetProperty(ref _modelKodu, value);
        }
    }
}
