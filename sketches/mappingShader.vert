attribute vec3 aPosition;
attribute vec2 aTexCoord;
attribute vec3 aNormal;

uniform mat4 uProjectionMatrix;

uniform mat4 uModelViewMatrix;

uniform sampler2D uNoiseTexture;

varying vec2 vTexCoord;
varying vec3 vNoise;


void main() {

  vec4 noise = texture2D(uNoiseTexture, aTexCoord);
  vNoise = noise.rgb;
  vec4 positionVec4 = vec4(aPosition, 1.0);
  float amplitude = 1.0;

  positionVec4.xyz += (noise.rgb)/5.0 * aNormal * amplitude;

  gl_Position = uProjectionMatrix * uModelViewMatrix * positionVec4;

  vTexCoord = aTexCoord;
}
