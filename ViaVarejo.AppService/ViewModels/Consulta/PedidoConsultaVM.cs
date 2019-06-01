using System.Collections.Generic;
using ViaVarejo.Domain.Entities.Domain;

namespace ViaVarejo.AppService.ViewModels.Consulta
{
    public class PedidoConsultaVM
    {
        public int IdPedido { get; set; }
        public double ValorPedido { get; set; }
        public System.DateTime DataPrevisaoEntrega { get; set; }
        public virtual StatusPedido StatusPedido { get; set; }
        public virtual IEnumerable<ItemPedido> ItemPedido { get; set; }
    }
}
