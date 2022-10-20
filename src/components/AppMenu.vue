<template>
  <nav class="navbar navbar-expand-lg bg-light">
  <div class="container-fluid">
    <a class="navbar-brand" href="#">{{titulo}}  ({{ mode }}) </a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
      <ul class="navbar-nav me-auto mb-2 mb-lg-0">
        <li class="nav-item m-2">
          <h3>

          <router-link to="/">Home</router-link> 
          </h3>
        </li>
        <li class="nav-item m-2">
          <h3>

          <router-link to="/semestre">Semestre</router-link> 
          </h3>
        </li>
        <li class="nav-item m-2">
          <h3>

            <router-link to="/materia">Materia</router-link>
          </h3>
        </li>
        <li class="nav-item m-2">
          <h3>

           <router-link to="/planEstudio">Plan de Estudio</router-link>
          </h3>
        </li>
      </ul>
    </div>
  </div>
</nav>

<app-alert></app-alert>
</template>

<script>
export default {
    name:'appMenu',
    data(){
        return{
          mode: null
        }
    },
    props:[
        'titulo'
    ],
    computed:{

    },
    mounted(){
      this.mode = process.env.VUE_APP_MODE
    },
    components:{
    }
}
</script>

<style >

</style>