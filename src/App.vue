<template>
  <div class="app">
    <canvas class="canvas" width="800" height="450" ref="canvas"></canvas>
    <input type="file" accept="image/*" @change="changeTexture" />
  </div>
</template>

<script>
import * as THREE from "three";
export default {
  name: "App",
  components: {},
  filters: {},
  props: {},
  data() {
    return {
      scene: null,
      camera: null,
      renderer: null,
      loader: null,
      geometry: null
    };
  },
  computed: {
    width() {
      return this.$refs.canvas.clientWidth;
    },
    height() {
      return this.$refs.canvas.clientHeight;
    }
  },
  watch: {},
  beforeCreate() {},
  created() {},
  beforeMount() {},
  mounted() {
    // scene setup
    this.renderer = new THREE.WebGLRenderer({ canvas: this.$refs.canvas });
    this.renderer.setSize(this.width, this.height);
    this.scene = new THREE.Scene();
    this.camera = new THREE.PerspectiveCamera(
      75,
      this.width / this.height,
      0.1,
      1000
    );
    this.camera.position.z = 5;
    // geometry setup
    const boxWidth = 1;
    const boxHeight = 1;
    const boxDepth = 1;
    this.geometry = new THREE.BoxGeometry(boxWidth, boxHeight, boxDepth);
    // material setup
    this.loader = new THREE.TextureLoader();
    this.loader.load(require("./assets/wall.jpeg"), texture => {
      let material = new THREE.MeshBasicMaterial({
        map: texture
      });
      this.cube = new THREE.Mesh(this.geometry, material);
      this.scene.add(this.cube);
      this.renderer.render(this.scene, this.camera);
      this.animate();
    });
  },
  beforeUpdate() {},
  updated() {},
  activated() {},
  deactivated() {},
  beforeDestroy() {},
  destroyed() {},
  methods: {
    animate() {
      requestAnimationFrame(this.animate);
      this.renderer.render(this.scene, this.camera);
      this.cube.rotation.y += 0.01;
    },
    changeTexture(e) {
      // console.log(e.target.files[0]);
      const imageURL = URL.createObjectURL(e.target.files[0]);
      this.loader.load(imageURL, texture => {
        this.cube.material = new THREE.MeshBasicMaterial({
          map: texture
        });
      });
    }
  }
};
</script>

<style>
.app {
  width: 100%;
  height: 100%;
  display: flex;
  flex-direction: row;
}
</style>
