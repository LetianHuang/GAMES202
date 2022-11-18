#ifdef GL_ES
precision highp float;
#endif

uniform vec3 uLightDir;
uniform vec3 uCameraPos;
uniform vec3 uLightRadiance;
uniform sampler2D uGDiffuse;
uniform sampler2D uGDepth;
uniform sampler2D uGNormalWorld;
uniform sampler2D uGShadow;
uniform sampler2D uGPosWorld;

varying mat4 vWorldToScreen;
varying highp vec4 vPosWorld;

#define M_PI 3.1415926535897932384626433832795
#define TWO_PI 6.283185307
#define INV_PI 0.31830988618
#define INV_TWO_PI 0.15915494309

float Rand1(inout float p) {
  p = fract(p * .1031);
  p *= p + 33.33;
  p *= p + p;
  return fract(p);
}

vec2 Rand2(inout float p) {
  return vec2(Rand1(p), Rand1(p));
}

float InitRand(vec2 uv) {
	vec3 p3  = fract(vec3(uv.xyx) * .1031);
  p3 += dot(p3, p3.yzx + 33.33);
  return fract((p3.x + p3.y) * p3.z);
}

vec3 SampleHemisphereUniform(inout float s, out float pdf) {
  vec2 uv = Rand2(s);
  float z = uv.x;
  float phi = uv.y * TWO_PI;
  float sinTheta = sqrt(1.0 - z*z);
  vec3 dir = vec3(sinTheta * cos(phi), sinTheta * sin(phi), z);
  pdf = INV_TWO_PI;
  return dir;
}

vec3 SampleHemisphereCos(inout float s, out float pdf) {
  vec2 uv = Rand2(s);
  float z = sqrt(1.0 - uv.x);
  float phi = uv.y * TWO_PI;
  float sinTheta = sqrt(uv.x);
  vec3 dir = vec3(sinTheta * cos(phi), sinTheta * sin(phi), z);
  pdf = z * INV_PI;
  return dir;
}

void LocalBasis(vec3 n, out vec3 b1, out vec3 b2) {
  float sign_ = sign(n.z);
  if (n.z == 0.0) {
    sign_ = 1.0;
  }
  float a = -1.0 / (sign_ + n.z);
  float b = n.x * n.y * a;
  b1 = vec3(1.0 + sign_ * n.x * n.x * a, sign_ * b, -sign_ * n.x);
  b2 = vec3(b, sign_ + n.y * n.y * a, -n.y);
}

vec4 Project(vec4 a) {
  return a / a.w;
}

float GetDepth(vec3 posWorld) {
  float depth = (vWorldToScreen * vec4(posWorld, 1.0)).w;
  return depth;
}

/*
 * Transform point from world space to screen space([0, 1] x [0, 1])
 *
 */
vec2 GetScreenCoordinate(vec3 posWorld) {
  vec2 uv = Project(vWorldToScreen * vec4(posWorld, 1.0)).xy * 0.5 + 0.5;
  return uv;
}

float GetGBufferDepth(vec2 uv) {
  float depth = texture2D(uGDepth, uv).x;
  if (depth < 1e-2) {
    depth = 1000.0;
  }
  return depth;
}

vec3 GetGBufferNormalWorld(vec2 uv) {
  vec3 normal = texture2D(uGNormalWorld, uv).xyz;
  return normal;
}

vec3 GetGBufferPosWorld(vec2 uv) {
  vec3 posWorld = texture2D(uGPosWorld, uv).xyz;
  return posWorld;
}

float GetGBufferuShadow(vec2 uv) {
  float visibility = texture2D(uGShadow, uv).x;
  return visibility;
}

vec3 GetGBufferDiffuse(vec2 uv) {
  vec3 diffuse = texture2D(uGDiffuse, uv).xyz;
  diffuse = pow(diffuse, vec3(2.2));
  return diffuse;
}

/*
 * Evaluate diffuse bsdf value.
 *
 * wi, wo are all in world space.
 * uv is in screen space, [0, 1] x [0, 1].
 *
 */
vec3 EvalDiffuse(vec3 wi, vec3 wo, vec2 uv) {
  vec3 diff = GetGBufferDiffuse(uv);
  vec3 norm = GetGBufferNormalWorld(uv);
  float cosine = max(0., dot(norm, wi));
  return cosine * diff * INV_PI; // cosine weighted bsdf = bsdf * cosine 
  // Note: Don't forget to divide PI or you will get a so bright scene
}

/*
 * Evaluate directional light with shadow map
 * uv is in screen space, [0, 1] x [0, 1].
 *
 */
