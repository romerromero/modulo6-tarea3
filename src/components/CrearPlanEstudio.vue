<template>
  <div>
    <!-- Button trigger modal -->
        <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#exampleModal" @click.prevent="abrirModal()">
            <i class="fa fa-plus">                
            </i>
            Registrar Plan de Estudio
        </button>
        <br> <br>
        <!-- Modal -->
        <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="exampleModalLabel">Registrar Plan de Estudio</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form action="" @submit.prevent="agregarPlanEstudio()">
                    <div class="form-group">
                        <label for="semestre" class="control-label">Semestre:</label>
                        <select class="form-select" aria-label="Default select example" v-model="idSemestre">
                            <option value="null">Seleccionar</option>
                            <option v-for="(value) in semestres" :key="value.id" :value="value.id" >{{value.nombre}}</option>                
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="materia" class="control-label">Materia:</label>
                        <!-- <select class="form-select" aria-label="Default select example" @change="changeSemestre(value)" v-model="idSemestre">
                            <option value="null">Seleccionar Materia</option>
                            <option v-for="(value) in materias" :key="value.id" :value="value.id" >{{value.nombre}}</option>                
                        </select> -->
                        <table class="table">
                            <thead class="table-dark">
                                <tr>
                                <th scope="col">#</th>
                                
                                <th scope="col">Nombre de la Materia</th>
                                <th scope="col">Seleccione</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr v-for="(value,index) in materias" :key="value.id">
                                <th scope="row">{{index + 1}}</th>
                               
                                <td>{{ value.nombre}}</td>
                                <td>
                                    <div class="row">
                                    <div class="col-md-3 text-right">
                                       <input class="form-check-input mt-0" type="checkbox" v-model="value.enplanestudio"  aria-label="Checkbox for following text input">
                                    </div>                                    
                                </div>
                                    
                                    <!-- <button class="btn btn-sm btn-success m-1"><i class="fa fa-pencil"></i> Editar</button> -->
                                </td>
                            </tr>
                            </tbody>
                            </table>
                    </div>
            <div class="modal-footer">
                <button type="submit" class="btn btn-primary"><i class="fa fa-save"></i> Guardar</button>
                <button type="button" class="btn btn-secondary" id="cancelarmodalplanestudio" data-bs-dismiss="modal"><i class="fa fa-times"></i> Cerrar</button>
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
    name:'crearPlanEstudio',
    props:['registrar'],
    data(){        
        return{
            materias:[],
            semestres:[],
            registrado:false,
            planestudio: {}
        }
    },
    methods:{
        agregarPlanEstudio(){
            if(this.idSemestre != null){
                this.materias.forEach(element => {
                    if(element.enplanestudio==true){
                            this.planestudio={                        
                                totalHorasPractica: 100,
                                totalHorasTeorica: 50,
                                totalHorasLaboratorio: 30,                        
                                materiaId: element.id,
                                semestreId: this.idSemestre
                            }
                        
                        axios({
                            method: "post",
                            url: process.env.VUE_APP_RUTA_API+"/planestudios" ,
                            data: this.planestudio              
                        })
                        .then(response =>{
                        console.log(response);

                            axios({
                                method: "patch",
                                url:  process.env.VUE_APP_RUTA_API + "/materias/" + element.id,
                                data: {
                                    enplanestudio: true
                                }
                            })
                            .then(response =>{
                                console.log(response);
                            })
                            .catch(e => console.log(e));
                        })
                        .catch(e => console.log(e));
                    }
                });
                this.getMaterias();
                document.getElementById('cancelarmodalplanestudio').click();
                this.registrado=! this.registrado;
            }
            else {
                this.$swal({
                title:"Semestre",
                text:'Debe seleccionar un semestre',
                icon:'error'
               })
            }                
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
        getMaterias(){
            axios({
            method:"get",
            url: process.env.VUE_APP_RUTA_API + "/materias?enplanestudio=false",
            })
            .then(response =>{
            this.materias = response.data;
            })
            .catch(e => console.log(e));
        },
        abrirModal(){
            this.getSemestres();
            this.getMaterias();
        }
    },
    mounted(){
        console.log("Ingrea al mounted de Crer Plan Estudio")
        this.getSemestres();
        this.getMaterias();
    },
    watch:
    {
        registrado:function(){
            this.$emit('listar');
        }
    }
}
</script>

<style>

</style>