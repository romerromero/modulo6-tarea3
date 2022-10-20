<template>
  <div class="container">
    <h4>Lista de Plan de Estudio</h4>
    <hr>
    <div class="row">
        <div class="col-md-4">
            <select class="form-select" aria-label="Default select example" @change="changeSemestre(value)" v-model="idSemestre">
                <option value="null">Seleccionar</option>
                <option v-for="(value) in semestres" :key="value.id" :value="value.id" >{{value.nombre}}</option>                
              </select>
                <!-- <lista-semestre @listar="getSemestres"></lista-semestre> -->
        </div>
        <div class="col-md-4">
            <crear-plan-estudio :registrar="true" @listar="changeSemestre"></crear-plan-estudio>
        </div>
        
      </div>  


    <table class="table">
      <thead class="table-dark">
        <tr>
          <th scope="col">#</th>
          <th scope="col">Materia</th>
          <th scope="col">Total Horas Practica</th>
          <th scope="col">Total Horas Teorica</th>
          <th scope="col">Total Horas Laboratorio</th>          
          <th scope="col">Acciones</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="(value,index) in planEstudios" :key="value.id">
          <th scope="row">{{index + 1}}</th>
          <td>{{ value.materia.nombre}}</td>
          <td>{{ value.totalHorasPractica}}</td>
          <td>{{ value.totalHorasTeorica}}</td>
          <td>{{ value.totalHorasLaboratorio}}</td>          
          <td>
            <div class="row">
              <div class="col-md-6 text-right">
                <editar-plan-estudio :idPlanEstudio="value.id" :editar="true"  @listar="changeSemestre"></editar-plan-estudio>
              </div>
              <div class="col-md-6 text-left">
                <button class="btn btn-sm btn-danger" @click="eliminarPlanEstudio(value)"><i class="fa fa-trash"></i> Eliminar</button>
              </div>
            </div>
              
            <!-- <button class="btn btn-sm btn-success m-1"><i class="fa fa-pencil"></i> Editar</button> -->
          </td>
    </tr>
      </tbody>
    </table>
    <div class="alert alert-info" role="alert" v-if="planEstudios.length == 0 && idSemestre != null">
       No existe materias asignadas a este semestre
    </div>
  </div>
</template>

<script>
import ListaSemestre from "../components/ListaSemestre.vue";
import CrearPlanEstudio from "../components/CrearPlanEstudio.vue";
import EditarPlanEstudio from "../components/EditarPlanEstudio.vue";
export default {
    name: 'materiaView',
    props:[],
    data(){
        return {
          planEstudios: [],
          semestres: [],
          idSemestre: null,
          textoABuscar: ""
        }
    },
    methods:{
      getPlanEstudios(){
        axios({
          method:"get",
          url: process.env.VUE_APP_RUTA_API + "/planestudios?_expand=materia&_expand=semestre",
        })
        .then(response =>{
          this.planEstudios = response.data;
        })
        .catch(e => console.log(e));
      },
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
      changeSemestre(){        
        if(this.idSemestre != "null"){

          axios({
            method:"get",
          url: process.env.VUE_APP_RUTA_API + "/planestudios?_expand=materia&_expand=semestre&semestreId=" + this.idSemestre,
          })
          .then(response =>{
            this.planEstudios = response.data;
          })
          .catch(e => console.log(e));
          } else {
            axios({
            method:"get",
          url: process.env.VUE_APP_RUTA_API + "/planestudios?_expand=materia&_expand=semestre",
          })
          .then(response =>{
            this.planEstudios = response.data;
          })
          .catch(e => console.log(e));
        }
      },      
      eliminarPlanEstudio(item){
        this.$swal.fire({
          title: 'Estas seguro de eliminar el plan de estudio?',
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
              url: process.env.VUE_APP_RUTA_API + "/planestudios/" + item.id
            })
            .then(response => {
              
              axios({
                    method: "patch",
                    url:  process.env.VUE_APP_RUTA_API + "/materias/" + item.materiaId,
                    data: {
                        enplanestudio: false
                    }
                })
                .then(response =>{
                    console.log(response);
                })
                .catch(e => console.log(e));


              this.changeSemestre();
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
      CrearPlanEstudio,
      EditarPlanEstudio,
      ListaSemestre
    }
}
</script>

<style>

</style>