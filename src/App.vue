<template>
  <div id="app">
    <div>
      <!-- <v-lazy
        v-for="(chunk, i) in chunkShots"
        :key="i"
        :options="{
          threshold: 0.5,
        }"
        transition="fade-transition"
      > -->
      <ul>
        <li v-for="(shot, i) in shots._default" :key="i">
          <img :src="shot.thumbnailUrl" loading="lazy" />
        </li>
      </ul>
      <!-- </v-lazy> -->
      <!-- <v-img
        v-for="(shot, i) in shots._default"
        :key="i"
        :src="shot.shotUrl"
        max-width="500"
      >
        <template v-slot:placeholder>
          <v-row align="center" justify="center">
            <v-progress-circular
              indeterminate
              color="black"
            ></v-progress-circular>
          </v-row>
        </template>
      </v-img> -->
    </div>
  </div>
</template>

<script>
export default {
  name: "App",
  data: () => ({
    shots: "",
    chunkShots: [],
  }),
  mounted() {
    this.$axios
      .get(
        "https://raw.githubusercontent.com/originalnicodrgitbot/test-git-python/main/shotsdb.json"
      )
      .then((response) => {
        this.shots = response.data;
        Object.entries(this.shots._default).forEach((x, y, z) =>
          !(y % 10) ? this.chunkShots.push(z.slice(y, y + 10)) : ""
        );
        console.log(this.shots);
        console.log(this.chunkShots);
      });
  },
};
</script>

<style scoped>
#app {
  background-color: #212121;
}

ul {
  display: flex;
  flex-wrap: wrap;
}

li {
  height: 300px;
  flex-grow: 1;
  list-style: none;
  margin: 2px;
}

li:last-child {
  flex-grow: 1;
}

img {
  max-height: 100%;
  min-width: 100%;
  object-fit: cover;
  vertical-align: bottom;
}

@media (max-aspect-ratio: 1/1) {
  li {
    height: 30vh;
  }
}

@media (max-height: 480px) {
  li {
    height: 80vh;
  }
}

@media (max-aspect-ratio: 1/1) and (max-width: 480px) {
  ul {
    flex-direction: row;
  }

  li {
    height: auto;
    width: 100%;
  }
  img {
    width: 100%;
    max-height: 75vh;
    min-width: 0;
  }
}
</style>
