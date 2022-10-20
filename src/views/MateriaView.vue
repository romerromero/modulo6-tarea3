<template>
  <div class="container">
    <h4>Lista de Materia</h4>
    <hr>
    <div class="row">
      <div class="col-md-8">
          <crear-materia :registrar="true" @listar="getMaterias"></crear-materia>
      </div>
      <div class="col-md-4">
        <div class="input-group input-group mb-3">
          <input type="text" class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm" placeholder="Buscar Materia" v-model="textoABuscar" @keyup.enter="buscarMateria()">          
          <button class="btn btn-primary" @click.prevent="buscarMateria()"><i class="fa fa-search"></i> Buscar</button>
        </div>
      </div>
    </div>  


    <table class="table">
      <thead class="table-dark">
        <tr>
          <th scope="col">#</th>
          <th scope="col">Sigla</th>
          <th scope="col">Nombre de la Materia</th>
          <th scope="col">Acciones</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="(value,index) in materias" :key="value.id">
          <th scope="row">{{index + 1}}</th>
          <td>{{ value.sigla}}</td>
          <td>{{ value.nombre}}</td>
          <td>
            <div class="row">
              <div class="col-md-3 text-right">
                <editar-materia :idMateria="value.id" :editar="true"  @listar="getMaterias"></editar-materia>
              </div>
              <div class="col-md-3 text-left">
                <button class="btn btn-sm btn-danger" @click="eliminarMateria(value)"><i class="fa fa-trash"></i> Eliminar</button>
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
import CrearMateria from "../components/CrearMateria.vue";
import EditarMateria from "../components/EditarMateria.vue";
export default {
    name: 'materiaView',
    data(){
        return {
          materias: [],
          materia:{},
          textoABuscar: "",
          
        }
    },
    methods:{
      getMaterias(){
        axios({
          method:"get",
          url: process.env.VUE_APP_RUTA_API + "/materias",
        })
        .then(response =>{
          this.materias = response.data;
        })
        .catch(e => console.log(e));
      },
      buscarMateria(){
        axios({
          method:"get",
          url: process.env.VUE_APP_RUTA_API + "/materias/?q=" + this.textoABuscar,
        })
        .then(response =>{
          this.materias = response.data;
        })
        .catch(e => console.log(e));
      },
      eliminarMateria(item){

        if(!item.enplanestudio){      
          this.$swal.fire({
            title: 'Estas seguro de , la materia se encuentra en un plan de estudio la materia ' + item.nombre + '?',
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
                url: process.env.VUE_APP_RUTA_API + "/materias/" + item.id
              })
              .then(response => {
                this.getMaterias();
              })
              .catch( e => console.log(e));
            }
          })
        } else {
          this.$swal({
                title:"No se puede eliminar",
                text:'La materia se encuentra en un plan de estudio',
                icon:'error'
               })
        }
      }
    },
    mounted(){
      this.getMaterias();
    },
    computed:{},
    components:{
      CrearMateria,
      EditarMateria
    }
}
</script>

<style>

</style>