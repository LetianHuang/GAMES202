# 作业 2: Precomputed Radiance Transfer

## 环境与配置

### 预计算部分

OS操作系统：Windows10-WSL2-Ubuntu 22.04.1 LTS

CMake版本：3.22.1

编译器：gcc-10 10.4.0 —— 注意不要使用Linux gcc-11 11.3.0，使用gcc-11作为CMake指定编译器会出错，可以使用Windows MSVC

cpp版本：c++17及以上

### 渲染部分

OS操作系统：Windows10

Browser浏览器：Chrome

框架：WebGL(OpenGL ES) Three.js（GAMES202官方提供作业框架）

## 说明

该项目实现了材质为diffuse unshadowed和diffuse shadowed的PRT预计算，渲染Shader采用了Light项球谐系数、Light Transport项球谐系数计算渲染方程，同时使用了纹理贴图

## 图像展示

### CornellBox细节展示

<img src="https://github.com/mofashaoye/GAMES202/blob/main/src/2/images/CornellBox/x.png"></img>

### GraceCathedral细节展示

<img src="https://github.com/mofashaoye/GAMES202/blob/main/src/2/images/GraceCathedral/x.png"></img>

### Indoor细节展示

<img src="https://github.com/mofashaoye/GAMES202/blob/main/src/2/images/Indoor/x.png"></img>

### Skybox细节展示

<img src="https://github.com/mofashaoye/GAMES202/blob/main/src/2/images/Skybox/x.png"></img>

### Skybox2细节展示

<img src="https://github.com/mofashaoye/GAMES202/blob/main/src/2/images/Skybox2/x.png"></img>

### 右侧前方展示

<div align="center">
  <img src="https://github.com/mofashaoye/GAMES202/blob/main/src/2/images/CornellBox/0.png" height = 270></img>
  <img src="https://github.com/mofashaoye/GAMES202/blob/main/src/2/images/GraceCathedral/0.png" height = 270></img>
   <img src="https://github.com/mofashaoye/GAMES202/blob/main/src/2/images/Indoor/0.png" height = 270></img>
    <img src="https://github.com/mofashaoye/GAMES202/blob/main/src/2/images/Skybox/0.png" height = 270></img>
</div>

### 左侧前方展示

<div align="center">
  <img src="https://github.com/mofashaoye/GAMES202/blob/main/src/2/images/CornellBox/1.png" height = 270></img>
  <img src="https://github.com/mofashaoye/GAMES202/blob/main/src/2/images/GraceCathedral/1.png" height = 270></img>
   <img src="https://github.com/mofashaoye/GAMES202/blob/main/src/2/images/Indoor/1.png" height = 270></img>
    <img src="https://github.com/mofashaoye/GAMES202/blob/main/src/2/images/Skybox/1.png" height = 270></img>
</div>

### 正面展示

<div align="center">
  <img src="https://github.com/mofashaoye/GAMES202/blob/main/src/2/images/CornellBox/2.png" height = 270></img>
  <img src="https://github.com/mofashaoye/GAMES202/blob/main/src/2/images/GraceCathedral/2.png" height = 270></img>
   <img src="https://github.com/mofashaoye/GAMES202/blob/main/src/2/images/Indoor/2.png" height = 270></img>
    <img src="https://github.com/mofashaoye/GAMES202/blob/main/src/2/images/Skybox/2.png" height = 270></img>
</div>

### 背面展示

<div align="center">
  <img src="https://github.com/mofashaoye/GAMES202/blob/main/src/2/images/CornellBox/3.png" height = 270></img>
  <img src="https://github.com/mofashaoye/GAMES202/blob/main/src/2/images/GraceCathedral/3.png" height = 270></img>
   <img src="https://github.com/mofashaoye/GAMES202/blob/main/src/2/images/Indoor/3.png" height = 270></img>
    <img src="https://github.com/mofashaoye/GAMES202/blob/main/src/2/images/Skybox/3.png" height = 270></img>
</div>

### CornellBox

<div align="center">
  <img src="https://github.com/mofashaoye/GAMES202/blob/main/src/2/images/CornellBox/0.png" height = 270></img>
  <img src="https://github.com/mofashaoye/GAMES202/blob/main/src/2/images/CornellBox/1.png" height = 270></img>
   <img src="https://github.com/mofashaoye/GAMES202/blob/main/src/2/images/CornellBox/2.png" height = 270></img>
    <img src="https://github.com/mofashaoye/GAMES202/blob/main/src/2/images/CornellBox/3.png" height = 270></img>
</div>

### GraceCathedral

<div align="center">
  <img src="https://github.com/mofashaoye/GAMES202/blob/main/src/2/images/GraceCathedral/0.png" height = 270></img>
  <img src="https://github.com/mofashaoye/GAMES202/blob/main/src/2/images/GraceCathedral/1.png" height = 270></img>
   <img src="https://github.com/mofashaoye/GAMES202/blob/main/src/2/images/GraceCathedral/2.png" height = 270></img>
    <img src="https://github.com/mofashaoye/GAMES202/blob/main/src/2/images/GraceCathedral/3.png" height = 270></img>
</div>

### Indoor

<div align="center">
  <img src="https://github.com/mofashaoye/GAMES202/blob/main/src/2/images/Indoor/0.png" height = 270></img>
  <img src="https://github.com/mofashaoye/GAMES202/blob/main/src/2/images/Indoor/1.png" height = 270></img>
   <img src="https://github.com/mofashaoye/GAMES202/blob/main/src/2/images/Indoor/2.png" height = 270></img>
    <img src="https://github.com/mofashaoye/GAMES202/blob/main/src/2/images/Indoor/3.png" height = 270></img>
</div>

### Skybox

<div align="center">
  <img src="https://github.com/mofashaoye/GAMES202/blob/main/src/2/images/Skybox/0.png" height = 270></img>
  <img src="https://github.com/mofashaoye/GAMES202/blob/main/src/2/images/Skybox/1.png" height = 270></img>
   <img src="https://github.com/mofashaoye/GAMES202/blob/main/src/2/images/Skybox/2.png" height = 270></img>
    <img src="https://github.com/mofashaoye/GAMES202/blob/main/src/2/images/Skybox/3.png" height = 270></img>
</div>


### Skybox2

<div align="center">
  <img src="https://github.com/mofashaoye/GAMES202/blob/main/src/2/images/Skybox2/0.png" height = 270></img>
  <img src="https://github.com/mofashaoye/GAMES202/blob/main/src/2/images/Skybox2/1.png" height = 270></img>
   <img src="https://github.com/mofashaoye/GAMES202/blob/main/src/2/images/Skybox2/2.png" height = 270></img>
    <img src="https://github.com/mofashaoye/GAMES202/blob/main/src/2/images/Skybox2/3.png" height = 270></img>
</div>
