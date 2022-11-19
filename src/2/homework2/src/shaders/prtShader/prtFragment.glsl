#ifdef GL_ES
precision mediump float;
#endif

uniform mat3 uPrecomputeLR;
uniform mat3 uPrecomputeLG;
uniform mat3 uPrecomputeLB;
uniform sampler2D uSampler;

varying highp vec2 vTextureCoord;
varying highp mat3 vPrecomputeLT;

void main(void) {    
    vec3 text_color = texture2D(uSampler, vTextureCoord).rgb;
    text_color = pow(text_color, vec3(2.2));

    vec3 env_color = 
        vec3(uPrecomputeLR[0][0], uPrecomputeLG[0][0], uPrecomputeLB[0][0]) * vPrecomputeLT[0][0] + 
        vec3(uPrecomputeLR[0][1], uPrecomputeLG[0][1], uPrecomputeLB[0][1]) * vPrecomputeLT[0][1] + 
        vec3(uPrecomputeLR[0][2], uPrecomputeLG[0][2], uPrecomputeLB[0][2]) * vPrecomputeLT[0][2] + 
        vec3(uPrecomputeLR[1][0], uPrecomputeLG[1][0], uPrecomputeLB[1][0]) * vPrecomputeLT[1][0] +

        vec3(uPrecomputeLR[1][1], uPrecomputeLG[1][1], uPrecomputeLB[1][1]) * vPrecomputeLT[1][1] +
        vec3(uPrecomputeLR[1][2], uPrecomputeLG[1][2], uPrecomputeLB[1][2]) * vPrecomputeLT[1][2] + 
        vec3(uPrecomputeLR[2][0], uPrecomputeLG[2][0], uPrecomputeLB[2][0]) * vPrecomputeLT[2][0] +
        vec3(uPrecomputeLR[2][1], uPrecomputeLG[2][1], uPrecomputeLB[2][1]) * vPrecomputeLT[2][1] +
        vec3(uPrecomputeLR[2][2], uPrecomputeLG[2][2], uPrecomputeLB[2][2]) * vPrecomputeLT[2][2] ;
    gl_FragColor = vec4(pow(0.55 * env_color * text_color, vec3(1.0 / 2.2)),1);
}
