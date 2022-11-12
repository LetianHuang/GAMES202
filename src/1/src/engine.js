//var 一个全局变量 -> 相机位置
var cameraPosition = [30, 30, 30]

//生成的纹理的分辨率，纹理必须是标准的尺寸 256*256 1024*1024  2048*2048
var resolution = 2048;
var fbo;

GAMES202Main();

function GAMES202Main() {
	// Init canvas and gl
	// document文档节点（也叫根节点），可以访问整个HTML文档
	// document.querySelector -> 获取文档中id为glcanvas的元素
	// const声明的常量必须初始化，赋值过后不能再次修改
	const canvas = document.querySelector('#glcanvas');
	// 给当前图形标签添加高宽属性
	canvas.width = window.screen.width;
	canvas.height = window.screen.height;
	// canvas标签的getContext()方法，这里表示：
	// 创建一个WebGLRenderingContext对象作为3D渲染的上下文
	const gl = canvas.getContext('webgl');
	if (!gl) {
		alert('Unable to initialize WebGL. Your browser or machine may not support it.');
		return;
	}

	// Add camera
	/**
	 * THREE.PerspectiveCamera() Three.js 获取相机对象
	 * @param fov 摄像机视锥体垂直视野角度
	 * @param aspect 摄像机视锥体宽高比
	 * @param near 摄像机视锥体近端面
	 * @param far 摄像机视锥体远端面
	 */
	const camera = new THREE.PerspectiveCamera(75, gl.canvas.clientWidth / gl.canvas.clientHeight, 1e-2, 1000);
	//这里position直接调用最开始定的全局变量

	// Add camera control
	const cameraControls = new THREE.OrbitControls(camera, canvas);
	cameraControls.enableZoom = true;
	cameraControls.enableRotate = true;
	cameraControls.enablePan = true;
	cameraControls.rotateSpeed = 0.3;
	cameraControls.zoomSpeed = 1.0;
	cameraControls.panSpeed = 0.8;


	// Add resize listener
	function setSize(width, height) {
		camera.aspect = width / height;
		camera.updateProjectionMatrix();
	}
	setSize(canvas.clientWidth, canvas.clientHeight);
	window.addEventListener('resize', () => setSize(canvas.clientWidth, canvas.clientHeight));

	camera.position.set(cameraPosition[0], cameraPosition[1], cameraPosition[2]);
	cameraControls.target.set(0, 0, 0);

	// Add renderer
	const renderer = new WebGLRenderer(gl, camera);

	// Add lights
	// light - is open shadow map == true
	let lightPos = [0, 80, 80];
	let focalPoint = [0, 0, 0];
	let lightUp = [0, 1, 0]
	const directionLight = new DirectionalLight(5000, [1, 1, 1], lightPos, focalPoint, lightUp, true, renderer.gl);
	renderer.addLight(directionLight);

	// Add shapes
	
	let floorTransform = setTransform(0, 0, -30, 4, 4, 4);
	let obj1Transform = setTransform(0, 0, 0, 20, 20, 20);
	let obj2Transform = setTransform(40, 0, -40, 10, 10, 10);

	loadOBJ(renderer, 'assets/mary/', 'Marry', 'PhongMaterial', obj1Transform);
	loadOBJ(renderer, 'assets/mary/', 'Marry', 'PhongMaterial', obj2Transform);
	loadOBJ(renderer, 'assets/floor/', 'floor', 'PhongMaterial', floorTransform);
	

	// let floorTransform = setTransform(0, 0, 0, 100, 100, 100);
	// let cubeTransform = setTransform(0, 50, 0, 10, 50, 10);
	// let sphereTransform = setTransform(30, 10, 0, 10, 10, 10);

	// loadOBJ(renderer, 'assets/basic/', 'cube', 'PhongMaterial', cubeTransform);
	// loadOBJ(renderer, 'assets/basic/', 'sphere', 'PhongMaterial', sphereTransform);
	// loadOBJ(renderer, 'assets/basic/', 'plane', 'PhongMaterial', floorTransform);

	cameraControls.autoRotate = true;
	cameraControls.autoRotateSpeed = 0.0;

	function createGUI() {
		const gui = new dat.gui.GUI();
		//gui.add(); //直接添加GUI栏
		const panelRotate = gui.addFolder('Model Move');
		panelRotate.add(cameraControls, 'autoRotateSpeed', { Stopped: 0, Slow: 4, Fast: 10 });
		panelRotate.open();
	}
	createGUI();

	function mainLoop(now) {
		cameraControls.update();

		renderer.render();
		
		requestAnimationFrame(mainLoop);
	}
	requestAnimationFrame(mainLoop);
}

function setTransform(t_x, t_y, t_z, s_x, s_y, s_z) {
	return {
		modelTransX: t_x,
		modelTransY: t_y,
		modelTransZ: t_z,
		modelScaleX: s_x,
		modelScaleY: s_y,
		modelScaleZ: s_z,
	};
}
