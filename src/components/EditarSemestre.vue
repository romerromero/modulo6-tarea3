<template>
  <div>
    <!-- Button trigger modal -->
        <button type="button" class="btn btn-success btn-sm" data-bs-toggle="modal" :data-bs-target="`#editarSemestreModal${idSemestre}`"
        v-on:click="getSemestre()"
        >
            <i class="fa fa-pencil"  >                
            </i>
            Editar
        </button>
        <!-- Modal -->
        <div class="modal fade" :id="`editarSemestreModal${idSemestre}`" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="exampleModalLabel">Editar Semestre</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form action="" @submit.prevent="editarSemestre()">
                    <div class="row">
                        <label for="nombre" class="control-label">Nombre:</label>
                        <input type="text" v-model="semestre.nombre"  class="form-control input-sm" placeholder="Nombre de Semestre">
                    </div>
                    <div class="modal-footer">
                        <button type="submit" class="btn btn-primary"><i class="fa fa-save"></i> Editar</button>
                        <button type="button" class="btn btn-secondary" :id="`cancelarSemestreModal${idSemestre}`" data-bs-dismiss="modal"><i class="fa fa-times"></i> Cerrar</button>
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
    name:'editarSemestre',
    props:['idSemestre','editar'],
    data(){
        return{
            semestre:{
                id: null,
                nombre: null
            },
            editado:false,
        }
    },
    methods:{
        editarSemestre(){
            if(this.semestre.nombre != null){
                axios({
                    method: "patch",
                    url:  process.env.VUE_APP_RUTA_API + "/semestres/" + this.idSemestre,
                    data: this.semestre
                })
                .then(response =>{
                this.editado=!this.editado;
                
                document.getElementById('cancelarSemestreModal'+this.idSemestre).click();
                })
                .catch(e => console.log(e));
            } else {
                this.$swal({
                title:"Semestre",
                text:'Nombre es requerido',
                icon:'error'
               })
            }
        },

        getSemestre(){
            axios({
                method: "get",
                url: process.env.VUE_APP_RUTA_API + '/semestres/' + this.idSemestre,
            })
            .then(response =>{
                this.semestre = response.data;
                this.semestre.nombre = response.data.nombre;
            })
            .catch(e => console.log(e))
        }
    },
    mounted(){
       this.getSemestre();
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