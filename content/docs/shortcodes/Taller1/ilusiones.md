#Ilusiones

##Ilusion 1

{{< details title="Código en p5.js 1" open=false >}}

```js
let rad, x1, y1, aux = 1;

function setup() {
  createCanvas(450, 450);
  frameRate(40);
  x = width/2,y = height/2;
  x1= x;
  y1= y;
}

function draw() {
  background(210);

  if((frameCount-1) % 125 == 0){
    aux = -aux;
   }
  
  x1 = x1 + aux * 1.06;
  y1 = y1 + aux * 1.06;
  
  strokeWeight(2);
  stroke(20, 20, 150);
  /* 
  radi = 12*pow((170/x1),5);
  if (radi < 50) rad = 50;
  if ( radi >= 50) rad = 12*pow((170/x1),5);
  */
  rad = 12*pow((170/x1),5);
  fill(230, 240, 230);
  ellipse(x,y,rad);
  
  noStroke();
  fill(215, 140, 220);
  ellipse(x,y,40);
  
  strokeWeight(4);
  stroke(230, 216, 232);
  point(x,y)
}
```
{{< p5-global-iframe id="changesize" width="525" height="525" >}}

let rad, x1, y1, aux = 1;

function setup() {
  createCanvas(450, 450);
  frameRate(40);
  x = width/2,y = height/2;
  x1= x;
  y1= y;
}

function draw() {
  background(210);

  if((frameCount-1) % 125 == 0){
    aux = -aux;
   }
  
  x1 = x1 + aux * 1.06;
  y1 = y1 + aux * 1.06;
  
  strokeWeight(2);
  stroke(20, 20, 150);
  /* 
  radi = 12*pow((170/x1),5);
  if (radi < 50) rad = 50;
  if ( radi >= 50) rad = 12*pow((170/x1),5);
  */
  rad = 12*pow((170/x1),5);
  fill(230, 240, 230);
  ellipse(x,y,rad);
  
  noStroke();
  fill(215, 140, 220);
  ellipse(x,y,40);
  
  strokeWeight(4);
  stroke(230, 216, 232);
  point(x,y)
}


##Ilusion 2

{{< details title="Código en p5.js" open=false >}}
```js
let movement = 0, stop = 1, crater = 1; fondo= 255; 
function setup() {
  createCanvas(510, 510);
  background(fondo);
  frameRate(30);
  noStroke();
  buttonStop = createButton('Parar');
  buttonStop.position(0, 478);
  buttonStop.mousePressed(stop_move);
  color1 = (255,192,203);
  color2 = color1-255;
  buttonReset = createButton('Resetear');
  buttonReset.position(430, 0);
  buttonReset.mousePressed(reset);
  
  buttonInvert = createButton('Shallow');
  buttonInvert.position(447, 478);
  buttonInvert.mousePressed(invert);
  buttonInvert.style('background-color', color(255));
}

function invert() {  
  col = color1;
  crater *= -1;
  if(crater > 0){
    buttonInvert.style('background-color', color(255));
    background(fondo);
    color1 = (255,192,203);
    color2= color1 - 255
  }else{
    buttonInvert.style('background-color', color(125));
    background(-1*fondo);
    color1 = color2;
    color2 = col;
    
  }
}

function reset() {
  background(fondo);
  movement = 0;
  stop = 1;
  crater = 1;
  buttonInvert.style('background-color', color(255));
}

function stop_move() {
  stop *= -1;
}

function draw() {
  let aux = 2;
  fill(color2);
  ellipse(250,250,500);
  for (let i = 1; i < 12; i++) {
    if(i % 2 == 0){
      fill(color2);
    }else{
      fill(color1);
    }
    if(crater==1){
      ellipse(250+(cos((movement % 360)*PI/180)*i*20),250+(sin((movement % 360)*PI/180)*i*20),500-i*40);
    }else{
      if(i < 7){
        ellipse(250+(cos((movement % 360)*PI/180)*i*20),250+(sin((movement % 360)*PI/180)*i*20),500-i*40);
        aux = i - 1;
      }else{
        ellipse(250+(cos((movement % 360)*PI/180)*aux*20),250+(sin((movement % 360)*PI/180)*aux*20),500-i*40);
        aux -= 1;
      }
    }
  }
  if(stop == 1){
    movement += 1;
  }
  
}

```

{{< p5-global-iframe id="shallow" width="525" height="525" >}}

let movement = 0, stop = 1, crater = 1; fondo= 255; 
function setup() {
  createCanvas(510, 510);
  background(fondo);
  frameRate(30);
  noStroke();
  buttonStop = createButton('Parar');
  buttonStop.position(0, 478);
  buttonStop.mousePressed(stop_move);
  color1 = (255,192,203);
  color2 = color1-255;
  buttonReset = createButton('Resetear');
  buttonReset.position(430, 0);
  buttonReset.mousePressed(reset);
  
  buttonInvert = createButton('Shallow');
  buttonInvert.position(447, 478);
  buttonInvert.mousePressed(invert);
  buttonInvert.style('background-color', color(255));
}

function invert() {  
  col = color1;
  crater *= -1;
  if(crater > 0){
    buttonInvert.style('background-color', color(255));
    background(fondo);
    color1 = (255,192,203);
    color2= color1 - 255
  }else{
    buttonInvert.style('background-color', color(125));
    background(-1*fondo);
    color1 = color2;
    color2 = col;
    
  }
}

function reset() {
  background(fondo);
  movement = 0;
  stop = 1;
  crater = 1;
  buttonInvert.style('background-color', color(255));
}

function stop_move() {
  stop *= -1;
}

function draw() {
  let aux = 2;
  fill(color2);
  ellipse(250,250,500);
  for (let i = 1; i < 12; i++) {
    if(i % 2 == 0){
      fill(color2);
    }else{
      fill(color1);
    }
    if(crater==1){
      ellipse(250+(cos((movement % 360)*PI/180)*i*20),250+(sin((movement % 360)*PI/180)*i*20),500-i*40);
    }else{
      if(i < 7){
        ellipse(250+(cos((movement % 360)*PI/180)*i*20),250+(sin((movement % 360)*PI/180)*i*20),500-i*40);
        aux = i - 1;
      }else{
        ellipse(250+(cos((movement % 360)*PI/180)*aux*20),250+(sin((movement % 360)*PI/180)*aux*20),500-i*40);
        aux -= 1;
      }
    }
  }
  if(stop == 1){
    movement += 1;
  }
  
}

##Ilusion 3

##Ilusion 3
