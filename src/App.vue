<template>
  <app-menu titulo="My App"></app-menu>
  <router-view />
</template>
<script>
import AppMenu from './components/AppMenu.vue';
export default {

    name:'app',
    data(){
      return{
      }
    },
    methods:{

    },
    mounted(){

    },
    components:{
      AppMenu    
    }
}
</script>
<style>

.abs-center{
  display: flex;
  align-items: center;
  justify-content: center;
  min-height: 100vh;
}

nav {
  padding: 30px;
}

nav a {
  font-weight: bold;
  color: #2c3e50;
}

nav a.router-link-exact-active {
  color: #42b983;
}
</style>
