// WinWinCAD/Models/CizimElemaniModel.cs
using WinWinCAD.Core;

namespace WinWinCAD.Models
{
    public class CizimElemaniModel : ObservableObject
    {
        private string _tip = string.Empty;
        public string Tip
        {
            get => _tip;
            set => SetProperty(ref _tip, value);
        }

        private double _x;
        public double X
        {
            get => _x;
            set => SetProperty(ref _x, value);
        }

        private double _y;
        public double Y
        {
            get => _y;
            set => SetProperty(ref _y, value);
        }

        private double _genislik;
        public double Genislik
        {
            get => _genislik;
            set => SetProperty(ref _genislik, value);
        }

        private double _yukseklik;
        public double Yukseklik
        {
            get => _yukseklik;
            set => SetProperty(ref _yukseklik, value);
        }

        private string _renk = "Black";
        public string Renk
        {
            get => _renk;
            set => SetProperty(ref _renk, value);
        }

        private double _kalinlik = 1.0;
        public double Kalinlik
        {
            get => _kalinlik;
            set => SetProperty(ref _kalinlik, value);
        }

        private object? _iliskiliModel;
        public object? IliskiliModel // Örn: Hangi KanatModel'e ait olduğu
        {
            get => _iliskiliModel;
            set => SetProperty(ref _iliskiliModel, value);
        }

        // Çizgi elemanları için ek özellikler
        private double _x2;
        public double X2 // Bitiş X koordinatı (çizgiler için)
        {
            get => _x2;
            set => SetProperty(ref _x2, value);
        }

        private double _y2;
        public double Y2 // Bitiş Y koordinatı (çizgiler için)
        {
            get => _y2;
            set => SetProperty(ref _y2, value);
        }
    }
}
