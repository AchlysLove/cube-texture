<template>
  <div class="app">
    <canvas class="canvas" width="800" height="450" ref="canvas"></canvas>
    <div class="change-button-container">
      <input type="file" accept="image/*" @change="changeTexture($event, 0)" />
      <input type="file" accept="image/*" @change="changeTexture($event, 1)" />
      <input type="file" accept="image/*" @change="changeTexture($event, 2)" />
      <input type="file" accept="image/*" @change="changeTexture($event, 3)" />
    </div>
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
      geometry: null,
      curve: null,
      t: 0,
      tList: [0, 0.25, 0.5, 0.75],
      cubeList: []
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
      100,
      this.width / this.height,
      0.1,
      1000
    );
    this.camera.lookAt(0, 0, 0);
    this.camera.position.set(0, 0, 4);
    // geometry setup
    const boxWidth = 1;
    const boxHeight = 1;
    const boxDepth = 1;
    this.geometry = new THREE.BoxGeometry(boxWidth, boxHeight, boxDepth);
    // path setup
    this.curve = new THREE.CatmullRomCurve3([
      new THREE.Vector3(0, 2, 0),
      new THREE.Vector3(2, 0, 0),
      new THREE.Vector3(0, -2, 0),
      new THREE.Vector3(-2, 0, 0)
    ]);
    this.curve.curveType = "centripetal";
    this.curve.closed = true;
    // material setup
    this.loader = new THREE.TextureLoader();
    this.loader.load(require("./assets/wall.jpeg"), texture => {
      let material = new THREE.MeshBasicMaterial({
        map: texture
      });
      for (let i = 0; i < 4; i++) {
        let cube = new THREE.Mesh(this.geometry, material);
        this.cubeList.push(cube);
        this.scene.add(cube);
        let pos = this.curve.getPoint(this.tList[i]);
        console.log(pos);
        cube.position.set(pos.x, pos.y, 0);
      }
      // this.cube.position.set(5, 0, 0);
      // this.scene.add(this.cube);
      // this.cube.position.set(2, 2, 0);
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
      this.tList = this.tList.map((t, index) => {
        t += 0.001;
        let pos = this.curve.getPoint(t);
        this.cubeList[index].position.set(pos.x, pos.y, 0);
        return t;
      });
    },
    changeTexture(e, id) {
      const imageURL = URL.createObjectURL(e.target.files[0]);
      this.loader.load(imageURL, texture => {
        this.cubeList[id].material = new THREE.MeshBasicMaterial({
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
.change-button-container {
  display: flex;
  flex-direction: column;
}
</style>
