/*  
 * Read a card using a mfrc522 reader on your SPI interface  
  * Pin layout should be as follows (on Arduino Uno):  
  * MOSI: Pin 11 / ICSP-4  
  * MISO: Pin 12 / ICSP-1  
  * SCK: Pin 13 / ISCP-3  
  * SS: Pin 10  
  * RST: Pin 5  
  */  
 #include <SPI.h>  
 #include <RFID.h>  
 #define SS_PIN 10  
 #define RST_PIN 5  
 RFID rfid(SS_PIN,RST_PIN);  
 int serNum[5];  
 void setup(){  
  Serial.begin(9600);  
  SPI.begin();  
  rfid.init();  
 }  
 void loop(){  
  if(rfid.isCard()){  
   if(rfid.readCardSerial()) {  
    Serial.print(rfid.serNum[0],DEC);  
    Serial.print(" ");  
    Serial.print(rfid.serNum[1],DEC);  
    Serial.print(" ");  
    Serial.print(rfid.serNum[2],DEC);  
    Serial.print(" ");  
    Serial.print(rfid.serNum[3],DEC);  
    Serial.print(" ");  
    Serial.print(rfid.serNum[4],DEC);  
    Serial.println("");  
   }  
  }  
  rfid.halt();  
 }  
