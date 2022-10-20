<template>
  <div>
    <!-- Button trigger modal -->
        <button type="button" class="btn btn-success btn-sm" data-bs-toggle="modal" :data-bs-target="`#editarmateriaModal${idMateria}`" 
        v-on:click="getMateria()"
        >
            <i class="fa fa-pencil"  >                
            </i>
            Editar
        </button>
        <!-- Modal -->
        <div class="modal fade" :id="`editarmateriaModal${idMateria}`" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="exampleModalLabel">Editar Materia</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form action="" @submit.prevent="editarMateria()">
                    <div class="row">
                        <label for="sigla" class="control-label">Sigla:</label>
                        <input type="text" v-model="materia.sigla"  class="form-control input-sm" placeholder="Sigla de la Materia">
                    </div>
                    <div class="row">
                        <label for="nombre" class="control-label">Nombre:</label>
                        <input type="text" v-model="materia.nombre"  class="form-control input-sm" placeholder="Nombre de la Materia">
                    </div>
                    <div class="modal-footer">
                        <button type="submit" class="btn btn-primary"><i class="fa fa-save"></i> Editar</button>
                        <button type="button" class="btn btn-secondary" :id="`cancelarmateriaModal${idMateria}`" data-bs-dismiss="modal"><i class="fa fa-times"></i> Cerrar</button>
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
    name:'editarMateria',
    props:['idMateria','editar'],
    data(){
        return{
            materia:{
                id: null,
                sigla: null,
                nombre: null,
                enplanestudio: false
            },
            editado:false,
        }
    },
    methods:{
        editarMateria(){
            if(this.materia.sigla != null && this.materia.nombre != null){
                axios({
                    method: "patch",
                    url:  process.env.VUE_APP_RUTA_API + "/materias/" + this.idMateria,
                    data: this.materia
                })
                .then(response =>{
                this.materia.sigla = null;
                this.materia.nombre = null;
                this.editado=!this.editado;
                
                document.getElementById('cancelarmateriaModal'+this.idMateria).click();
                })
                .catch(e => console.log(e));
            } else {
                this.$swal({
                title:"Materia",
                text:'Campos requerido',
                icon:'error'
               })
            }
        },

        getMateria(){
            axios({
                method: "get",
                url: process.env.VUE_APP_RUTA_API + '/materias/' + this.idMateria,
            })
            .then(response =>{
                this.materia = response.data;
            })
            .catch(e => console.log(e))
        }
    },
    mounted(){
       this.getMateria();
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