color[][] colorSet={
 {color(155, 89, 182),color(142, 68, 173)},  //Amethyst, wisteria
 {color(52, 152, 219),color(41, 128, 185)},  //Peter river, belize hole
 {color(46,204,133),color(39, 174, 96)},   //Emerald, nephrite
 {color(26, 188, 156),color(22,160,133)},  //Turguoise, green sea
 {color(241, 196, 15),color(243, 156, 18)},  //Sunflower, orange
 {color(230, 126, 34),color(211, 84, 0)},    //Carrot, pumpkin
 {color(231, 76, 60),color(192, 57, 43)}    //alizarin, pomegranate
};
color[][] reverseColSet={
 {color(142, 68, 173),color(155, 89, 182)},  //wisteria, amethyst(the same below)
 {color(41, 128, 185),color(52, 152, 219)},
 {color(39, 174, 96),color(46,204,133)},
 {color(22,160,133),color(26, 188, 156)},
 {color(243, 156, 18),color(241, 196, 15)},
 {color(211, 84, 0),color(230, 126, 34)},
 {color(192, 57, 43),color(231, 76, 60)}
};

PFont font;

//Pattern switch, used for judging current pattern
int patternSwitch=0;

int evenOdd=0;

int ranC=int(random(7));

void setup(){
  size(600,600);
  background(255);
  colorMode(RGB);
  noStroke();
   frameRate(3);
  randomPattern(); //Generate a random pattern when running the code
  //Title and descriptions
  fill(255);
  rect(width/3,height/2-50,width*2/3,100);
  font=loadFont("AppleBraille-48.vlw");
  textFont(font);
  fill(255);
  textSize(48);
  text("DIGITAL MOSAIK",width/3,height/2-50);
  textSize(30);
  fill(52, 73, 94);
  text("Instructions",width/3+15,height/2-15);
  textSize(18);
  text("- Click to generate random pattern",width/3+15,height/2+13);
  text("- Press 1, 2, 3 to view preset patterns", width/3+15,height/2+38);
  
  
}

void draw(){
  switch(patternSwitch){
    case 1: randomPattern(); break;
    case 2: animateOne((evenOdd++)%7,ranC,(ranC+1)%7);
            break;
    case 3: animateTwo(); break;
    case 4: patternThree(); break;
  }
}

/*draw square with provided the coordinate of origin point,
  color and direction of the cutting line,
  consist of two triangles
  the color of the two triangles should be 
  in a color group(two similar color form a group)
*/
void square(int origX,int origY, color[] col, int dir){
  //cut to left-top and right-bottom
  if(dir==0){
    fill(col[0]);
    // left-top triangle
    triangle(origX, origY,origX,origY+height/10,origX+width/10,origY);
    fill(col[1]);
    //right-bottom triangle
    triangle(origX+width/10, origY,origX,origY+height/10,origX+width/10,origY+height/10);
  }else{ //cut to left-bottom and right-top
    fill(col[0]);
    //left-bottom triangle
    triangle(origX, origY,origX,origY+height/10,origX+width/10,origY+height/10);
    fill(col[1]);
    //right-top triangle
    triangle(origX+width/10, origY,origX,origY,origX+width/10,origY+height/10);
  }
  
}

/*get a random number for direction, 
  between 0 and 1
*/
int getRandomDir(){
  return int(random(2));
}

/*get a random color group(two similar color)
*/
color[] getRandomCol(){
  int randomColR=int(random(7));
  int randomColC=int(random(2));
  color[] ranCol= {colorSet[randomColR][randomColC],colorSet[randomColR][1-randomColC]};
  return ranCol;
}

/*generate random pattern, 
  every square is seperate with random color and direction
*/
void randomPattern(){
  for(int cOrigY=0; cOrigY<height; cOrigY+=height/10){
    for(int cOrigX=0; cOrigX<width; cOrigX+=width/10){
      square(cOrigX, cOrigY,getRandomCol(), getRandomDir());
    }
  }
}

/*the first preset pattern----Windmill,
  every windmill consist of 4 squares,
  call windmill() in a loop to fill the screen
  and every windmill generated in the scree
  n is seperate with random color
*/
void animateOne(int count, int randomC, int randomC_){
  if(count%2==0){
    patternOne(randomC, randomC_);
  }else{
   patternOne(randomC_, randomC);
  }
 
}
void patternOne(int randomCol_1,int randomCol_2){
  for(int cOrigY=0; cOrigY<height; cOrigY+=height/5){
    for(int cOrigX=0; cOrigX<width; cOrigX+=width/5){
      if(5*cOrigY/height%2==0&&5*cOrigX/width%2==0){
        windmill(cOrigX,cOrigY,randomCol_1);
      }else if(5*cOrigY/height%2!=0&&5*cOrigX/width%2!=0){
        windmill(cOrigX,cOrigY,randomCol_1);
      }else{
        windmill(cOrigX,cOrigY,(randomCol_2)%7);
      }
      //windmill(cOrigX,cOrigY,int(random(7)));
    }
  }
}
/*generate a windmill with given the coordinate of origin and color,
  consist of 4 square with the same color group
*/
void windmill(int origX, int origY, int colR){
  color[] col={colorSet[colR][0],colorSet[colR][1]};
  color[] reverseCol={col[1],col[0]};
  square(origX,origY,col,1);
  square(origX+width/10,origY,col,0);
  square(origX,origY+height/10,reverseCol,0);
  square(origX+width/10, origY+height/10,reverseCol,1);
}

