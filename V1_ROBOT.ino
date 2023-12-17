#include <Servo.h>  
#include <Math.h>   
Servo myservo1; 
Servo myservo2; 
Servo myservo3; 
float pi = 3.14;
// limit
int axis1_limit[2],axis2_limit[2],axis3_limit[2];
//home position
int axis1_home=100,axis2_home=95,axis3_home=90;
//toa do goc
int pos1 = 0,pos2 = 0,pos3 = 0;
int cur_pos1 = 0,cur_pos2 = 0,cur_pos3 = 0;
int omega1=0,omega2=0,omega3=0;
// toa do x,y,z
int x,y,z;
// end-effector
bool ee=false;
// learning 
int i; // so diem da hoc
int points[10][3];
// end effector 
bool ee_flag=false;
int ee_pin=12;

void goHome(){
  int speed=20;
  cur_pos1= myservo1.read();
  cur_pos2= myservo2.read();
  cur_pos3= myservo3.read();
  while (cur_pos1!=axis1_home)
  {
    if (cur_pos1 > axis1_home) {
          cur_pos1--; // Decrease value1 by 1
        } else {
          cur_pos1++; // Increase value1 by 1
    }
    myservo1.write(cur_pos1);
    delay(speed);
    }
  while (cur_pos2!=axis2_home)
  {
    if (cur_pos2 > axis2_home) {
          cur_pos2--; // Decrease value1 by 1
        } else {
          cur_pos2++; // Increase value1 by 1
    }
    myservo2.write(cur_pos2);
    delay(speed);
    }
  while (cur_pos3!=axis3_home)
  {
    if (cur_pos3 > axis3_home) {
          cur_pos3--; // Decrease value1 by 1
        } else {
          cur_pos3++; // Increase value1 by 1
    }
    myservo3.write(cur_pos3);
    delay(speed);
    }
}
void setup() { 
    pinMode(ee_pin, OUTPUT);

    myservo1.attach(9);
    myservo2.attach(10);
    myservo3.attach(11);
    Serial.begin(9600);
    // setup limit of servo 
    axis1_limit[0]=35;
    axis2_limit[0]=35;
    axis3_limit[0]=35;
    axis1_limit[1]=215;
    axis2_limit[1]=215;
    axis3_limit[1]=215;

    // Setup 
    goHome();
    i=0;
} 


void axis1_goto(int desired_pos)
{
  int pos=myservo1.read();
  while (pos!=desired_pos)
  {
    if (pos > desired_pos) {
          pos--; // Decrease value1 by 1
        } else {
          pos++; // Increase value1 by 1
    }
    myservo1.write(pos);
    delay(18);
    }
}
void axis2_goto(int desired_pos)
{
  int pos=myservo2.read();
  while (pos!=desired_pos)
  {
    if (pos > desired_pos) {
          pos--; // Decrease value1 by 1
        } else {
          pos++; // Increase value1 by 1
    }
    myservo2.write(pos);
    delay(18);
    }
}
void axis3_goto(int desired_pos)
{
  int pos=myservo3.read();
  while (pos!=desired_pos)
  {
    if (pos > desired_pos) {
          pos--; // Decrease value1 by 1
        } else {
          pos++; // Increase value1 by 1
    }
    myservo3.write(pos);
    delay(18);
    }
}
int lamtron(float a){
  a = a*180/pi;
  float thamso=0;
  thamso = a - (int)a;
  if (thamso>0.5)
    return ((int)a+1);
  else
    return (int)a;
}
void decodeString(String inputString, int &x, int &y, int &z) {
  // Find the position of the commas in the string
  int comma1 = inputString.indexOf(',');
  //Serial.print(comma1);
  int comma2 = inputString.indexOf(',', comma1 + 1);

  // Extract substrings from the original string
  String xString = inputString.substring(0,comma1);
  String yString = inputString.substring(comma1 + 1, comma2);
  String zString = inputString.substring(comma2 + 1);

  // Convert substrings to integers
  x = xString.toInt();
  y = yString.toInt();
  z = zString.toInt();
  /*
  Serial.print("X: ");
  Serial.println(x);
  Serial.print("Y: ");
  Serial.println(y);
  Serial.print("Z: ");
  Serial.println(z);
  */
}

