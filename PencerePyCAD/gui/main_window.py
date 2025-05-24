import sys
from PyQt6.QtWidgets import (
    QMainWindow, QApplication, QMenuBar, QToolBar, QDockWidget,
    QListWidget, QLabel, QGraphicsView, QMessageBox, QListWidgetItem
)
from PyQt6.QtGui import QAction
from PyQt6.QtCore import Qt

from ..data.manager import ProjeYoneticisi
from .drawing_canvas import PencereCizimSahnesi, PencereCizimMotoru


class MainWindow(QMainWindow):
    def __init__(self):
        super().__init__()
        
        # Initialize managers and drawing tools
        self.proje_yoneticisi = ProjeYoneticisi() # This will load default profiller.json and camlar.json
        self.cizim_motoru = PencereCizimMotoru()
        self.scene = PencereCizimSahnesi()

        self.initUI()
        
        # Set scene for the graphics view
        self.ui_graphics_view.setScene(self.scene)


    def initUI(self):
        self.setWindowTitle("PencerePyCAD")
        self.setGeometry(100, 100, 1200, 800)

        # Menu Bar
        menubar = self.menuBar()
        
        file_menu = menubar.addMenu("Dosya")
        file_menu.addAction(QAction("Yeni Proje", self)) # Renamed for clarity
        file_menu.addAction(QAction("Proje Aç", self))
        file_menu.addAction(QAction("Proje Kaydet", self))

        edit_menu = menubar.addMenu("Düzenle")
        edit_menu.addAction(QAction("Geri Al", self))
        edit_menu.addAction(QAction("İleri Al", self))

        design_menu = menubar.addMenu("Tasarım")
        # "Yeni Dikdörtgen Öğe" action
        yeni_pencere_action = QAction("Yeni Dikdörtgen Öğe", self)
        yeni_pencere_action.triggered.connect(self.yeni_dikdortgen_pencere_ekle)
        design_menu.addAction(yeni_pencere_action)
        design_menu.addAction(QAction("Tasarım Ayarları", self))


        library_menu = menubar.addMenu("Kütüphane")
        library_menu.addAction(QAction("Kütüphane Yöneticisi", self))

        reports_menu = menubar.addMenu("Raporlar")
        reports_menu.addAction(QAction("Rapor Oluştur", self))

        settings_menu = menubar.addMenu("Ayarlar")
        settings_menu.addAction(QAction("Uygulama Ayarları", self))

        help_menu = menubar.addMenu("Yardım")
        help_menu.addAction(QAction("Hakkında", self))

        # Toolbars
        project_toolbar = self.addToolBar("Proje Araçları")
        # project_toolbar.addAction(QAction("Yeni Proje", self)) # Already in menu
        # project_toolbar.addAction(QAction("Proje Aç", self))   # Already in menu

        design_toolbar = self.addToolBar("Tasarım Araçları")
        design_toolbar.addAction(yeni_pencere_action) # Added "Yeni Dikdörtgen Öğe" to toolbar

        window_types_toolbar = self.addToolBar("Pencere/Kanat Tipleri")
        # window_types_toolbar.addAction(QAction("Tip 1", self)) # Example action

        view_draw_toolbar = self.addToolBar("Görünüm/Çizim Araçları")
        # view_draw_toolbar.addAction(QAction("Yakınlaştır", self)) # Example action

        # Dock Widgets
        element_list_dock = QDockWidget("Öğe Listesi", self)
        element_list_dock.setAllowedAreas(Qt.DockWidgetArea.LeftDockWidgetArea | Qt.DockWidgetArea.RightDockWidgetArea)
        self.ui_list_widget = QListWidget() # Changed to instance variable
        self.ui_list_widget.currentItemChanged.connect(self.secili_ogeyi_ciz)
        element_list_dock.setWidget(self.ui_list_widget)
        self.addDockWidget(Qt.DockWidgetArea.LeftDockWidgetArea, element_list_dock)

        properties_panel_dock = QDockWidget("Özellikler Paneli", self)
        properties_panel_dock.setAllowedAreas(Qt.DockWidgetArea.LeftDockWidgetArea | Qt.DockWidgetArea.RightDockWidgetArea)
        self.ui_properties_label = QLabel("Özellikler burada gösterilecek") # Changed to instance variable
        properties_panel_dock.setWidget(self.ui_properties_label)
        self.addDockWidget(Qt.DockWidgetArea.RightDockWidgetArea, properties_panel_dock)

        # Central Widget
        self.ui_graphics_view = QGraphicsView() # Changed to instance variable
        # self.scene is already initialized in __init__
        self.ui_graphics_view.setScene(self.scene)
        self.setCentralWidget(self.ui_graphics_view)

    def yeni_dikdortgen_pencere_ekle(self):
        if not self.proje_yoneticisi.profiller:
            QMessageBox.warning(self, "Kütüphane Hatası", "Profil kütüphanesi boş. Lütfen önce profil ekleyin.")
            return
        if not self.proje_yoneticisi.camlar:
            QMessageBox.warning(self, "Kütüphane Hatası", "Cam kütüphanesi boş. Lütfen önce cam ekleyin.")
            return

        # Use the first available profile and glass as default
        varsayilan_profil_adi = self.proje_yoneticisi.profiller[0].ad
        varsayilan_cam_adi = self.proje_yoneticisi.camlar[0].ad
        
        # Create new window element
        yeni_oge = self.proje_yoneticisi.yeni_pencere_ogesi_ekle(
            genel_genislik=1000, 
            genel_yukseklik=1500, 
            ad=f"Yeni Pencere {self.ui_list_widget.count() + 1}", 
            profil_tipi_adi=varsayilan_profil_adi, 
            cam_tipi_adi=varsayilan_cam_adi
        )
        
        if yeni_oge:
            list_item_text = f"{yeni_oge.ad} ({yeni_oge.genel_genislik}x{yeni_oge.genel_yukseklik}) - {yeni_oge.adet} adet"
            list_item = QListWidgetItem(list_item_text)
            list_item.setData(Qt.ItemDataRole.UserRole, yeni_oge.id)
            self.ui_list_widget.addItem(list_item)
            self.ui_list_widget.setCurrentItem(list_item) # This should trigger secili_ogeyi_ciz

    def secili_ogeyi_ciz(self, current_item: QListWidgetItem, previous_item: QListWidgetItem):
        # previous_item is passed by the signal but not used here.
        if not current_item:
            self.scene.clear()
            # Optionally, update properties panel to be empty
            # self.ui_properties_label.setText("Özellikler burada gösterilecek")
            return

        oge_id = current_item.data(Qt.ItemDataRole.UserRole)
        secilen_pencere_ogesi = next((pencere for pencere in self.proje_yoneticisi.pencere_ogeleri if pencere.id == oge_id), None)
        
        if secilen_pencere_ogesi:
            self.scene.clear()
            self.cizim_motoru.pencere_ciz(self.scene, secilen_pencere_ogesi)
            
            # Adjust view to fit the drawn items with some margin
            bounding_rect = self.scene.itemsBoundingRect()
            # Add a margin, e.g., 50 units on each side
            margin = 50 
            self.ui_graphics_view.setSceneRect(bounding_rect.adjusted(-margin, -margin, margin, margin))
            
            # Update properties panel (simple example)
            # self.ui_properties_label.setText(f"ID: {secilen_pencere_ogesi.id}\nAd: {secilen_pencere_ogesi.ad}\nBoyut: {secilen_pencere_ogesi.genel_genislik}x{secilen_pencere_ogesi.genel_yukseklik}")
        else:
            self.scene.clear()
            # self.ui_properties_label.setText("Seçili öğe bulunamadı.")

if __name__ == '__main__':
    # Ensure app.py handles this if running the whole application
    # This block is mainly for testing MainWindow directly if needed
    app = QApplication(sys.argv)
    main_win = MainWindow()
    main_win.show()
    sys.exit(app.exec())
