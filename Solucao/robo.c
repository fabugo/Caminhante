#pragma config(Motor,  motorA,          LeftMotor,     tmotorNormal, PIDControl, encoder)
#pragma config(Motor,  motorB,          RightMotor,    tmotorNormal, PIDControl, encoder)
const TMailboxIDs entrada = mailbox1;
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
void readDataMsg(){
  int messageTam;
  messageTam = cCmdMessageGetSize(entrada);
  if(messageTam<=0)
    return;
  char bufferEntrada[100];
  cCmdMessageRead(bufferEntrada, messageTam, entrada);

  //for(int i = 0; i < messageTam; i++){

  //}
  return;
}
task main{
  while(true){
    checaCon();
    readDataMsg();
    wait1Msec(1);
  }
}
