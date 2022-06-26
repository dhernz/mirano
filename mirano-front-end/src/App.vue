<template>
  <router-view/>
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
</style>
