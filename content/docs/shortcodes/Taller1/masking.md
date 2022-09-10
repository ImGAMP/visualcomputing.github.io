# Masking

## Kernels

Un kernel, matriz de convolución o máscara es una pequeña matriz que se utiliza en el procesamiento de imágenes para desenfocar, enfocar, resaltar, detectar bordes, etc. Para ello se utiliza la convolución entre el núcleo y una imagen. 

La función gaussiana se utiliza para desenfocar una imagen y recibe su nombre del matemático y científico Carl Friedrich Gauss. Esta técnica se aplica con frecuencia para minimizar el ruido de la imagen y mejorar la claridad.
En otro sentido, también se tienen en cuenta dos instrumentos que ayudan al crecimiento del ejercicio y permiten aumentar el potencial de la actividad. Las muestras dentro de una colección de datos que fueron elegidas por una razón específica fueron lo primero que miramos al analizar lo que se pensaba como una región ROI. Luego, en un esfuerzo por recrear el impacto de las lupas, se añadió el concepto de herramienta de zoom.
El círculo interior y el círculo exterior representan cada uno un área ampliable, junto con el punto rojo que indica el punto del ratón.
La cuestión es cómo parece en la imagen aplicar el color que coincide con la textura del círculo interior a cada uno de los puntos del círculo exterior. 

### Codigo

{{< details title="Código en p5.js }" open=false >}}

```js
precision mediump float;

varying vec2 vTexCoord;

uniform sampler2D tex0;
uniform sampler2D vid0;

uniform vec2 texOffset;
uniform float mask[9];

uniform bool orig;
uniform bool bord;
uniform bool cam;
uniform bool roi;
uniform bool zoom;
uniform float posY;
uniform float posX;
uniform float roiSize;

float map2(float x, float in_min, float in_max, float out_min, float out_max) {
  return (x - in_min) * (out_max - out_min) / (in_max - in_min) + out_min;
}

void main() {
  vec4 convolution;
  vec4 texel;
  
  vec2 tc0 = vTexCoord + vec2(-texOffset.s, -texOffset.t);
  vec2 tc1 = vTexCoord + vec2(         0.0, -texOffset.t);
  vec2 tc2 = vTexCoord + vec2(+texOffset.s, -texOffset.t);
  vec2 tc3 = vTexCoord + vec2(-texOffset.s,          0.0);
  vec2 tc4 = vTexCoord + vec2(         0.0,          0.0);
  vec2 tc5 = vTexCoord + vec2(+texOffset.s,          0.0);
  vec2 tc6 = vTexCoord + vec2(-texOffset.s, +texOffset.t);
  vec2 tc7 = vTexCoord + vec2(         0.0, +texOffset.t);
  vec2 tc8 = vTexCoord + vec2(+texOffset.s, +texOffset.t);

  vec4 rgba[9];
  if(!cam){
    rgba[0] = texture2D(tex0, vec2(tc0.x,1.0-tc0.y));
    rgba[1] = texture2D(tex0, vec2(tc1.x,1.0-tc1.y));
    rgba[2] = texture2D(tex0, vec2(tc2.x,1.0-tc2.y));
    rgba[3] = texture2D(tex0, vec2(tc3.x,1.0-tc3.y));
    rgba[4] = texture2D(tex0, vec2(tc4.x,1.0-tc4.y));
    rgba[5] = texture2D(tex0, vec2(tc5.x,1.0-tc5.y));
    rgba[6] = texture2D(tex0, vec2(tc6.x,1.0-tc6.y));
    rgba[7] = texture2D(tex0, vec2(tc7.x,1.0-tc7.y));
    rgba[8] = texture2D(tex0, vec2(tc8.x,1.0-tc8.y));
    texel =  texture2D(tex0, vec2(vTexCoord.x,1.0-vTexCoord.y));
  }else{
    rgba[0] = texture2D(vid0, vec2(tc0.x,1.0-tc0.y));
    rgba[1] = texture2D(vid0, vec2(tc1.x,1.0-tc1.y));
    rgba[2] = texture2D(vid0, vec2(tc2.x,1.0-tc2.y));
    rgba[3] = texture2D(vid0, vec2(tc3.x,1.0-tc3.y));
    rgba[4] = texture2D(vid0, vec2(tc4.x,1.0-tc4.y));
    rgba[5] = texture2D(vid0, vec2(tc5.x,1.0-tc5.y));
    rgba[6] = texture2D(vid0, vec2(tc6.x,1.0-tc6.y));
    rgba[7] = texture2D(vid0, vec2(tc7.x,1.0-tc7.y));
    rgba[8] = texture2D(vid0, vec2(tc8.x,1.0-tc8.y));
    texel =  texture2D(vid0, 1.0 - vec2(vTexCoord.x,1.0-vTexCoord.y));
  }
  for (int i = 0; i < 9; i++) {
    convolution += rgba[i]*mask[i];
  }
  
  float pct = 0.0;
  pct = distance(vTexCoord,vec2(posX,1.0-posY)); 
  
  if(roi){
    if(pct<roiSize){
      gl_FragColor = vec4(convolution.rgb, 1.0); 
    }else{
      gl_FragColor = vec4(texel.rgb, 1.0); 
    }
  }else if(zoom){
    if(pct<roiSize){
           
      vec4 xd = texture2D(tex0, vec2(vTexCoord.x + ((vTexCoord.x - posX) / 3.0), 1.0 - vTexCoord.y + (vTexCoord.y - 1.0 + posY) / 3.0));

      gl_FragColor = vec4(xd.rgb ,1.0);
    }else{
      gl_FragColor = vec4(texel.rgb, 1.0); 
    }
  }else{
    gl_FragColor = vec4(convolution.rgb, 1.0); 
  }
}
```
{{< /details >}}

