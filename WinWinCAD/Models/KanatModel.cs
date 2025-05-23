// WinWinCAD/Models/KanatModel.cs
using WinWinCAD.Core;
using System.Collections.ObjectModel; // Aksesuarlar için

namespace WinWinCAD.Models
{
    public enum KanatTip { Sabit, IceAcilirSol, IceAcilirSag, DisaAcilirSol, DisaAcilirSag, Vasistas, CiftAcilir, SurmeSol, SurmeSag, Pivot }

    public class KanatModel : ObservableObject
    {
        private string _ad = "Yeni Kanat";
        public string Ad // Kanat için bir tanımlayıcı, örn: "Sol Açılır Kanat"
        {
            get => _ad;
            set => SetProperty(ref _ad, value);
        }

        private KanatTip _tip = KanatTip.Sabit;
        public KanatTip Tip
        {
            get => _tip;
            set => SetProperty(ref _tip, value);
        }

        private double _genislik; // mm, Kanadın kendi genişliği (Kasa içi ölçüden türetilir genelde)
        public double Genislik
        {
            get => _genislik;
            set => SetProperty(ref _genislik, value);
        }

        private double _yukseklik; // mm, Kanadın kendi yüksekliği
        public double Yukseklik
        {
            get => _yukseklik;
            set => SetProperty(ref _yukseklik, value);
        }
        
        // Kanadın ana pencere içindeki konumu (sol üst köşe koordinatları)
        // Bu, çizim ve yerleşim için önemli olacak.
        private double _pozisyonX; 
        public double PozisyonX
        {
            get => _pozisyonX;
            set => SetProperty(ref _pozisyonX, value);
        }

        private double _pozisyonY;
        public double PozisyonY
        {
            get => _pozisyonY;
            set => SetProperty(ref _pozisyonY, value);
        }

        private ProfilModel? _secilenKanatProfili;
        public ProfilModel? SecilenKanatProfili
        {
            get => _secilenKanatProfili;
            set => SetProperty(ref _secilenKanatProfili, value);
        }

        private CamModel? _secilenCam;
        public CamModel? SecilenCam
        {
            get => _secilenCam;
            set => SetProperty(ref _secilenCam, value);
        }
        
        private CitaModel? _secilenCita;
        public CitaModel? SecilenCita
        {
            get => _secilenCita;
            set => SetProperty(ref _secilenCita, value);
        }

        private ObservableCollection<AksesuarModel>? _aksesuarlarListesi;
        public ObservableCollection<AksesuarModel>? AksesuarlarListesi
        {
            get => _aksesuarlarListesi;
            set => SetProperty(ref _aksesuarlarListesi, value);
        }

        public KanatModel()
        {
            AksesuarlarListesi = new ObservableCollection<AksesuarModel>();
        }
    }
}
