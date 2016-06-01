/*
    Read a card using a mfrc522 reader on your SPI interface.

    Pin layout should be as follows (on Arduino Uno):

    MOSI: Pin 11 / ICSP-4
    MISO: Pin 12 / ICSP-1
     SCK: Pin 13 / ISCP-3
      SS: Pin 10
     RST: Pin 5
*/

#include <SPI.h>
#include <RFID.h>

#define SS_PIN 10
#define RST_PIN 5

RFID rfid(SS_PIN, RST_PIN);

#define SERIAL_SPEED 115200
#define SER_NUM_LEN 4
unsigned char serNum[SER_NUM_LEN];
bool inField = false;

bool matchSerNum() {
  for (int i = 0; i < SER_NUM_LEN; ++i) {
    if (serNum[i] != rfid.serNum[i]) {
      return false;
    }
  }
  return true;
}

void copySerNum() {
  for (int i = 0; i < SER_NUM_LEN; ++i) {
    serNum[i] = rfid.serNum[i];
  }
}

void clearSerNum() {
  for (int i = 0; i < SER_NUM_LEN; ++i) {
    serNum[i] = 0;
  }
}

void printSerNum() {
  Serial.print("{\"serialNumber\": \"");

  for (int i = 0; i < SER_NUM_LEN; ++i) {
    if (i != 0) {
      Serial.print("-");
    }
    Serial.print(serNum[i], HEX);
  }

  Serial.print("\", \"inField\": ");
  Serial.print(inField, DEC);
  Serial.println("}");
}

void setup() {
  Serial.begin(SERIAL_SPEED);
  SPI.begin();
  rfid.init();
}

void loop () {
  bool match;

  if (rfid.isCard()) {
    if (rfid.readCardSerial()) {
      inField = true;
      match = matchSerNum();
      if (!match) {
        copySerNum();
        printSerNum();
      }
      rfid.halt();
      return;
    }
  }

  if (inField) {
    inField = false;
    printSerNum();
    clearSerNum();
  }

  rfid.halt();
}
