#!/usr/bin/env node

var arduinoSerial = {
    dev: "/dev/ttyACM0",
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
    '192.168.111.102', // Pascal: Étoile
    '192.168.111.103', // Sébastien: Coeur
    // '192.168.111.104', // ???
    '192.168.111.105', // Sébastien: module #5
    '192.168.111.106', // Sébastien: module #6

//  '192.168.111.108', // Linux computer
    '192.168.111.115', // Jean-François Lambert: 1st batch
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
var command2json = {
  "black":   '{"rgb": [0, 0, 0]}',

  "red":     '{"rgb": [50, 0, 0]}',
  "green":   '{"rgb": [0, 50, 0]}',
  "blue":    '{"rgb": [0, 0, 50]}',

  "fuchsia": '{"rgb": [50, 0, 50]}',
  "aqua":    '{"rgb": [0, 50, 50]}',

  "purple":  '{"rgb": [20, 0, 20]}',
  "coral":   '{"rgb": [50, 30, 0]}',

  "rainbow": '{"fx": "rainbow"}',
  "star":    '{"fx": "star"   }',
  "dot":     '{"fx": "dot"    }',
};

var serial2command = {
  "B5-20-9B-44": 'red',
  "45-A0-36-44": 'green',
  "E5-2-38-44":  'blue',

  "25-AA-38-44": 'fuchsia',
  "5-FE-31-44":  'aqua',

  "55-5E-37-44": 'coral',

  "5-16-7A-44":  'rainbow',
  "C5-92-1B-44": 'star',

  "75-39-38-44": 'dot',
  "35-BD-79-44": 'black',
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
      if (err) throw err; else { console.log('Good!'); }
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
