# Ilusiones

## Ilusion 1

El tamaño si importa, cuando uno va a un restaurante y le sirven una cantidad en un plato pequeño, uno va asentirse más sacead, mientras que esa misma cantidad se va a ver más pequeña. Un efecto simiar a lo que sucede con la ilusión de Ebbinghaus. En la ilusión de Ebbinghaus, se ven dos anillos de discos azules uno con los discos grandes y otro con los discos pequeños, en el centro de ambos anillos hay dos discos naranjas que a pesar de que no lo parezcan tienen igual tamaño; la ilusión lleva el nombre de Hermann Ebbinghaus, un pionero en la investigación de la memoria.

La conclusión extraída de los hallazgos y de un procedimiento de observación es que existe una propensión a que los fenómenos visuales se intensifiquen cuando el foco del observador se fija en la circunferencia interior contenida en el disco lila superior izquierdo. El argumento de que el cerebro tiene vías distintas para la visión perceptiva y la visión de acción ha estado muy influenciado por la ilusión de Ebbinghaus. Pues, se dice que la ilusión de Ebbinghaus afecta a la percepción del tamaño, pero no a la acción. 


### Codigo

{{< details title="Código en p5.js }" open=false >}}

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

{{< /details >}}

{{< p5-global-iframe id="changesize" width="475" height="475" >}}

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
{{< /p5-global-iframe >}}

## Ilusion 2

El movimiento de rotación aumenta la percepción de la profundidad en patrones de anillos concéntricos en la profundidad estereocinética. La rotación suele dar la sensación de un túnel que se extiende o se contrae, o ambos.

Se puede demostrar cómo el movimiento de rotación en los círculos crea la percepción de profundidad teniendo en cuenta los resultados de la codificación y la evidencia visual de la misma. 

### Codigo

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
{{< /details >}}

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
{{< /p5-global-iframe >}}

## Ilusion 3

## Ilusion 4
