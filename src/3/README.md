# 作业 3: Screen Space Ray Tracing

## 说明

* 实现了Diffuse材质的BSDF的计算，并且实现了直接光照、Ray Marching、间接光照
* 暂未实现Depth MipMap优化的Ray Marching，且由于采样不足以及Ray Marching的步幅较小，渲染结果会有黑色椒噪点（待以后有空改善）

## 图像展示

### Cube Specular SSR

<img src="https://github.com/mofashaoye/GAMES202/blob/main/src/3/images/cube_specularSSR_test_0.png"></img>
<img src="https://github.com/mofashaoye/GAMES202/blob/main/src/3/images/cube_specularSSR_test_1.png"></img>

### Cube Diffuse SSR

<img src="https://github.com/mofashaoye/GAMES202/blob/main/src/3/images/cube_diffuseSSR_show.png"></img>

### Cave

<img src="https://github.com/mofashaoye/GAMES202/blob/main/src/3/images/cave.png"></img>

### Cave Diffuse SSR

<img src="https://github.com/mofashaoye/GAMES202/blob/main/src/3/images/cave_diffuseSSR_show.png"></img>
<img src="https://github.com/mofashaoye/GAMES202/blob/main/src/3/images/cave_diffuseSSR_show2.png"></img>
