// variveis globais
const TMailboxIDs entradaBT = mailbox1;
const int velocity= 30;
// funcoes
void moveForward(int centimeters, int velocity) {
  int goal = 20.473 * centimeters;

	nMotorEncoder[motorA] = 0;
	nMotorEncoder[motorB] = 0;

	nMotorEncoderTarget[motorA] = goal;

	while(nMotorEncoder[motorC] < goal) {
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
void iniciarBluetooth(){
  int messageTam;
   ubyte valor;
   char bufferEntrada[15];
    messageTam= cCmdMessageGetSize(entradaBT);
    cCmdMessageRead(bufferEntrada, messageTam, entradaBT);
    if(bufferEntrada[0] == 'A' || bufferEntrada[0] =='a'){
	      if((ubyte) bufferEntrada[1] >= 0){
	        valor= (ubyte)bufferEntrada[1];
	        rotateToRight(velocity,valor);
	      } else if((ubyte)bufferEntrada[1] < 0 ){
	          valor= (ubyte)bufferEntrada[1];
	          rotateToLeft(velocity,valor);
	      }
	   } else if (bufferEntrada [0] == 'D' || bufferEntrada [0]== 'd'){
	      valor= bufferEntrada[1];
	      moveForward(valor, velocity);
	   }
    return ;
    return ;
  }
}

task main()
{

	iniciarBluetooth();
}