vec3 EvalDirectionalLight(vec2 uv) {
  vec3 pos = GetGBufferPosWorld(uv);
  vec3 wi = normalize(uLightDir);
  vec3 wo = normalize(uCameraPos - pos);
  vec3 consineWeightedBSDF = EvalDiffuse(wi, wo, uv);
  float visibility = GetGBufferuShadow(uv);
  return uLightRadiance * consineWeightedBSDF * visibility;
}

#define INIT_STEP 0.8
#define MAX_STEPS 20
#define EPS 1e-2
#define THRESHOLD 0.1

bool outScreen(vec3 pos) {
  vec2 uv = GetScreenCoordinate(pos);
  return any(bvec4(lessThan(uv, vec2(0.0)), greaterThan(uv, vec2(1.0))));
}

bool atFront(vec3 pos) {
  return GetDepth(pos) < GetGBufferDepth(GetScreenCoordinate(pos));
}

bool hasInter(vec3 pos, vec3 dir, out vec3 hitPos){
  float d1 = GetGBufferDepth(GetScreenCoordinate(pos)) - GetDepth(pos) + EPS;
  float d2 = GetDepth(pos + dir) - GetGBufferDepth(GetScreenCoordinate(pos + dir)) + EPS;
  if(d1 < THRESHOLD && d2 < THRESHOLD){
    hitPos = pos + dir * d1 / (d1 + d2);
    return true;
  }  
  return false;
}

bool RayMarch(vec3 ori, vec3 dir, out vec3 hitPos) {
  bool is_inter = false;
  float step = INIT_STEP;
  vec3 cur = ori;
  for(int i = 0;i < MAX_STEPS; i++) {
    if(outScreen(cur)){
      break;
    }
    if(atFront(cur + dir * step)){
      cur += dir * step;
    } else{
      is_inter = true;
      hitPos = cur + dir * step;
      if(hasInter(cur, dir * step, hitPos)){
        return true;
      }
    }
    if(is_inter) {
      step *= 0.5;
    }
  }
  return is_inter;
}

#define SAMPLE_NUM 10

vec3 EvalIndirectLight(vec3 pos){
  float seed = InitRand(gl_FragCoord.xy);
  float pdf = 0.;
  vec3 Li = vec3(0.0), dir, hitPos;
  vec3 normal = GetGBufferNormalWorld(GetScreenCoordinate(pos)), b1, b2;
  LocalBasis(normal, b1, b2);
  mat3 TBN = mat3(b1, b2, normal);
  for(int i = 0; i < SAMPLE_NUM;i++){
    dir = normalize(TBN * SampleHemisphereUniform(seed, pdf));
    if(RayMarch(pos, dir, hitPos)){
      vec3 wo = normalize(uCameraPos - pos);
      vec3 L = EvalDiffuse(dir, wo, GetScreenCoordinate(pos)) / pdf;
      wo = normalize(uCameraPos - hitPos);
      vec3 wi = normalize(uLightDir);
      L *= EvalDirectionalLight(GetScreenCoordinate(hitPos)); // EvalDiffuse(wi, wo, GetScreenCoordinate(hitPos)) *  
      Li += L;
    }
  }
  return Li / float(SAMPLE_NUM);
}

// only for test
vec3 EvalIndirectLightSpecular(vec3 pos) {
  vec3 Li = vec3(0.0), dir, hitPos;
  vec3 normal = GetGBufferNormalWorld(GetScreenCoordinate(pos));
  normal = normalize(normal);
  vec3 wo = normalize(uCameraPos - pos);
  dir = 2. * normal * dot(normal, wo) - wo;
  vec2 uv = GetScreenCoordinate(pos);
  if(RayMarch(pos, dir, hitPos)){  
    vec3 L = GetGBufferDiffuse(uv) * 0.85 / (4. * dot(normal, wo) * dot(normal, dir)); // not exact BRDF!EvalDiffuse(dir, wo, GetScreenCoordinate(pos))
    wo = normalize(uCameraPos - hitPos);
    L *= EvalDirectionalLight(GetScreenCoordinate(hitPos)); // EvalDiffuse(wi, wo, GetScreenCoordinate(hitPos)) * 
    Li += L;
  }
  return Li / float(SAMPLE_NUM);
}

void main() {
  vec3 L = vec3(0.);
  // L = GetGBufferDiffuse(GetScreenCoordinate(vPosWorld.xyz));
  L = EvalDirectionalLight(GetScreenCoordinate(vPosWorld.xyz));
  L += EvalIndirectLight(vPosWorld.xyz);
  vec3 color = pow(clamp(L, vec3(0.0), vec3(1.0)), vec3(1.0 / 2.2));

  gl_FragColor = vec4(color, 1.0);
}