/**
   ----------------------------------------------------------------------------
   Use MFRC522 library. Ref: https://github.com/miguelbalboa/rfid

   Typical pin layout used:
   -----------------------------------------------------------------------------------------
               MFRC522      Arduino       Arduino   Arduino    Arduino          Arduino
               Reader/PCD   Uno           Mega      Nano v3    Leonardo/Micro   Pro Micro
   Signal      Pin          Pin           Pin       Pin        Pin              Pin
   -----------------------------------------------------------------------------------------
   RST/Reset   RST          9             5         D9         RESET/ICSP-5     RST
   SPI SS      SDA(SS)      10            53        D10        10               10
   SPI MOSI    MOSI         11 / ICSP-4   51        D11        ICSP-4           16
   SPI MISO    MISO         12 / ICSP-1   50        D12        ICSP-1           14
   SPI SCK     SCK          13 / ICSP-3   52        D13        ICSP-3           15
*/

#include <SPI.h>
#include <MFRC522.h>

#define RST_PIN         9           // Configurable, see typical pin layout above
#define SS_PIN          10          // Configurable, see typical pin layout above

MFRC522 mfrc522(SS_PIN, RST_PIN);   // Create MFRC522 instance.

#define SERIAL_SPEED 115200
#define SER_NUM_LEN 4
unsigned char serNum[SER_NUM_LEN];
bool inField = false;

bool matchSerNum() {
  for (int i = 0; i < SER_NUM_LEN; ++i) {
    if (serNum[i] != mfrc522.uid.uidByte[i]) {
      return false;
    }
  }
  return true;
}

void copySerNum() {
  for (int i = 0; i < SER_NUM_LEN; ++i) {
    serNum[i] = mfrc522.uid.uidByte[i];
  }
}

void clearSerNum() {
  for (int i = 0; i < SER_NUM_LEN; ++i) {
    serNum[i] = 0;
  }
}

void printSerNum() {
  Serial.print("{\"serialNumber\":\"");

  for (int i = 0; i < SER_NUM_LEN; ++i) {
    if (i != 0) {
      Serial.print("-");
    }
    Serial.print(serNum[i], HEX);
  }

  Serial.println("\"}");
}

/**
   Initialize.
*/
void setup() {
  Serial.begin(115200);// Initialize serial communications with the PC
  while (!Serial);     // Do nothing if no serial port is opened (added for Arduinos based on ATMEGA32U4)
  SPI.begin();         // Init SPI bus
  mfrc522.PCD_Init();  // Init MFRC522 card
}

/**
   Main loop.
*/
void loop() {
  bool match;

  // Look for new cards
  if (mfrc522.PICC_IsNewCardPresent()) {
    if (mfrc522.PICC_ReadCardSerial()) {
      
      inField = true;
      match = matchSerNum();
   
      if (!match) {
        copySerNum();
        printSerNum();
      }

      mfrc522.PICC_HaltA();
      return;
    }
  }

  // FIXME: I can not send the out of field info with this lib.
  //        It trigger right away for now.
  if (inField) {
    inField = false;
    // printSerNum();
    clearSerNum();
  }

  mfrc522.PICC_HaltA();
}

