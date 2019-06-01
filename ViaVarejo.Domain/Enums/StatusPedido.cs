using System;
using System.Collections.Generic;
using System.Text;

namespace ViaVarejo.Domain.Enums
{
    public enum StatusPedido
    {
        PedidoCriado = 1,
        AnaliseCredito = 2,
        PagamentoAprovado = 3,
        PagamentoRecusado = 4,
        SeparacaoEstoque = 5,
        EmRotaEntrega = 6,
        Entregue = 7,
        Cancelado = 8
    }
}
