#include <SPI.h>
#include <Ethernet.h>

byte mac[] = { 0xDE, 0xAD, 0xBE, 0xEF, 0xFE, 0xED };
IPAddress ip(192, 168, 3, 21); 

EthernetServer server(80);

const int ledPin = 8;

void setup() {
  Serial.begin(9600);

  Ethernet.begin(mac, ip);

  server.begin();
  Serial.print("Servidor iniciado. Endereço IP: ");
  Serial.println(Ethernet.localIP());

  pinMode(ledPin, OUTPUT);
} // fim do método setup()

void loop() {
  EthernetClient client = server.available();
  if (client) {
    Serial.println("Cliente conectado");
    boolean currentLineIsBlank = true;
    String request = ""; // aqui