/*the second preset pattern----Rainbow
  call rainbow() in a for loop to fill the screen
*/
void animateTwo(){
  patternTwo(ranC);
  ranC=(ranC+1)%7;
}
void patternTwo(int startColor){
  //int startColor=int(random(7))%7;
  for(int cOrigX=0; cOrigX<width; cOrigX+=width/5){
    rainbow(cOrigX,startColor);
    startColor++;
  }
}

/* a rainbow is a 2*10 squares group
  squares in the same row have the same color but different direction
  the color of rows is in an particular order
*/
void rainbow(int origX, int startColR){
  color[] col=new color[2];
  color[] reverseCol=new color[2];
  for(int i=0; i<10; i++){
    col[0]=colorSet[(startColR+i)%7][0];
    col[1]=colorSet[(startColR+i)%7][1];
    reverseCol[0]=col[1];
    reverseCol[1]=col[0];
    square(origX,i*height/10,col,0);
    square(origX+width/10,i*height/10,reverseCol,1);
  }
}

/*the third preset pattern---the radial flower
  divide the screen into four parts
  generate the first part with radial() and get the others by translation and rotation
*/
void patternThree(){
  float[] angles={0,-0.5,0.5,1.0};
  int[][] translate={{0,0},{0,height},{width,0},{width,height}};
  for(int i=0; i<4; i++){
    pushMatrix();
      translate(translate[i][0],translate[i][1]);
      rotate(PI*angles[i]);
      petal(0,0);
    popMatrix();
      //rotate(-PI*angles[i]);
      //translate(-translate[i][0],-translate[i][1]);
  }
}

/*draw the 5*5 grid from the given original point
  the coordinates of squares drawing are given below
*/
void petal(int origX, int origY){
  //(0,0),(0,1),(0,2),(1,0),(1,1),(2,0)
  for(int y=0; y<3; y++){
    for(int x=0; x<3-y;x++){
      square(origX+x*width/10,origY+y*height/10,reverseColSet[3],0);
    }
  }
  //(4,3),(3,4),(4,4)
  for(int y=0; y<2; y++){
    for(int x=0; x<y+1; x++){
      square(origX+(4-x)*width/10,origY+(3+y)*height/10,reverseColSet[4],0);
    }
  }
  //(4,2),(3,3),(2,4)
  for(int y=0; y<3; y++){
    square(origX+(4-y)*width/10,origY+(2+y)*height/10,reverseColSet[5],0);
  }
  for(int y=0; y<2; y++){
    //(3,2),(2,3)    
    square(origX+(3-y)*width/10,origY+(2+y)*height/10,colorSet[5],0);
    //(2,1),(1,2)
    square(origX+(2-y)*width/10,origY+(1+y)*height/10,reverseColSet[2],0);
    //(1,3),(0,4)
    square(origX+(1-y)*width/10,origY+(3+y)*height/10,reverseColSet[6],0);
    //(3,1),(4,0)
    square(origX+(4-y)*width/10,origY+y*height/10,reverseColSet[6],0);
  }
  //(2,2)
  square(origX+2*width/10,origY+2*height/10,colorSet[4],0);
  //(3,0)
  square(origX+3*width/10,origY,reverseColSet[1],0);
  //(0,3)
  square(origX,origY+3*height/10,reverseColSet[1],0);
  //(1,4)
  square(origX+width/10,origY+4*height/10,colorSet[6],0);
  //(4,1)
  square(origX+4*width/10,origY+height/10,colorSet[6],0);
}

/*listens for a mouse pressed event 
  and generate a random pattern with randomPattern()
*/
void mousePressed(){
  patternSwitch=1;
  //randomPattern();
}

/* listens for which key is being pressed
  1: generate windmill pattern by calling patternOne()
  2: generate rainbow pattern by calling patternTwo()
  3: generate flower pattern by calling patternThree()
*/
void keyPressed(){
  if(key=='1'){
    ranC=int(random(7));
    patternSwitch=2;
    //patternOne();
  }
  if(key=='2'){
    patternSwitch=3;
    //patternTwo();
  }
  if(key=='3'){
    patternSwitch=4;
    //patternThree();
  }
}