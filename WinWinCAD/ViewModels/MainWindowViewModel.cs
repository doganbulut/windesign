// WinWinCAD/ViewModels/MainWindowViewModel.cs
using WinWinCAD.Core;
using System.Windows.Input; // ICommand için eklendi

namespace WinWinCAD.ViewModels
{
    public class MainWindowViewModel : ObservableObject
    {
        private ObservableObject? _currentViewModel;
        public ObservableObject? CurrentViewModel
        {
            get => _currentViewModel;
            set => SetProperty(ref _currentViewModel, value);
        }

        // Örnek Navigasyon Komutları (İlgili ViewModel'lar daha sonra oluşturulacak)
        public ICommand? NavigateToProfilKutuphanesiCommand { get; }
        public ICommand? NavigateToCamKutuphanesiCommand { get; }
        public ICommand? NavigateToPencereTasarimCommand { get; }

        public MainWindowViewModel()
        {
            // Başlangıç ViewModel'ı burada atanabilir veya null bırakılabilir.
            // CurrentViewModel = new HomeViewModel(); // HomeViewModel örneği

            // Komutların implementasyonları (şimdilik sadece placeholder)
            // NavigateToProfilKutuphanesiCommand = new RelayCommand(param => CurrentViewModel = new ProfilKutuphanesiViewModel());
            // NavigateToCamKutuphanesiCommand = new RelayCommand(param => CurrentViewModel = new CamKutuphanesiViewModel());
            // NavigateToPencereTasarimCommand = new RelayCommand(param => CurrentViewModel = new PencereTasarimViewModel());
            // Yukarıdaki satırlar, ProfilKutuphanesiViewModel vb. sınıflar oluşturulduktan sonra aktif edilecek.
        }
    }
}
