<template>
  <div id="app">
    {{ shots }}
  </div>
</template>

<script>
export default {
  name: "App",
  data: () => ({
    shots: "",
  }),
  mounted() {
    this.$axios
      .get(
        "https://raw.githubusercontent.com/originalnicodrgitbot/test-git-python/main/shotsdb.json"
      )
      .then((response) => {
        this.shots = response.data;
        console.log(this.shots);
      });
  },
};
</script>

<style>
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}
</style>
