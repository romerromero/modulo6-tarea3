<template>
  <div>
    <!-- Button trigger modal -->
        <button type="button" class="btn btn-success btn-sm" data-bs-toggle="modal" :data-bs-target="`#editarplanestudioModal${idPlanEstudio}`" 
        v-on:click="getPlanEstudio()"
        >
            <i class="fa fa-pencil"  >                
            </i>
            Editar
        </button>
        <!-- Modal -->
        <div class="modal fade" :id="`editarplanestudioModal${idPlanEstudio}`" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="exampleModalLabel">Editar Materia</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form action="" @submit.prevent="editarPlanEstudio()">
                    <div class="row">
                        <label for="totalHorasPractica" class="control-label">Total Horas Practica:</label>
                        <input type="number" name="" id="totalHorasPractica" class="form-control" v-model="planEstudio.totalHorasPractica">
                    </div>
                    <div class="row">
                        <label for="totalHorasTeorica" class="control-label">Total Horas Teorica:</label>
                        <input type="number" name="" id="totalHorasTeorica" class="form-control" v-model="planEstudio.totalHorasTeorica">
                    </div>
                    <div class="row">
                        <label for="totalHorasLaboratorio" class="control-label">Total Horas Laboratorio:</label>
                        <input type="number" name="" id="totalHorasLaboratorio" class="form-control" v-model="planEstudio.totalHorasLaboratorio">
                    </div>
                    <div class="modal-footer">
                        <button type="submit" class="btn btn-primary"><i class="fa fa-save"></i> Editar</button>
                        <button type="button" class="btn btn-secondary" :id="`cancelarplanestudioModal${idPlanEstudio}`" data-bs-dismiss="modal"><i class="fa fa-times"></i> Cerrar</button>
                    </div>
                </form>
            </div>
           
            </div>
        </div>
        </div>
  </div>
</template>

<script>
export default {
    name:'editarPlanEstudio',
    props:['idPlanEstudio','editar'],
    data(){
        return{
            planEstudio:{
                id: null,               
                totalHorasPractica: null,
                totalHorasTeorica: null,
                totalHorasLaboratorio: false
            },
            editado:false,
        }
    },
    methods:{
        editarPlanEstudio(){
            if(this.planEstudio.totalHorasPractica != null && this.planEstudio.totalHorasTeorica != null && this.planEstudio.totalHorasLaboratorio != null){
                axios({
                    method: "patch",
                    url:  process.env.VUE_APP_RUTA_API + "/planestudios/" + this.idPlanEstudio,
                    data: this.planEstudio
                })
                .then(response =>{
                this.planEstudio.totalHorasPractica = null;
                this.planEstudio.totalHorasTeorica = null;
                this.planEstudio.totalHorasLaboratorio = null;
                this.editado=!this.editado;
                
                document.getElementById('cancelarplanestudioModal'+this.idPlanEstudio).click();
                })
                .catch(e => console.log(e));
            } else {
                this.$swal({
                title:"Plan de Estudio",
                text:'Campos requerido',
                icon:'error'
               })
            }
        },

        getPlanEstudio(){
            axios({
                method: "get",
                url: process.env.VUE_APP_RUTA_API + '/planestudios/' + this.idPlanEstudio,
            })
            .then(response =>{
                this.planEstudio = response.data;
            })
            .catch(e => console.log(e))
        }
    },
    mounted(){
       this.getPlanEstudio();
    }
   ,watch:
    {
        editado:function(){
            this.$emit('listar');
        }
    }
}
</script>

<style>

</style>