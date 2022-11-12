class DirectionalLight {

    constructor(lightIntensity, lightColor, lightPos, focalPoint, lightUp, hasShadowMap, gl) {
        this.mesh = Mesh.cube(setTransform(0, 0, 0, 0.2, 0.2, 0.2, 0));
        this.mat = new EmissiveMaterial(lightIntensity, lightColor);
        this.lightPos = lightPos;
        this.focalPoint = focalPoint;
        this.lightUp = lightUp

        this.hasShadowMap = hasShadowMap;
        this.fbo = new FBO(gl);
        if (!this.fbo) {
            console.log("无法设置帧缓冲区对象");
            return;
        }
    }

    CalcLightMVP(translate, scale) {
        let lightMVP = mat4.create();
        let modelMatrix = mat4.create();
        let viewMatrix = mat4.create();
        let projectionMatrix = mat4.create();

        // Model transform
        mat4.identity(modelMatrix);
        mat4.translate(modelMatrix, modelMatrix, translate);
        mat4.scale(modelMatrix, modelMatrix, scale);
        // View transform 
        // 你需要使用 lightPos, focalPoint, lightUp 来构造摄像机的LookAt 矩阵
        mat4.lookAt(viewMatrix, this.lightPos, this.focalPoint, this.lightUp);
        // Projection transform
        // 推荐在使用正交投影，这可以保证场景深度信息在坐标系转换中保持线性从而便于之后使用。
        // 正交投影的参数决定了 shadow map 所覆盖的范围。
        // mat4.ortho(matrix, left, right, down, up, near, far)
        // (static) ortho(out, left, right, bottom, top, near, far) → {mat4}
        mat4.ortho(projectionMatrix, -120.0, 120.0, -120.0, 120.0, 0.1, 500);

        mat4.multiply(lightMVP, projectionMatrix, viewMatrix);
        mat4.multiply(lightMVP, lightMVP, modelMatrix);

        return lightMVP;
    }
}
