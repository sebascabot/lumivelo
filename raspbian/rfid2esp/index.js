#!/usr/bin/env node

var arduinoSerial = {
    dev: "/dev/ttyUSB0", // Arduino Nano
    dev: "/dev/ttyACM0", // Arduino UNO
    speed: 115200
}

var dgram = require('dgram');
var assert = require('assert');
var util = require("util");

// ------------------------------------------------------------------------------
// Remote ESP host
// ------------------------------------------------------------------------------
var esp = {
  httpPort: 80,
  udpPort: 8080,
  ips: [
    '192.168.111.100', // #0 Pascal        - Étoile      (30 DELs, RGB)
    '192.168.111.101', // #1 Jean-François - Arc-en-ciel (5m, 60 DELs/m, RGB)
    '192.168.111.102', // #2 Stéphane      - Éclair      (5m, 30 DELs/m, RGB)
    '192.168.111.103', // #3 Sébastien     [BURN]
//  '192.168.111.104', // #4 Pascal        [DEAD]
    '192.168.111.105', // #5 Pascal        - (5m 60 DELs/m) ancien 4
    '192.168.111.106', // #6 Sébastien     - ???
    '192.168.111.107', // #7 Stéphane      - (1m, RGBW)
    '192.168.111.108', // #8 Pascal        - (1m, 144 DELs/m, RGB)
  ]
};

// ------------------------------------------------------------------------------
// SerialPort for RFID data
// ------------------------------------------------------------------------------
var serialport = require("serialport");
var SerialPort = serialport.SerialPort;
var sp = new SerialPort(arduinoSerial.dev, {
  baudrate: arduinoSerial.speed,
  parser: serialport.parsers.readline("\n")
});

// ------------------------------------------------------------------------------
// RFID info: serial, command
// ------------------------------------------------------------------------------
var iMax = 80; // Max Intensity
var command2json = {
  "black":   '{"rgb": [0, 0, 0]}',

  "red":     JSON.stringify({rgb: [iMax, 0, 0]}),
  "lime":    JSON.stringify({rgb: [0, iMax, 0]}),
  "blue":    JSON.stringify({rgb: [0, 0, iMax]}),

  "yellow":  JSON.stringify({rgb: [iMax, iMax, 0]}),
  "fuchsia": JSON.stringify({rgb: [iMax, 0, iMax]}),
  "aqua":    JSON.stringify({rgb: [0, iMax, iMax]}),

  "olive":   JSON.stringify({rgb: [iMax/2, iMax/2, 0]}),
  "purple":  JSON.stringify({rgb: [iMax/2, 0, iMax/2]}),
  "teal":    JSON.stringify({rgb: [0, iMax/2, iMax/2]}),

  "rainbow": '{"fx": "rainbow"}',
  "star":    '{"fx": "star"   }',
  "dot":     '{"fx": "dot"    }',
};

var serial2command = {
  "B5-20-9B-44": 'red',
  "45-A0-36-44": 'lime',
  "E5-2-38-44":  'blue',

  "65-FA-6F-44": 'yellow',
  "25-AA-38-44": 'fuchsia',
  "5-FE-31-44":  'aqua',

  "5-16-7A-44":  'rainbow',
  "C5-92-1B-44": 'star',

  "75-39-38-44": 'dot',
  "35-BD-79-44": 'black',

  // 2nd set of card
  "A5-91-64-44": 'red',
};

var serial2json = {};
Object.keys(serial2command).forEach(function (serial) {
  var command = serial2command[serial];

  // Check every 'serial' have a matching 'json'
  assert(command2json[command], "Missing JSON for command '" + command + "'.");
  serial2json[serial] = command2json[command];
});

// ------------------------------------------------------------------------------
// UDP : Sending Datagram
// ------------------------------------------------------------------------------
var sendDatagrams = function (json) {
  var message = new Buffer(json);

  esp.ips.forEach(function (ip) {
    var client = dgram.createSocket('udp4');
    client.send(message, 0, message.length, esp.udpPort, ip, function (err) {
      // FIXME: We don't want the app to stop during the event, but what should we do in case of error ?
      // if (err) throw err; else { console.log('Good!'); }
      client.close();
    });
  });
};

// ------------------------------------------------------------------------------
// Main loop
// ------------------------------------------------------------------------------

sp.on("open", function () {
  console.log('Opened serial device : ' + this.path);
  console.log('Waiting RFID reading...');
});

sp.on("data", function (data) {
  var serial;
  var command;
  var client;
  var json;

  try {
    json = JSON.parse(data);
  } catch(e) {
    console.log("ERROR: Messy JSON string.");
    console.log(data);
    console.log();
    return;
  }

  // The RFID tag just landed...
  serial = json.serialNumber;
  command = serial2command[serial];
  json = serial2json[serial];

  if (command) {
    console.log("Send command: " + command);
    sendDatagrams(json);
  } else {
    console.log("Black out --- unknown serial#: " + serial);
    sendDatagrams(command2json.black);
  }
});
