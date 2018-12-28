int channel1 = A3;     // channel one lead connected to analog pin 3
int val1 = 0;          // variable to store the value read
int channel2 = A5;     // channel two lead connected to analog pin 5
int val2 = 0;          // variable to store the value read

void setup()
{
  Serial.begin(9600);              //  setup serial
}

void loop()
{
  val1 = analogRead(channel1);     // read the input pin
  Serial.println(val1);            // send value
  val2 = analogRead(channel2);     // read the input pin
  Serial.println(val2);            // send value
}
