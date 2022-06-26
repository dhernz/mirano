<template >
  <div class = "view p-6">
    <router-view/>
  </div>
</template>

<script>
import { useGlobalStore } from '@/store/GlobalStore';

export default {
  name: 'App',
  components: {
  },
  setup: function() {
    const global = useGlobalStore();
    return {global}
    },

  created: function() {
    this.global.printName();
  }
}
</script>

<style>
@import url('https://fonts.googleapis.com/css2?family=Roboto:ital,wght@0,700;1,700&display=swap');
@import url('https://fonts.googleapis.com/css2?family=Anybody:wght@600&display=swap');

  body, div
    {
    box-sizing: border-box;
    }

  body {
    width: 100vw;
    height: 100vh;
    overflow: hidden;
    }

  #app {
    width: 100%;
    height: 100%;
    overflow: hidden;
    }

  .view {
    background-color: #F6FBFE;
    height: 100%;
    overflow-y: auto;
    }
</style>
