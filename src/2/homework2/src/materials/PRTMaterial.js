<<<<<<< HEAD
<<<<<<< HEAD
class PRTMaterial extends Material {

    constructor(color, vertexShader, fragmentShader) {
        super({                    
            'uPrecomputeLR': { type: 'updatedInRealTime', value: null },   
            'uPrecomputeLG': { type: 'updatedInRealTime', value: null },   
            'uPrecomputeLB': { type: 'updatedInRealTime', value: null },   
            'uSampler': { type: 'texture', value: color },
        }, ['aPrecomputeLT'], vertexShader, fragmentShader, null);
    }
}

async function buildPRTMaterial(color, vertexPath, fragmentPath) {
    let vertexShader = await getShaderString(vertexPath);
    let fragmentShader = await getShaderString(fragmentPath);

    return new PRTMaterial(color, vertexShader, fragmentShader);
=======
class PRTMaterial extends Material {

    constructor(color, vertexShader, fragmentShader) {
        super({                    
            'uPrecomputeLR': { type: 'updatedInRealTime', value: null },   
            'uPrecomputeLG': { type: 'updatedInRealTime', value: null },   
            'uPrecomputeLB': { type: 'updatedInRealTime', value: null },   
            'uSampler': { type: 'texture', value: color },
        }, ['aPrecomputeLT'], vertexShader, fragmentShader, null);
    }
}

async function buildPRTMaterial(color, vertexPath, fragmentPath) {
    let vertexShader = await getShaderString(vertexPath);
    let fragmentShader = await getShaderString(fragmentPath);

    return new PRTMaterial(color, vertexShader, fragmentShader);
>>>>>>> GAMES202/main
=======
class PRTMaterial extends Material {

    constructor(color, vertexShader, fragmentShader) {
        super({                    
            'uPrecomputeLR': { type: 'updatedInRealTime', value: null },   
            'uPrecomputeLG': { type: 'updatedInRealTime', value: null },   
            'uPrecomputeLB': { type: 'updatedInRealTime', value: null },   
            'uSampler': { type: 'texture', value: color },
        }, ['aPrecomputeLT'], vertexShader, fragmentShader, null);
    }
}

async function buildPRTMaterial(color, vertexPath, fragmentPath) {
    let vertexShader = await getShaderString(vertexPath);
    let fragmentShader = await getShaderString(fragmentPath);

    return new PRTMaterial(color, vertexShader, fragmentShader);
>>>>>>> 90261e9c0d7325ddd6cb7f729fecf183404dc6d7
}