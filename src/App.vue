<template>
  <v-app id="app">
    <div>
      <div class="jg">
        <a
          id="imgCtn"
          v-for="(shot, i) in shots"
          :key="i"
          :style="`--w: ${shot.width / 4.8}; --h: ${
            shot.height / 4.8
          }; position: relative`"
          :href="`${!link ? 'discord://' : ''}${shot.messageUrl}`"
          ondragstart="return false"
        >
          <img
            :src="shot.imageUrl"
            :alt="shot.name"
            height="300"
            ondragstart="return false"
          />
          <div class="onImgHover" :style="`height: 4rem;`">
            <span>{{ shot.name }}</span>
          </div>
        </a>
      </div>
      <div class="selectLink">
        <span @click="link = true" :class="link ? 'selectedLink' : ''">
          HTTP link
        </span>
        <span @click="link = false" :class="!link ? 'selectedLink' : ''">
          App link
        </span>
      </div>
    </div>
    <!-- <ShowShot
      v-show="isShown && selectedShot != undefined"
      :author="selectedShot.author"
      :authorsAvatarUrl="selectedShot.authorsAvatarUrl"
      :date="selectedShot.date"
      :gameName="selectedShot.gameName"
      :score="selectedShot.score"
      :shotUrl="selectedShot.shotUrl"
      v-on:close="isShown = false"
    ></ShowShot> -->
  </v-app>
</template>

<script>
import { getDatabase, ref, child, get } from "firebase/database";
// import ShowShot from "@/components/ShowShot";

export default {
  name: "App",
  data: () => ({
    userId: "",
    shots: "",
    link: false,
  }),
  mounted() {
    this.userId = this.$route.query.id;
    const dbRef = ref(getDatabase());
    get(child(dbRef, `${this.userId}`))
      .then((shots) => {
        if (shots.exists()) {
          this.shots = shots.val();
        } else {
          console.log("No data available");
        }
      })
      .catch((error) => {
        console.error(error);
      });
  },
  components: {
    // ShowShot,
  },
};
</script>

<style scoped>
.selectLink {
  position: fixed;
  bottom: 0;
  right: 0;
  padding: .5rem;
  background-color: black;
  display: flex;
  gap: 1rem;
  cursor: pointer;
  z-index: 10;
}

.selectedLink {
  background-color: rgb(156, 1, 53);
  padding: 0 .25rem;
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

a {
  text-decoration: none;
  color: #fff !important;
}

.onImgHover {
  width: 100%;
  position: absolute;
  display: flex;
  align-items: center;
  justify-content: center;
  background: -moz-linear-gradient(
    0deg,
    rgba(0, 0, 0, 1) 0%,
    rgba(0, 0, 0, 0) 100%
  );
  background: -webkit-linear-gradient(
    0deg,
    rgba(0, 0, 0, 1) 0%,
    rgba(0, 0, 0, 0) 100%
  );
  background: linear-gradient(0deg, rgba(0, 0, 0, 1) 0%, rgba(0, 0, 0, 0) 100%);
  opacity: 0;
  z-index: 1;
  transform: translateY(-4rem);
  transition: 200ms;
}

a {
  text-decoration: none;
  color: #fff;
}

img:hover ~ .onImgHover,
.onImgHover:hover {
  opacity: 1;
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
