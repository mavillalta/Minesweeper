ArrayList<Integer> mines = new ArrayList();
int[][] grid=new int[22][22];
int[][] nums=new int[20][20];
boolean[][] open= new boolean[20][20];
boolean[][] flags= new boolean[20][20];
int flag;
int gflag;
void setup(){
  size(500,500);
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
for(int i=0;i<mine;i++){
   grid[mines.get(i)%20+1][(int)(mines.get(i)/20)+1]=-1;
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
}
void draw(){
for(int i=0;i<521;i=i+25){
  line(0,i,521,i);
  line(i,0,i,521);
}
}
void mousePressed() {
 if(mouseButton==LEFT){
   if(!flags[(int)(mouseX/25)][(int)(mouseY/25)]){
 if(nums[(int)(mouseX/25)][(int)(mouseY/25)]==9){
   text("game Over",100,100);
   fill(0,0,0);
  ellipse( (int)(mouseX/25)*25+15,(int)(mouseY/25)*25+15,10,10);
 }
 else{
   if(nums[(int)(mouseX/25)][(int)(mouseY/25)]!=0){
     if(open[(int)(mouseX/25)][(int)(mouseY/25)]){
       if(flagsum((int)(mouseX/25),(int)(mouseY/25))==nums[(int)(mouseX/25)][(int)(mouseY/25)]){
         for(int i=(int)(mouseX/25-1);i<(int)(mouseX/25+2);i++){
            for(int j=(int)(mouseY/25-1);j<(int)(mouseY/25+2);j++){
              if(isValid(i,j)&&!flags[i][j]){
                expandf(i,j);
              }
            }
         }
       }
     }
     else{
     fill(255,0,0);
     rect((int)(mouseX/25)*25,(int)(mouseY/25)*25,25,25);
     fill(0,0,0);
     text(nums[(int)(mouseX/25)][(int)(mouseY/25)],(int)(mouseX/25)*25+10,(int)(mouseY/25)*25+18);
     open[(int)(mouseX/25)][(int)(mouseY/25)]=true;
     }
   }
   else{
     expandf((int)(mouseX/25),(int)(mouseY/25));
   }
 }
}
 }
else{
  if(!flags[(int)(mouseX/25)][(int)(mouseY/25)]){
  if(!open[(int)(mouseX/25)][(int)(mouseY/25)]){
      open[(int)(mouseX/25)][(int)(mouseY/25)]=true;
      fill(100,100,100);
      rect((int)(mouseX/25)*25,(int)(mouseY/25)*25,25,25);
      fill(0,255,0);
      text("F",(int)(mouseX/25)*25+10,(int)(mouseY/25)*25+17);
      flags[(int)(mouseX/25)][(int)(mouseY/25)]=true;
      flag++;
      if(nums[(int)(mouseX/25)][(int)(mouseY/25)]==9){
       gflag++;
       if(gflag==flag&&gflag==50){
        textSize(100);
        text("good job",100,100);
       }
      }
  }
}
else{
  open[(int)(mouseX/25)][(int)(mouseY/25)]=false;
      fill(170,170,170);
      rect((int)(mouseX/25)*25,(int)(mouseY/25)*25,25,25);

      flags[(int)(mouseX/25)][(int)(mouseY/25)]=false;
      flag--;
      if(nums[(int)(mouseX/25)][(int)(mouseY/25)]==9){
       gflag--;
      
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
    open[x][y]=true; 
 }
 else if(isValid(x,y)&&nums[x][y]==9){
   text("game Over",100,100);
   fill(0,0,0);
   ellipse( (x)*25+10,(y)*25+10,10,10);
 }
}
