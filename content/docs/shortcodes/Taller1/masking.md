# Masking

## Kernels

Un kernel, matriz de convolución o máscara es una pequeña matriz que se utiliza en el procesamiento de imágenes para desenfocar, enfocar, resaltar, detectar bordes, etc. Para ello se utiliza la convolución entre el núcleo y una imagen. 

Dado que es posible aplicar efectos como el desenfoque, la nitidez, el relieve, la detección de bordes, etc., mediante una operación de convolución entre el núcleo (matriz) y la imagen, el enmascaramiento es crucial en el ámbito del procesamiento de imágenes. En vista de ello, el objetivo de este estudio es evaluar el proceso de convolución de imágenes de forma que se haga un recorrido por cada una de las ideas que lo explican para obtener una perspectiva amplia.

### Codigo

{{< details title="Código en p5.js" open=false >}}

```js
function convolution(x, y, matrix, matrixsize, img) {
    let rtotal = 0.0;
    let gtotal = 0.0;
    let btotal = 0.0;
    const offset = floor(matrixsize / 2);
    for (let i = 0; i < matrixsize; i++){
      for (let j = 0; j < matrixsize; j++){
        
        const xloc = (x + i - offset);
        const yloc = (y + j - offset);
        let loc = (xloc + img.width * yloc) * 4;
  
        loc = constrain(loc, 0 , img.pixels.length - 1);
  
        rtotal += (img.pixels[loc]) * matrix[i][j];
        gtotal += (img.pixels[loc + 1]) * matrix[i][j];
        btotal += (img.pixels[loc + 2]) * matrix[i][j];
      }
    }
    rtotal = constrain(rtotal, 0, 255);
    gtotal = constrain(gtotal, 0, 255);
    btotal = constrain(btotal, 0, 255);
    
    return color(rtotal, gtotal, btotal);
  };
```
{{< /details >}}

{{< p5-global-iframe id="changesize" width="660" height="920" >}}

let img, in1, in2, in3, in4, in5, in6, in7, in8, in9, button;

  const matrix = [ [ 0.0625, 0.125, 0.0625 ],
              [ 0.125, 0.25, 0.125 ],
              [ 0.0625, 0.125, 0.0625 ] ]; 

  preload = function(){
    img = loadImage('/visualcomputing.github.io/edit/gmojica/content/sketches/flowers2.jpg');
  };

  setup = function () {
    createCanvas(640, 900);

    in1 = createInput();
    in2 = createInput();
    in3 = createInput();
    in4 = createInput();
    in5 = createInput();
    in6 = createInput();
    in7 = createInput();
    in8 = createInput();
    in9 = createInput();
    button = createButton('Apply');
    button.mousePressed(kernel);

    img.loadPixels();
    pixelDensity(1);
    noLoop();
  };

  draw = function () {
    background(230);
    const matrixsize = 3;

    // Histogram
    var maxRange = 256
    var histogram = new Array(maxRange);
    for (i = 0; i <= maxRange; i++) {
      histogram[i] = 0
    }

    loadPixels();
    for (let x = 0; x < img.width; x++) {
      for (let y = 0; y < img.height; y++ ) {
        let c = convolution(x, y, matrix, matrixsize, img);

        let loc = (x + y*img.width) * 4;
        let red = pixels[loc] = red(c);
        let green = pixels[loc + 1] = green(c);
        let blue = pixels[loc + 2] = blue(c);
        let alpha = pixels[loc + 3] = alpha(c);
        let luma = 0.299*red + 0.587*green + 0.114*blue // Convert to grey scale

        b = int(luma);
        histogram[b]++
      }
    }
    updatePixels();

    stroke(0,213,255)
    push()
    translate(10,0)
    for (x = 0; x <= maxRange; x++) {
      index = histogram[x];

      y1=int(map(index, 0, max(histogram), height, height-200));
      y2 = height
      xPos = map(x,0,maxRange,0, width-20)
      line(xPos, y1, xPos, y2);
    }
    pop()
  };

  function convolution(x, y, matrix, matrixsize, img) {
    let rtotal = 0.0;
    let gtotal = 0.0;
    let btotal = 0.0;
    const offset = floor(matrixsize / 2);
    for (let i = 0; i < matrixsize; i++){
      for (let j = 0; j < matrixsize; j++){
        
        const xloc = (x + i - offset);
        const yloc = (y + j - offset);
        let loc = (xloc + img.width * yloc) * 4;
  
        loc = constrain(loc, 0 , img.pixels.length - 1);
  
        rtotal += (img.pixels[loc]) * matrix[i][j];
        gtotal += (img.pixels[loc + 1]) * matrix[i][j];
        btotal += (img.pixels[loc + 2]) * matrix[i][j];
      }
    }
    rtotal = constrain(rtotal, 0, 255);
    gtotal = constrain(gtotal, 0, 255);
    btotal = constrain(btotal, 0, 255);
    
    return color(rtotal, gtotal, btotal);
  };

  function kernel(){
    matrix[0][0] = in1.value();
    matrix[0][1] = in2.value();
    matrix[0][2] = in3.value();
    matrix[1][0] = in4.value();
    matrix[1][1] = in5.value();
    matrix[1][2] = in6.value();
    matrix[2][0] = in7.value();
    matrix[2][1] = in8.value();
    matrix[2][2] = in9.value();

    redraw();
  };

{{< /p5-global-iframe >}}

{{< p5-div ver="1.4.2" sketch="visualcomputing.github.io/content/sketches/workshopEj1.js" >}}

### Discusión

El programa permite introducir los valores del núcleo y luego hacer clic en el botón Aplicar para aplicar la operación. Un ejercicio sencillo pero ilustrativo sería poner a cero todos los valores de la matriz, pero para aplicar un efecto de luminosidad variable, sería el del medio el que se podría variar, digamos, de 0 a 2 en pasos de 0 a 1, sólo el valor de Oscurece o agranda la imagen.


Así, podemos ver que la convolución es una operación matemática utilizada en diversos campos de investigación (como el de las señales y las comunicaciones), y en el procesamiento de imágenes juega un papel importante en diversas implementaciones de aplicaciones de filtros, reconocimiento de caras, etc. .