void calculate1(int x, int y, int z, int *pos1, int *pos2, int *pos3){
  float theta1=0,theta2=0,theta3=0;
  // tinh theta1
  float r = sqrt(pow(x, 2) + pow(y, 2));
  theta1=asin((-10.5)/r)-acos(x/r);
  //tinh theta2
  float A,B;
  float a,b,c;
  A = x*cos(theta1)+y*sin(theta1);
  B = z-108.5;
  a = -2*A*250;
  b = 2*B*250;
  c = -pow(250, 2)-pow(A, 2)-pow(B, 2); 
  r = sqrt(pow(a, 2) + pow(a, 2));
  theta2=asin((c)/r)-acos(b/r);
  //tinh theta3
  theta3 = acos((z-108.5+250*sin(theta2))/250)-theta2;
  // gan toa do cho robot 
  if(theta1<0)
    theta1=-theta1;
  
  //gan vi tri cho robot
  *pos1=x;
  *pos2=y;
  *pos3=z;

  /*
  Serial.print("pos1: ");
  Serial.println(*pos1);
  Serial.print("pos2: ");
  Serial.println(*pos2);
  Serial.print("pos3: ");
  Serial.println(*pos3);
  */

}
void read_position(){
  int pos1= myservo3.read();
  Serial.println(pos1);
  delay(100);
}

void test(){
  //axis1_goto(15);
  //axis2_goto(30);  
  //goHome();
  /*
  for(pos1 = 0; pos1 < 180; pos1 += 1){ 
        myservo1.write(pos1);
        myservo2.write(pos1);
        myservo3.write(pos1);
        delay(15);//cang nho toc do quay cang nhanh
        cur_pos1= myservo1.read();
        cur_pos2= myservo2.read();
        cur_pos3= myservo3.read();
        Serial.print("Servo1 = ");
        Serial.println(cur_pos1);
        
        Serial.print("Servo2 = ");
        Serial.println(cur_pos2);
        
        Serial.print("Servo3 = ");
        Serial.println(cur_pos3);
    }

  delay(1000);
  for(pos1 = 180; pos1 > 0; pos1 -= 1){ 
        myservo1.write(pos1);
        myservo2.write(pos1);
        myservo3.write(pos1);
        delay(15);
    }
  delay(1000);
  */
  
}
void loop() { 

 if (Serial.available() > 0) {
    // Read the value from the computer
    String inputString = Serial.readStringUntil('\n');
    int string_length = inputString.length();
    //Serial.println(string_length);
    // go to x,y,z
    if (string_length>1){
      
      decodeString(inputString, x, y, z);    
      // calculate omega 1,2,3
      calculate1(x,y,z, &pos1, &pos2, &pos3);
      // Axis1
      if((pos1 < axis1_limit[1]) && (pos1 >axis1_limit[0])){
        axis1_goto(pos1);
        //Serial.print(pos1);
      } else
      {
        Serial.println("Over axis1");
      }
      // Axis2
      if((pos2 < axis2_limit[1]) && (pos2 >axis2_limit[0])){
        axis2_goto(pos2);
        //Serial.print(pos2);
      } else
      {
        Serial.println("Over axis2");
      }
      // Axis1
      if((pos3 < axis3_limit[1]) && (pos3 >axis3_limit[0])){
        axis3_goto(pos3);
        //Serial.print(pos3);
      } else
      {
        Serial.println("Over axis3");
      }
    }
    // end go to x,y,z

    //Function
    if (string_length==1){
    // Process the value using a switch case
    Serial.println(inputString);
    int function = inputString.toInt();
    switch (function) {
      // Go Home
      case 1:
        Serial.println("Go Home");
        goHome();
        break;
      // On end effector
      case 2:
        digitalWrite(ee_pin, 1);
        break;
      // Off end effector
      case 3:
        digitalWrite(ee_pin, 0);       
        break;
      // teach point 
      case 4:
        points[i][0]=x;
        points[i][1]=y;
        points[i][2]=z;
        /*
        Serial.println("DA HOC ");
        Serial.print("Axis1 :");
        Serial.println(points[i][0]);
        Serial.print("Axis2 :");
        Serial.println(points[i][1]);
        Serial.print("Axis3 :");
        Serial.println(points[i][2]);
        */
        i++;
        break;
      // AUTO 
      case 5:
        //Serial.println("ROBOT RUN :");
        for (int j=0; j<i;j++)
        { 
          /*
          Serial.print("Axis1 :");
          Serial.println(points[j][0]);
          Serial.print("Axis2 :");
          Serial.println(points[j][1]);
          Serial.print("Axis3 :");
          Serial.println(points[j][2]);
          Serial.println("DONE------------- :");
          */
          // ee on 
          if(j==1)
          {
            delay(2000);
            digitalWrite(ee_pin, 1);
          }
                   
          axis1_goto(points[j][0]);
          axis2_goto(points[j][1]);
          axis3_goto(points[j][2]);
          if(j==(i-1))
          {
            delay(2000);
            digitalWrite(ee_pin, 0);
          }
          delay(100);
        }
        break;
      // Clear points
      case 6:
        i=0;
        break;
      default:
        // Code to execute for other cases
        Serial.println("Invalid value received");
        break;
    }// end switch
    }
    
  }// end if

  //read_position();
} //end program