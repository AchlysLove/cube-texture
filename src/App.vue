<template>
  <div class="app" ref="app">
    <model-scene></model-scene>
    <!--    <canvas class="canvas" width="800" height="450" ref="canvas"></canvas>-->
    <!--    <div class="label-canvas"></div>-->
    <!--    <div class="change-button-container">-->
    <!--      <input-->
    <!--        ref="upload0"-->
    <!--        type="file"-->
    <!--        accept="image/*"-->
    <!--        @change="changeTexture($event, 0)"-->
    <!--      />-->
    <!--      <input-->
    <!--        ref="upload1"-->
    <!--        type="file"-->
    <!--        accept="image/*"-->
    <!--        @change="changeTexture($event, 1)"-->
    <!--      />-->
    <!--      <input-->
    <!--        ref="upload2"-->
    <!--        type="file"-->
    <!--        accept="image/*"-->
    <!--        @change="changeTexture($event, 2)"-->
    <!--      />-->
    <!--      <input-->
    <!--        ref="upload3"-->
    <!--        type="file"-->
    <!--        accept="image/*"-->
    <!--        @change="changeTexture($event, 3)"-->
    <!--      />-->
    <!--    </div>-->
  </div>
</template>

<script>
import ModelScene from "./components/ModelScene";
// import * as THREE from "three";
// import { OrbitControls } from "three/examples/jsm/controls/OrbitControls";
// import {
//   CSS2DRenderer,
//   CSS2DObject
// } from "three/examples/jsm/renderers/CSS2DRenderer";
// CSS2DObject
export default {
  name: "App",
  components: {
    "model-scene": ModelScene
  },
  filters: {},
  props: {},
  data() {
    return {
      scene: null,
      camera: null,
      renderer: null,
      labelRenderer: null,
      loader: null,
      geometry: null,
      curve: null,
      labelCurve: null,
      controls: null,
      t: 0,
      tList: [0, 0.25, 0.5, 0.75],
      cubeList: [],
      currentCubeId: -1
    };
  },
  computed: {
    width() {
      return window.innerWidth;
    },
    height() {
      return window.innerHeight;
    }
  },
  watch: {},
  beforeCreate() {},
  created() {},
  beforeMount() {},
  // mounted() {
  //   window.addEventListener("resize", this.handleOnResize, false);
  //   // setup renderer
  //   this.renderer = new THREE.WebGLRenderer();
  //   this.renderer.setSize(window.innerWidth, window.innerHeight);
  //   this.renderer.antialias = true;
  //   this.renderer.setPixelRatio(window.devicePixelRatio * 1.5);
  //   this.$refs.app.appendChild(this.renderer.domElement);
  //   this.labelRenderer = new CSS2DRenderer();
  //   this.labelRenderer.setSize(window.innerWidth, window.innerHeight);
  //   this.labelRenderer.domElement.style.position = "absolute";
  //   this.labelRenderer.domElement.style.top = "0px";
  //   this.$refs.app.appendChild(this.labelRenderer.domElement);
  //   // scene setup
  //   this.scene = new THREE.Scene();
  //   this.scene.background = new THREE.Color("#333333");
  //   this.scene.fog = new THREE.FogExp2("#333333", 0.25);
  //   // camera setup
  //   this.camera = new THREE.PerspectiveCamera(
  //     75,
  //     this.width / this.height,
  //     0.1,
  //     1000
  //   );
  //   this.camera.lookAt(0, 0, 0);
  //   this.camera.position.set(0, 0, 8);
  //   this.camera.add(new THREE.PointLight(0xffffff));
  //   this.scene.add(this.camera);
  //   // control setup
  //   this.controls = new OrbitControls(
  //     this.camera,
  //     this.labelRenderer.domElement
  //   );
  //   // geometry setup
  //   const boxWidth = 1;
  //   const boxHeight = 1;
  //   const boxDepth = 1;
  //   this.geometry = new THREE.BoxGeometry(boxWidth, boxHeight, boxDepth);
  //   // path setup
  //   this.curve = new THREE.CatmullRomCurve3([
  //     new THREE.Vector3(0, 2, 0),
  //     new THREE.Vector3(2, 0, 0),
  //     new THREE.Vector3(0, -2, 0),
  //     new THREE.Vector3(-2, 0, 0)
  //   ]);
  //   this.curve.curveType = "centripetal";
  //   this.curve.closed = true;
  //   // cube label curve setup
  //   this.labelCurve = new THREE.CatmullRomCurve3([
  //     new THREE.Vector3(1, 1, 0),
  //     new THREE.Vector3(1, -1, 0),
  //     new THREE.Vector3(-1, -1, 0),
  //     new THREE.Vector3(-1, 1, 0)
  //   ]);
  //   this.labelCurve.curveType = "centripetal";
  //   this.labelCurve.closed = true;
  //   // material setup
  //   this.loader = new THREE.TextureLoader();
  //   this.loader.load(require("./assets/wall.jpeg"), texture => {
  //     let material = new THREE.MeshBasicMaterial({
  //       map: texture
  //     });
  //     for (let i = 0; i < 4; i++) {
  //       let cube = new THREE.Mesh(this.geometry, material);
  //       let cubeDiv = document.createElement("div");
  //       let pos = this.curve.getPoint(this.tList[i]);
  //       cube.position.set(pos.x, pos.y, 0);
  //       // label setup
  //       cubeDiv.className = "label";
  //       cubeDiv.textContent = "upload material";
  //       cubeDiv.addEventListener("click", () => {
  //         this.clickLabel(i);
  //       });
  //       let cubeLabel = new CSS2DObject(cubeDiv);
  //       cube.add(cubeLabel);
  //       let labelPos = this.labelCurve.getPoint(this.tList[i]);
  //       cubeLabel.position.set(labelPos.x, labelPos.y, 0);
  //       this.scene.add(cube);
  //       // add to list
  //       this.cubeList.push(cube);
  //       console.log(cube.children[0]);
  //     }
  //     // this.renderer.render(this.scene, this.camera);
  //     // this.labelRenderer.render(this.scene, this.camera);
  //     this.animate();
  //   });
  // },
  beforeUpdate() {},
  updated() {},
  activated() {},
  deactivated() {},
  beforeDestroy() {},
  destroyed() {},
  methods: {
    // animate() {
    //   requestAnimationFrame(this.animate);
    //   this.renderer.render(this.scene, this.camera);
    //   this.labelRenderer.render(this.scene, this.camera);
    //   this.tList = this.tList.map((t, index) => {
    //     t += 0.001;
    //     let pos = this.curve.getPoint(t);
    //     this.cubeList[index].position.set(pos.x, pos.y, 0);
    //     let labelPos = this.labelCurve.getPoint(t);
    //     this.cubeList[index].children[0].position.set(
    //       labelPos.x,
    //       labelPos.y,
    //       0
    //     );
    //     return t;
    //   });
    // },
    // changeTexture(e, id) {
    //   const imageURL = URL.createObjectURL(e.target.files[0]);
    //   this.loader.load(imageURL, texture => {
    //     this.cubeList[id].material = new THREE.MeshBasicMaterial({
    //       map: texture
    //     });
    //   });
    //   this.currentCubeId = -1;
    // },
    // clickLabel(id) {
    //   console.log(id);
    //   this.currentCubeId = id;
    //   this.$refs[`upload${id}`].click();
    // },
    // handleOnResize() {
    //   this.camera.aspect = window.innerWidth / window.innerHeight;
    //   this.camera.updateProjectionMatrix();
    //   this.renderer.setSize(window.innerWidth, window.innerHeight);
    //   this.labelRenderer.setSize(window.innerWidth, window.innerHeight);
    // }
  }
};
</script>

<style>
body {
  margin: 0;
}
.app {
  position: relative;
  width: 100%;
  height: 100%;
  /*display: flex;*/
  /*flex-direction: row;*/
}
.label-canvas {
  position: absolute;
  top: 0;
  left: 0;
  width: 800px;
  height: 450px;
  pointer-events: none;
}
.change-button-container {
  width: 0;
  height: 0;
  visibility: hidden;
}
.label {
  color: #ffffff;
  font-family: sans-serif;
  padding: 2px;
  /*background: rgba(0, 0, 0, 0.6);*/
  user-select: none;
  cursor: pointer;
}
</style>
