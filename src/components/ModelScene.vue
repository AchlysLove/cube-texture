<template>
  <div class="model-scene" ref="scene"></div>
</template>

<script>
import * as THREE from "three";
import { OrbitControls } from "three/examples/jsm/controls/OrbitControls";
import { GLTFLoader } from "three/examples/jsm/loaders/GLTFLoader";
export default {
  name: "ModelScene",
  components: {},
  filters: {},
  props: {},
  data() {
    return {
      scene: null,
      camera: null,
      renderer: null
    };
  },
  computed: {},
  watch: {},
  beforeCreate() {},
  created() {},
  beforeMount() {},
  mounted() {
    // setup renderer
    this.renderer = new THREE.WebGLRenderer();
    this.renderer.setSize(window.innerWidth, window.innerHeight);
    this.renderer.antialias = true;
    this.renderer.setPixelRatio(window.devicePixelRatio);
    this.$refs.scene.appendChild(this.renderer.domElement);
    // scene setup
    this.scene = new THREE.Scene();
    this.scene.background = new THREE.Color("#333333");
    this.scene.fog = new THREE.FogExp2("#333333", 0.25);
    // camera setup
    this.camera = new THREE.PerspectiveCamera(
      75,
      this.width / this.height,
      0.1,
      1000
    );
    this.camera.lookAt(0, 0, 0);
    this.camera.position.set(0, 0, 8);
    this.camera.add(new THREE.PointLight(0xffffff));
    this.scene.add(this.camera);
    // control setup
    this.controls = new OrbitControls(this.camera, this.renderer.domElement);
    // load models
    const loader = new GLTFLoader();
    loader.load("/models/scene.gltf", gltf => {
      let mesh = gltf.scene.children[0].children[0].children[0];
      mesh.traverse(o => {
        if (o.isMesh) {
          console.log(o);
          o.material = new THREE.MeshLambertMaterial();
        }
      });
      // mesh.material = new THREE.MeshLambertMaterial();
      // console.log(mesh);
      this.scene.add(mesh);
    });
  },
  beforeUpdate() {},
  updated() {},
  activated() {},
  deactivated() {},
  beforeDestroy() {},
  destroyed() {},
  methods: {}
};
</script>

<style scoped>
.model-scene {
  width: 100vw;
  height: 100vh;
}
</style>
