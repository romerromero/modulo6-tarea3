<template>
  <div>
    <!-- Button trigger modal -->
        <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#exampleModal">
            <i class="fa fa-plus">                
            </i>
            Registrar Materia
        </button>
        <br> <br>
        <!-- Modal -->
        <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="exampleModalLabel">Registrar Materia</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form action="" @submit.prevent="agregarMateria()">
                    <div class="form-group">
                        <label for="sigla" class="control-label">Sigla:</label>
                        <input type="text" name="sigla" id="sigla" v-model="materia.sigla" class="form-control input-sm" placeholder="Sigla de la materia">
                    </div>
                    <div class="form-group">
                        <label for="nombre" class="control-label">Nombre:</label>
                        <input type="text" name="sigla" id="sigla" v-model="materia.nombre" class="form-control input-sm" placeholder="Nombre de la materia">
                    </div>
            <div class="modal-footer">
                <button type="submit" class="btn btn-primary"><i class="fa fa-save"></i> Guardar</button>
                <button type="button" class="btn btn-secondary" id="cancelar" data-bs-dismiss="modal"><i class="fa fa-times"></i> Cerrar</button>
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
    name:'crearMateria',
    props:['registrar'],
    data(){
        return{
            materia:{
                sigla: null,
                nombre: null,
                enplanestudio: false                
            },registrado:false
        }
    },
    methods:{
        agregarMateria(){
            if(this.materia.sigla != null && this.materia.nombre != null){
                axios({
                    method: "post",
                    url:  process.env.VUE_APP_RUTA_API + "/materias",
                    data: this.materia

                })
                .then(response =>{
                console.log(response);
                this.materia.sigla = null;
                this.materia.nombre = null;
                this.registrado=!this.registrado;
                document.getElementById('cancelar').click();
                })
                .catch(e => console.log(e));
            } else {
                this.$swal({
                title:"Materia",
                text:'Campos requeridos',
                icon:'error'
               })
            }
        }
    },watch:
    {
        registrado:function(){
            this.$emit('listar');
        }
    }
}
</script>

<style>

</style>