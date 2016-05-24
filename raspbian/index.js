#!/usr/bin/env node

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
  ]
};

// ------------------------------------------------------------------------------
// SerialPort for RFID data
// ------------------------------------------------------------------------------
var serialport = require("serialport");
var SerialPort = serialport.SerialPort;
var sp = new SerialPort("/dev/ttyACM0", {
  baudrate: 115200,
  parser: serialport.parsers.readline("\n")
});

// ------------------------------------------------------------------------------
// RFID info: serial, command
// ------------------------------------------------------------------------------
var command2json = {
  "black":     '{"color": [0, 0, 0]}',

  "red":     '{"color": [200, 0, 0]}',
  "green":   '{"color": [0, 200, 0]}',
  "blue":    '{"color": [0, 0, 200]}',

  "yellow":  '{"color": [200, 200, 0]}',
  "fuchsia": '{"color": [200, 0, 200]}',
  "aqua":    '{"color": [0, 200, 200]}',

  "purple":  '{"color": [80, 0, 80]}',
  "coral":   '{"color": [200, 120, 0]}',
};

var serial2command = {
  "181-32-155-68-74":  'red',
  "21-167-101-68-147": 'green',
  "100-24-32-150-202": 'blue',

  "5-22-122-68-45":    'yellow',
  "37-170-56-68-243":  'fuchsia',
  "5-254-49-68-142":   'aqua',

  // "":  'purple', // Ligth fushsia
  "85-94-55-68-120":   'coral',
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

  if (!json.hasOwnProperty('inField')) {
    console.log("ERROR: JSON data is missing 'inField' property: '" + data + "'.");
    return;
  }

  if (json.inField) {
    // The RFID tag just landed...

    serial = json.serialNumber;
    command = serial2command[serial];
    json = serial2json[serial];

    if (command) {
      console.log("Send command: " + command);
      sendDatagrams(json);
    } else {
      console.log("Send command: Black out --- serial#: " + serial);
      sendDatagrams(command2json.black);
    }
  } else {
    // The RFID tag is leaving...
  }

});