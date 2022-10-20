<template>
  <div>
    <!-- Button trigger modal -->
        <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#exampleModal">
            <i class="fa fa-plus">                
            </i>
            Registrar Semestre
        </button>
        <br> <br>
        <!-- Modal -->
        <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="exampleModalLabel">Registrar Semestre</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form action="" @submit.prevent="agregarSemestre()">
                    <div class="row">
                        <label for="nombre" class="control-label">Nombre:</label>
                        <input type="text" name="nombre" id="nombre" v-model="semestre.nombre" class="form-control input-sm" placeholder="Nombre de Semestre">
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
    name:'crearSemestre',
    props:['registrar'],
    data(){
        return{
            semestre:{
                nombre: null,
                
            },registrado:false
        }
    },
    methods:{
        agregarSemestre(){
            if(this.semestre.nombre != null){

                axios({
                    method: "post",
                url:  process.env.VUE_APP_RUTA_API + "/semestres",
                data: this.semestre
                })
                .then(response =>{
                console.log(response);
                this.semestre.nombre = null;
                this.registrado=!this.registrado;
                document.getElementById('cancelar').click();
                })
                .catch(e => console.log(e));
            } else {
                this.$swal({
                title:"Semestre",
                text:'Nombre es requerido',
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