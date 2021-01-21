<template>
  <div id="app">
    <div>
      <!-- <v-lazy
        v-for="(chunk, i) in chunkShots"
        :key="i"
        :options="{
          threshold: 0.5,
        }"
        min-height="100vh"
        transition="fade-transition"
      > -->
      <div class="jg">
        <a
          id="imgCtn"
          v-for="(shot, i) in shots._default"
          :key="i"
          :style="`--w: ${shot.width / 4.8}; --h: ${shot.height / 4.8};`"
        >
          <img :src="shot.thumbnailUrl" :alt="shot.gameName" height="300" />
        </a>
      </div>
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
          !(y % 50) ? this.chunkShots.push(z.slice(y, y + 50)) : ""
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
.jg {
  display: flex;
  flex-wrap: wrap;
  justify-content: center;
}

.jg > a,
.jg::after {
  --ratio: calc(var(--w) / var(--h));
  --row-height: 15rem;
  flex-basis: calc(var(--ratio) * var(--row-height));
}

.jg > a {
  margin: 0.25rem;
  flex-grow: calc(var(--ratio) * 100);
}

.jg::after {
  --w: 2;
  --h: 1;
  content: "";
  flex-grow: 1000000;
}

.jg > a > img {
  display: block;
  position: relative;
  width: 100%;
  opacity: 0;
  object-fit: cover;
  animation: fadeIn 1000ms forwards;
}

@keyframes fadeIn {
  0% {
    opacity: 0;
  }
  100% {
    opacity: 1;
  }
}

@-webkit-keyframes fadeIn {
  0% {
    opacity: 0;
  }
  100% {
    opacity: 1;
  }
}
</style>
