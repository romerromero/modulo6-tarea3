<template>
  <div>
    <select class="form-select" aria-label="Default select example" @change="changeSemestre(value)" v-model="idSemestre">
          <option value="null">Seleccionar Semestre</option>
          <option v-for="(value) in semestres" :key="value.id" :value="value.id" >{{value.nombre}}</option>                
          </select>
  </div>

</template>

<script>
export default {
    name:'listaSemestre',
    data(){
        return{ 
          semestres : [],
          ingreso: true
        } 
    },
    methods:{
      getSemestres(){
        console.log(process.env.VUE_APP_RUTA_API);
        axios({
          method:"get",
          url: process.env.VUE_APP_RUTA_API + "/semestres",
        })
        .then(response =>{
          this.semestres = response.data;
          console.log(this.semestres);
        })
        .catch(e => console.log(e));
      },
      changeSemestre(){        
        console.log('Ingreso al change con id: ' + this.idSemestre);
        axios({
          method:"get",
          url: process.env.VUE_APP_RUTA_API + "/planestudios?_expand=materia&_expand=semestre&semestreId=" + this.idSemestre,
        })
        .then(response =>{
          this.planEstudios = response.data;
          console.log(this.planEstudios);
        })
        .catch(e => console.log(e));
      },
      mounted(){
        debugger
        this.getSemestres();
      }
    },
    watch:
    {
        ingreso:function(){
            this.$emit('listar');
        }
    }
}
</script>

<style>

</style>