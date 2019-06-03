<template>

    <div>
    
        <div class="row">

            <div class="col-12">
                <card :title="info.title" :subTitle="info.subTitle">
                    
                    <table class="table">
                        <tr>  
                            <th>Pedido</th>
                            <th>Status</th>
                            <th>Ações</th>
                        </tr>
                        <tr v-for="item in lista" :key="item.IdPedido">
                            <td>{{item.idPedido}}</td>
                            <td><b>{{item.statusPedido.nome}}</b></td>
                            <td>
                                <p-button type="info" icon @click.native="handleDetail(item.idPedido)">
                                    <i class="ti ti-pencil-alt"></i>
                                </p-button>
                            </td>
                        </tr>
                    </table>
                </card>
            </div>

        </div>
        

    </div>
</template>
<script>
import { PaperTable } from "@/components";

export default {
  components: {
    PaperTable
  },
  data() {
    return {
      info: {
        title: "Pedidos",
        subTitle: "Lista dos Pedidos",
      },
      url: 'http://localhost:5000/historico-status/obter-todos-agrupados',
      response: null,
      lista: [],
      error: null
    };
  },
  methods: {
    callPedidos () {
      this.$http.get(`${this.url}`)
        .then(response => {
          this.lista = response.data.resultado
        })
        .catch(error => {
          console.log('error', error.response)
          this.error = error.response.statusText
        })
    },
    handleDetail(id) {
      console.log(id);
      this.$router.push(`/pedidos-detalhes/${id}`);
    }
  },
  mounted () {
    this.callPedidos()
  }
};
</script>
<style>
</style>
