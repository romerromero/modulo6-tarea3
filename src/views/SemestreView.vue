<template>
  <div class="container">
    <h4>Lista de Semestre</h4>
    <hr>
    <div class="row">
      <div class="col-md-8">
          <crear-semestre :registrar="true" @listar="getSemestres"></crear-semestre>
      </div>
      <div class="col-md-4">
        <div class="input-group input-group mb-3">
          <input type="text" class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm" placeholder="Buscar Semestre" v-model="textoABuscar" @keyup.enter="buscarSemestre()">          
          <button class="btn btn-primary" @click.prevent="buscarSemestre()"><i class="fa fa-search"></i> Buscar</button>
        </div>
      </div>
    </div>    

    <table class="table">
      <thead class="table-dark">
        <tr>
          <th scope="col">#</th>
          <th scope="col">Nombre de Semestre</th>
          <th scope="col">Acciones</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="(value,index) in semestres" :key="value.id">
          <th scope="row">{{index + 1}}</th>
          <td>{{ value.nombre}}</td>
          <td>
            <div class="row">
              <div class="col-md-2">
                <editar-semestre :idSemestre="value.id" :editar="true"  @listar="getSemestres"></editar-semestre>
              </div>
              <div class="col-md-3">
                <button class="btn btn-sm btn-danger" @click="eliminarSemestre(value)"><i class="fa fa-trash"></i> Eliminar</button>
              </div>
            </div>
              
            <!-- <button class="btn btn-sm btn-success m-1"><i class="fa fa-pencil"></i> Editar</button> -->
          </td>
    </tr>
      </tbody>
    </table>
  </div>
</template>

<script>
import CrearSemestre from "../components/CrearSemestre.vue";
import EditarSemestre from "../components/EditarSemestre.vue";
export default {
    name: 'semestreView',
    data(){
        return {
          semestres: [],
          textoABuscar: ""
        }
    },
    methods:{
      getSemestres(){
        axios({
          method:"get",
          url: process.env.VUE_APP_RUTA_API + "/semestres",
        })
        .then(response =>{
          this.semestres = response.data;
        })
        .catch(e => console.log(e));
      },
      buscarSemestre(){
        axios({
          method:"get",
          url: process.env.VUE_APP_RUTA_API + "/semestres/?q=" + this.textoABuscar,
        })
        .then(response =>{
          this.semestres = response.data;
        })
        .catch(e => console.log(e));
      },
      eliminarSemestre(item){
        this.$swal.fire({
          title: 'Estas seguro de eliminar el ' + item.nombre + '?',
          text: "No podras revertir esto!",
          icon: 'warning',
          showCancelButton: true,
          confirmButtonColor: '#3085d6',
          cancelButtonColor: '#d33',
          confirmButtonText: 'SI!'
        }).then((result) => {
          if (result.isConfirmed) {

            axios({
              method: "delete",
              url: process.env.VUE_APP_RUTA_API + "/semestres/" + item.id
            })
            .then(response => {
              this.getSemestres();
            })
            .catch( e => console.log(e));
          }
        })

      }
    },
    mounted(){
      this.getSemestres();
    },
    computed:{},
    components:{
      CrearSemestre,
      EditarSemestre
    }
}
</script>

<style>

</style>