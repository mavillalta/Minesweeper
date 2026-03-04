ArrayList<Integer> mines = new ArrayList();
int[][] grid=new int[22][22];
int[][] nums=new int[20][20];
boolean[][] open= new boolean[20][20];
boolean[][] flags= new boolean[20][20];
int flag;
int gflag;
void setup(){
  size(501,501);
  background(170,170,170);
  for(int i=0;i<20;i++){
     for(int j=0;j<20;j++){
       open[i][j]=false;
       flags[i][j]=false;
   } 
  }
  int mine=50;  
while(mines.size()<mine){
 int a=(int)(Math.random()*400);
 if(!mines.contains(a))
   mines.add(a);
}
print(mines);
for(int i=0;i<mine;i++){
   grid[mines.get(i)%20+1][mines.get(i)/20+1]=-1;
}
for(int i=0;i<22;i++){
  for(int j=0;j<22;j++){
   print(grid[i][j]); 
  }
  System.out.println(" ");
}
for(int i=0;i<20;i++){
 for(int j=0;j<20;j++){
   if(grid[i+1][j+1]==-1){
    nums[i][j]=9; 
   }
   else{
   nums[i][j]=(grid[i][j]+grid[i+1][j]+grid[i+2][j]+
   grid[i][j+1]+grid[i+2][j+1]+
   grid[i][j+2]+grid[i+1][j+2]+grid[i+2][j+2])*-1;
   }
 }
}
for(int i=0;i<20;i++){
  for(int j=0;j<20;j++){
   print(nums[i][j]); 
   print(" ");
  }
  System.out.println(" ");
}
}
void draw(){
for(int i=0;i<521;i=i+25){
  line(0,i,521,i);
  line(i,0,i,521);
}
for(int i=0;i<400;i++){
  if(nums[i%20][i/20]!=0&&nums[i%20][i/20]!=9)
 ///text(nums[i%20][i/20],(i/20)*25+13,(i%20)*25+25);
 if(nums[i%20][i/20]==9){
   fill(0,0,0);
  circle( (i/20)*25+10,(i%20)*25+10,10);
 }
}
}
void mouseClicked() {
 if(mouseButton==LEFT){
   if(!flags[mouseX/25][mouseY/25]){
  //print(" "+mouseX/25);
  //print(" "+mouseY/25);
  //System.out.println(" "+nums[mouseY/25][mouseX/25]);
 if(nums[mouseX/25][mouseY/25]==9){
   text("game Over",100,100);
   print("game over");
   //revealmines();
   fill(0,0,0);
   circle( (mouseX/25)*25+10,(mouseY/25)*25+10,10);
 }
 else{
   if(nums[mouseX/25][mouseY/25]!=0){
     if(open[mouseX/25][mouseY/25]){
       print("cord");
       if(flagsum(mouseX/25,mouseY/25)==nums[mouseX/25][mouseY/25]){
         print("should cord");
         for(int i=mouseX/25-1;i<mouseX/25+2;i++){
            for(int j=mouseY/25-1;j<mouseY/25+2;j++){
              if(isValid(i,j)&&!flags[i][j]){
                
                expandf(i,j);
              }
            }
         }
         
       }
     }
     else{
     fill(255,0,0);
     rect((mouseX/25)*25,(mouseY/25)*25,25,25);
     fill(0,0,0);
     text(nums[mouseX/25][mouseY/25],(mouseX/25)*25+10,(mouseY/25)*25+18);
     open[mouseX/25][mouseY/25]=true;
     }
   }
   else{
     expandf(mouseX/25,mouseY/25);
   }
 }
}
 }
else{
  if(!flags[mouseX/25][mouseY/25]){
  if(!open[mouseX/25][mouseY/25]){
      open[mouseX/25][mouseY/25]=true;
      fill(100,100,100);
      rect((mouseX/25)*25,(mouseY/25)*25,25,25);
      fill(0,255,0);
      text("F",(mouseX/25)*25+10,(mouseY/25)*25+17);
      print("flag");
      flags[mouseX/25][mouseY/25]=true;
      flag++;
      if(nums[mouseX/25][mouseY/25]==9){
       gflag++;
       print("good flag");
       print(gflag);
       print(flag);
       if(gflag==flag&&gflag==50){
        print("you won"); 
        textSize(100);
        text("good job",100,100);
       }
       
      }
  }
}
else{
  open[mouseX/25][mouseY/25]=false;
      fill(170,170,170);
      rect((mouseX/25)*25,(mouseY/25)*25,25,25);
      print("unflag");
      flags[mouseX/25][mouseY/25]=false;
      flag--;
      if(nums[mouseX/25][mouseY/25]==9){
       gflag--;
       print("ungood flag");
      }
}
}
}
int flagsum(int x, int y){
  int f=0;
  for(int i=x-1;i<x+2;i++){
    for(int j=y-1;j<y+2;j++){
      if(isValid(i,j)){
       if(flags[i][j]){
        f++; 
       }
      }
    }
  }
  return f;
}
boolean isValid(int x,int y){
  return(x<20&&x>-1&&y<20&&y>-1);
}
void expandf(int x,int y){
 if(nums[x][y]==0&&x<20&&x>-1&&y<20&&y>-1){
   fill(255,0,0);
    rect((x)*25,(y)*25,25,25);
    open[x][y]=true;
    if(x<19&&!open[x+1][y]){
      expandf(x+1,y);
    }
    if(x<19&&y>0&&!open[x+1][y-1]){
      expandf(x+1,y-1);
    }
    if(x<19&&y<19&&!open[x+1][y+1]){
      expandf(x+1,y+1);
    }
    if(y<19&&!open[x][y+1]){
      expandf(x,y+1);
    }
    if(y>0&&!open[x][y-1]){
      expandf(x,y-1);
    }
    if(x>0&&y>0&&!open[x-1][y-1]){
      expandf(x-1,y-1);
    }
    if(x>0&&!open[x-1][y]){
      expandf(x-1,y);
    }
    if(x>0&&y<19&&!open[x-1][y+1]){
      expandf(x-1,y+1);
    }
 }
 else if(nums[x][y]!=0&&nums[x][y]!=9&&x<20&&x>-1&&y<20&&y>-1){
   fill(255,0,0);
    rect((x)*25,(y)*25,25,25);
    fill(255,255,255);
    text(nums[x][y],x*25+10,y*25+18);
    print("red");
    open[x][y]=true; 
 }
 else if(isValid(x,y)&&nums[x][y]==9){
   text("game Over",100,100);
   print("game over");
   //revealmines();
   fill(0,0,0);
   circle( (x)*25+10,(y)*25+10,10);
 }
}
