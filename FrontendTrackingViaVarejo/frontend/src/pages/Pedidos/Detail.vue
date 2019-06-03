<template>

    <div>
    
        <div class="row">

            <div class="col-12">
                <card :title="`${infos.titleItens} #${infos.id}`" :subTitle="infos.subTitleItens">
                    
                    <table class="table">
                        <tr>  
                            <th>Item</th>
                            <th>Preço</th>
                        </tr>
                        <tr v-for="item in itensPedido" :key="item.idProduto">
                            <td>{{item.produto.nome}}</td>
                            <td>{{item.produto.precoVenda | formatCurrent}}</td>
                        </tr>
                    </table>
                </card>
            </div>

        </div>

        <div class="row">

            <div class="col-12">
                <card :title="`${infos.titleHistorico} #${infos.id}`" :subTitle="infos.subTitleHistorico">
                    <hr>
                    <h4>Estado da entrega: OK</h4>
                    <table class="table">
                        <tr>  
                            <th>Status</th>
                            <th>Data do Status</th>
                            <th>No prazo?</th>
                        </tr>
                        <tr v-for="item in status" :key="item.idPedido">
                            <td>{{item.nome}}</td>
                            <td>{{item.dataStatus | formatDate}}</td>
                            <td>
                                <span v-if="item.statusAtual === 'Atrasada'" class="badge badge-danger">Atrasada</span>
                                <span v-else class="badge badge-primary">No prazo</span>

                                <span v-if="item.statusAtual === 'Atrasada'">
                                    <button @click.native="forcarStatus(item.idPedido)" class="btn btn-primary btn-sm">Forçar atualização</button>
                                </span>
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
      infos: {
        titleItens: "Itens do Pedido",
        subTitleItens: "Lista de itens do pedido",
        titleHistorico: "Histórico do Pedido",
        subTitleHistorico: "Histórico de status da compra",
        id: 0
      },
      urlItens: 'http://localhost:5000/item-pedido/obter-por-pedido',
      urlHistorico: 'http://localhost:5000/historico-status/obter-por-pedido',
      urlStatus: 'http://localhost:5000/historico-status/obter-por-status-pedido',
      response: null,
      status: [],
      itensPedido: [],
      error: null
    };
  },
  methods: {
    callItensPedidos (id) {
        this.$http.get(`${this.urlItens}/?id=${id}`)
            .then(response => {
                console.log(response.data.resultado)
                this.itensPedido = response.data.resultado
            })
            .catch(error => {
                console.log('error', error.response)
                this.error = error.response.statusText
            })
    },

    callHistorico (id) {
        this.$http.get(`${this.urlHistorico}/?id=${id}`)
            .then(response => {
                console.log(response.data.resultado)
                this.status = response.data.resultado
            })
            .catch(error => {
                console.log('error', error.response)
                this.error = error.response.statusText
            })
    },

    callStatus (id) {
        this.$http.get(`${this.urlStatus}/?id=${id}`)
            .then(response => {
                console.log(response.data.resultado)
                this.status = response.data.resultado
            })
            .catch(error => {
                console.log('error', error.response)
                this.error = error.response.statusText
            })
    },
    forcarStatus(id) {
        console.log(id);
    }
  },
  mounted () {
    console.log(this.$route.params.id);
    if (this.$route.params.id != undefined && this.$route.params.id != 0) {
        this.infos.id = this.$route.params.id;
        this.callStatus(this.infos.id)
        this.callItensPedidos(this.infos.id)
        //this.callHistorico(this.infos.id)
    }
  }
};
</script>
<style>
</style>
