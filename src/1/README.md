# 作业 1: 实时阴影

## 无阴影

### 主视图

<img src="https://github.com/mofashaoye/GAMES202/blob/main/src/1/images/without_shadow_1.png" />

### 俯视图

<img src="https://github.com/mofashaoye/GAMES202/blob/main/src/1/images/without_shadow_2.png" />

## 使用Shadow Map

### 主视图

<img src="https://github.com/mofashaoye/GAMES202/blob/main/src/1/images/SM_1.png" />

### 俯视图

<img src="https://github.com/mofashaoye/GAMES202/blob/main/src/1/images/SM_2.png" />

### 阴影细节

硬阴影，有因自遮挡产生的锯齿（shadow acne）

<img src="https://github.com/mofashaoye/GAMES202/blob/main/src/1/images/SM_3.png" />

## 使用PCF

### 主视图

<img src="https://github.com/mofashaoye/GAMES202/blob/main/src/1/images/PCF_1.png" />

### 俯视图

<img src="https://github.com/mofashaoye/GAMES202/blob/main/src/1/images/PCF_2.png" />

### 阴影细节

没有了锯齿，但是所有阴影都很软

<img src="https://github.com/mofashaoye/GAMES202/blob/main/src/1/images/PCF_3.png" />

## 使用PCSS

### 主视图

<img src="https://github.com/mofashaoye/GAMES202/blob/main/src/1/images/PCSS_1.png" />

### 俯视图

<img src="https://github.com/mofashaoye/GAMES202/blob/main/src/1/images/PCSS_2.png" />

### 阴影细节

解决了SM和PCF的问题，receiver和blocker较近时阴影较硬，较远时阴影较软

<img src="https://github.com/mofashaoye/GAMES202/blob/main/src/1/images/PCSS_3.png" />