{{< p5-global-iframe id="changesize" width="525" height="525" >}}

let Shader;
let tex;
let mask;

function preload(){
  Shader = loadShader('/showcase/sketches/maskingShader.vert', '/showcase/sketches/maskingShader.frag');
  tex = loadImage('/showcase/sketches/mandrill.png');
}

function setup() {
  createCanvas(500, 500, WEBGL);

  
  inputImg = createFileInput(handleFile);
  inputImg.position(255, 5);
  inputImg.size(240);
  
  option = createSelect();
  option.position(15, 5);
  option.option('Original');
  option.option('Detección de crestas');
  option.option('Afilado');
  option.option('Caja borrosa');
  option.option('Desenfoque gaussiano');
  option.selected('Original');
  option.changed(optionEvent);
  mask = option.value();
  
  media = createCheckbox('Cámara', false);
  media.position(175, 5);
  
  roi = createCheckbox('Región de interes', false);
  roi.position(15, 30);
  
  zoom = createCheckbox('Zoom', false);
  zoom.position(170, 30);
  
  roiSize = createSlider(0.05,0.5,0.1,0.05);
  roiSize.position(250, 30);
  
  vid = createCapture(VIDEO);
  vid.size(500, 500);
  vid.hide();
  
  
}

function draw() {  
  shader(Shader);
  Shader.setUniform('tex0', tex);
  Shader.setUniform('vid0', vid);
  Shader.setUniform('cam', media.checked());
  Shader.setUniform('roi', roi.checked());
  Shader.setUniform('zoom', zoom.checked());
  Shader.setUniform('roiSize', roiSize.value());
  Shader.setUniform('posX', mouseX/500);
  Shader.setUniform('posY', mouseY/500);
  Shader.setUniform('texOffset', [1/500,1/500]);
  if(mask=="Original"){
    Shader.setUniform('mask', [0.0,0.0,0.0,0.0,1.0,0.0,0.0,0.0,0.0]);
  }else if(mask=="Detección de crestas"){
    Shader.setUniform('mask', [-1.0,-1.0,-1.0,-1.0,8.0,-1.0,-1.0,-1.0,-1.0]);
  }else if(mask=="Afilado"){
    Shader.setUniform('mask', [0.0, -1.0, 0.0, -1.0, 5.0, -1.0, 0.0, -1.0, 0.0]);
  }else if(mask=="Caja borrosa"){
    Shader.setUniform('mask', [0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1]);
  }else if(mask=="Desenfoque gaussiano"){
    Shader.setUniform('mask', [0.0625, 0.125, 0.0625, 0.125, 0.25, 0.125, 0.0625, 0.125, 0.0625]);
  }
  rect(0,0,width, height);
}

function optionEvent() {
  mask = option.value();
}

function vidLoad() {
  tex.loop();
}

function handleFile(file) {
  if (file.type === 'image') {
    tex = createImg(file.data, '');
    tex.hide();
  } else {
    tex = createVideo(file.data, vidLoad);
    tex.hide();
  }
}

{{< /p5-global-iframe >}}
