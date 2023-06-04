# Yaptigim Butun Gomulu-Sistemler Alistirmalari

:speech_balloon: Bilgi notu :speech_balloon:
- Verilog'da yapilmistir
- Gowin_V1.9.8.10'de yapilmistir
# Gomulu Sistemler Tek Port RAM

GoWin FPGA Designer'da Bellek tasarlanacak. Tek yollu hem okunup hem yazilabilecek. Yukselen kenarda yazacak, dusen kenarda ise okuyacak. 16 bit veri obegi bulunacak ve 16 satir olacak.

:speech_balloon: Sipeed Lichee Tang Nano1K :speech_balloon:
- Series: GW1NZ 
- Device: GW1NZ-1 
- Package: QFN48 
- Speed: C6/I5

:point_right: Kaynak kodlar :point_left:
- 203405025_tek_port_ram -> src -> ram.v

:eye: Kodlari anlattigim videolarin Google Drive linki :eye:
- [Google Drive](https://drive.google.com/drive/folders/1qPFqAUCvFFrxKNvoYxlAy5LtIagxVx2h?usp=sharing)

# Trafik Sinyalizasyon Kontrolu

GoWin FPGA Designer'da Trafik isiklari sinyalizasyonu yapilacak. 10sn kirmizi, 2sn sari (rgb ledler de sari olmadigi icin mavi ledi yaktim) ve 5sn yesil led yanacak. Yesilden sonra tekrar kirmizi yanacak ve bu dongu seklinde devam edecek.

:speech_balloon: Sipeed Lichee Tang Nano1K :speech_balloon:
- Series: GW1NZ 
- Device: GW1NZ-1 
- Package: QFN48 
- Speed: C6/I5

:point_right: Fazladan eklediklerim :point_left:
- Reset tusuna basildiginda beyaz isik yanip sonmesi. Resetlendigi daha kolay anlasiliyor.

:point_right: Kaynak kodlar :point_left:
- 203405025_trafik_sinyalizasyonu -> src -> trafik_sinyalizasyonu.v

:eye: Kodlari anlattigim videolarin Google Drive linki :eye:
- [Google Drive](https://drive.google.com/drive/folders/1qPFqAUCvFFrxKNvoYxlAy5LtIagxVx2h?usp=sharing)


