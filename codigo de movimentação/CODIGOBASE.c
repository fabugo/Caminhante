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

task main()
{

	rotateToLeft(30,90);
	rotateToRight(30,90);
}
