from PyQt6.QtWidgets import QGraphicsScene, QGraphicsRectItem, QGraphicsLineItem, QGraphicsTextItem
from PyQt6.QtGui import QColor, QPen, QBrush
from PyQt6.QtCore import Qt

# Forward reference for PencereOgesi, or direct import if preferred and no circular dependency
# from ..data.models import PencereOgesi 

class PencereCizimSahnesi(QGraphicsScene):
    def __init__(self, parent=None):
        super().__init__(parent)

class PencereCizimMotoru:
    def pencere_ciz(self, scene: QGraphicsScene, pencere_ogesi: 'PencereOgesi', profil_gorsel_kalinlik: float = 50.0):
        # Required imports are already at the top of the file
        
        gen_w = pencere_ogesi.genel_genislik
        gen_h = pencere_ogesi.genel_yukseklik

        # Clear scene before drawing new elements
        # scene.clear() # This should be done by the caller (e.g., in MainWindow) before calling this.

        # Dış Kasa Çizimi
        kasa_dis_rect = QGraphicsRectItem(0, 0, gen_w, gen_h)
        kasa_dis_rect.setPen(QPen(Qt.GlobalColor.black, 2))
        scene.addItem(kasa_dis_rect)

        kasa_ic_rect = QGraphicsRectItem(profil_gorsel_kalinlik, profil_gorsel_kalinlik, 
                                         gen_w - 2 * profil_gorsel_kalinlik, 
                                         gen_h - 2 * profil_gorsel_kalinlik)
        kasa_ic_rect.setPen(QPen(Qt.GlobalColor.black, 1))
        scene.addItem(kasa_ic_rect)

        # Sabit Cam Alanı Çizimi (assuming single fixed pane for now)
        # This will be drawn inside the inner frame.
        # If there are mullions or sashes, this logic would need to be more complex.
        cam_alan_genislik = gen_w - 2 * profil_gorsel_kalinlik
        cam_alan_yukseklik = gen_h - 2 * profil_gorsel_kalinlik
        
        if cam_alan_genislik > 0 and cam_alan_yukseklik > 0:
            cam_rect = QGraphicsRectItem(profil_gorsel_kalinlik, profil_gorsel_kalinlik, 
                                         cam_alan_genislik, cam_alan_yukseklik)
            cam_rect.setBrush(QBrush(QColor(173, 216, 230, 128))) # Light blue with some transparency
            cam_rect.setPen(Qt.PenStyle.NoPen) # No border for the glass itself
            scene.addItem(cam_rect)

        # Ölçülendirme Çizgileri
        offset = 30
        uzatma = 10 # Not directly used in this simplified version, but good to keep in mind
        isaret_uzunlugu = 10
        ölçü_pen = QPen(Qt.GlobalColor.black, 1)

        # Genişlik Ölçüsü (Altta)
        line_gen = QGraphicsLineItem(0, gen_h + offset, gen_w, gen_h + offset)
        line_gen.setPen(ölçü_pen)
        mark_sol_gen = QGraphicsLineItem(0, gen_h + offset - isaret_uzunlugu / 2, 0, gen_h + offset + isaret_uzunlugu / 2)
        mark_sol_gen.setPen(ölçü_pen)
        mark_sag_gen = QGraphicsLineItem(gen_w, gen_h + offset - isaret_uzunlugu / 2, gen_w, gen_h + offset + isaret_uzunlugu / 2)
        mark_sag_gen.setPen(ölçü_pen)
        
        text_gen = QGraphicsTextItem(str(int(gen_w)))
        text_gen.setPos(gen_w / 2 - text_gen.boundingRect().width() / 2, gen_h + offset + 5)
        text_gen.setDefaultTextColor(Qt.GlobalColor.black) # Ensure text color
        
        scene.addItem(line_gen)
        scene.addItem(mark_sol_gen)
        scene.addItem(mark_sag_gen)
        scene.addItem(text_gen)

        # Yükseklik Ölçüsü (Solda)
        line_yuk = QGraphicsLineItem(-offset, 0, -offset, gen_h)
        line_yuk.setPen(ölçü_pen)
        mark_ust_yuk = QGraphicsLineItem(-offset - isaret_uzunlugu / 2, 0, -offset + isaret_uzunlugu / 2, 0)
        mark_ust_yuk.setPen(ölçü_pen)
        mark_alt_yuk = QGraphicsLineItem(-offset - isaret_uzunlugu / 2, gen_h, -offset + isaret_uzunlugu / 2, gen_h)
        mark_alt_yuk.setPen(ölçü_pen)

        text_yuk = QGraphicsTextItem(str(int(gen_h)))
        text_yuk.setDefaultTextColor(Qt.GlobalColor.black) # Ensure text color
        text_yuk.setRotation(-90)
        # Adjust position after rotation: x is new y, y is new x (width/height also swapped in bounding rect)
        text_yuk.setPos(-offset - text_yuk.boundingRect().height() / 2 - 5, gen_h / 2 + text_yuk.boundingRect().width() / 2)
        
        scene.addItem(line_yuk)
        scene.addItem(mark_ust_yuk)
        scene.addItem(mark_alt_yuk)
        scene.addItem(text_yuk)

# Example usage (for testing this module directly)
if __name__ == '__main__':
    from PyQt6.QtWidgets import QApplication, QGraphicsView
    import sys
    # Need a mock PencereOgesi for testing
    class MockPencereOgesi:
        def __init__(self, id, ad, gen_w, gen_h, profil, adet=1):
            self.id = id
            self.ad = ad
            self.genel_genislik = gen_w
            self.genel_yukseklik = gen_h
            # self.profil_tipi = profil # Not directly used by drawing engine yet
            self.adet = adet

    app = QApplication(sys.argv)
    
    scene = PencereCizimSahnesi()
    view = QGraphicsView(scene)
    view.setWindowTitle("Pencere Çizim Testi")
    view.resize(800, 600)

    # Create a mock PencereOgesi
    mock_profil_data = {"ad": "P6050", "tip": "Kasa Profili", "kesit_geometrisi": {'genislik': 60, 'yukseklik': 50}, "birim_fiyat": 150.0, "renk": "Beyaz"}
    # from ..data.models import Profil # Profil would be needed if PencereCizimMotoru used it
    # mock_profil = Profil(**mock_profil_data) 
    
    test_pencere = MockPencereOgesi(id="test01", ad="Test Pencere", gen_w=1200, gen_h=1000, profil=None)

    # Draw the mock object
    motor = PencereCizimMotoru()
    motor.pencere_ciz(scene, test_pencere, profil_gorsel_kalinlik=60)
    
    # Fit view to scene contents
    view.setSceneRect(scene.itemsBoundingRect().adjusted(-50, -50, 50, 50)) # Add some margin
    
    view.show()
    sys.exit(app.exec())
