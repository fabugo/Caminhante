#pragma config(Motor,  motorA,          LeftMotor,     tmotorNormal, PIDControl, encoder)
#pragma config(Motor,  motorB,          RightMotor,    tmotorNormal, PIDControl, encoder)
const TMailboxIDs entrada = mailbox1;
int velocity = 20;
void checaCon()
{
  if (nBTCurrentStreamIndex >= 0){
    eraseDisplay();
    nxtDisplayCenteredTextLine(1, "Conectado!!");
    return;
  }
  PlaySound(soundLowBuzz);
  eraseDisplay();
  nxtDisplayCenteredTextLine(3, "BT nao");
  nxtDisplayCenteredTextLine(4, "Conectado");
  wait1Msec(3000);
}
void moveForward(int centimeters, int velocity) {
  int goal = 20.473 * centimeters;

  nMotorEncoder[motorA] = 0;
  nMotorEncoder[motorB] = 0;

  nMotorEncoderTarget[motorA] = goal;

  while(nMotorEncoder[motorA] < goal) {
    motor[motorA] = velocity;
    motor[motorB] = velocity;
  }
  motor[motorA] = 0;
  motor[motorB] = 0;
}

void rotateToRight(int velocity, int degrees) {
  //20.473 * 0.148 = 3.03
  int goal = 3 * degrees;

  nMotorEncoder[motorA] = 0;
  nMotorEncoder[motorB] = 0;

  nMotorEncoderTarget[motorA] = goal;

  while(nMotorEncoder[motorA] < goal) {
    motor[motorA] = velocity;
    motor[motorB] = -velocity;
  }
  motor[motorA] = 0;
  motor[motorB] = 0;
}
void rotateToLeft(int velocity, int degrees) {
  //20.473 * 0.148 = 3.03
  int goal = 3 * degrees;

  nMotorEncoder[motorA] = 0;
  nMotorEncoder[motorB] = 0;

  nMotorEncoderTarget[motorB] = goal;

  while(nMotorEncoder[motorB] < goal) {
    motor[motorA] = -velocity;
    motor[motorB] = velocity;
  }
  motor[motorA] = 0;
  motor[motorB] = 0;
}
void readDataMsg(){
  int messageTam;
  int valor;
  int aux2 =0;
  char auxiliar[4];
  int j=0;
  int i = 0;
  messageTam = cCmdMessageGetSize(entrada);
  if(messageTam<=0)
    return;
  char bufferEntrada[100];
  cCmdMessageRead(bufferEntrada, messageTam, entrada);

  for(i; i < messageTam; i++){
    if(bufferEntrada[i]!=',' && aux2%2==0){
      aux2++;
      for(j=i; j<= i+3; j++){
        auxiliar[j]= bufferEntrada[j];
      }
      i=i+3;
      valor = atoi(auxiliar);

      if (valor<0)
        rotateToLeft(velocity, valor);
      else
        rotateToRight(velocity, valor);
      }else if(bufferEntrada[i]!=',' && aux2%2!=0){
      for(j=i; j<= i+3; j++){
        auxiliar[j]= bufferEntrada[j];
      }
      aux2++;
      i=i+3;
      valor= atoi(auxiliar);
      moveForward(valor, velocity);
    }
  }
  return;
}
task main{
  while(true){
    checaCon();
    readDataMsg();
    wait1Msec(1);
  }
}
