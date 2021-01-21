<template>
  <div id="app">
    <v-container>
      <v-lazy
        v-for="(chunk, i) in chunkShots"
        :key="i"
        :options="{
          threshold: 0.5,
        }"
        min-height="100vh"
        transition="fade-transition"
      >
        <!-- From ~550 Mb to ~7 775 Mb or RAM usage when you scroll all the way down -->
        <div class="jg">
          <div id="jaja" v-for="(shot, i) in chunk" :key="i">
            <img
              :src="shot[1].shotUrl"
              :alt="shot[1].gameName"
              style="max-height: 350px"
            />
          </div>
        </div>
      </v-lazy>
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
    </v-container>
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
.jg {
  display: flex;
  flex-wrap: wrap;
  justify-content: center;
}

.jg > div,
.jg::after {
  --ratio: calc(var(--w) / var(--h));
  --row-height: 15rem;
  flex-basis: calc(var(--ratio) * var(--row-height));
}

.jg > div {
  margin: 0.25rem;
  flex-grow: calc(var(--ratio) * 100);
}

.jg::after {
  --w: 2;
  --h: 1;
  content: "";
  flex-grow: 1000000;
}

.jg > div > img {
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
