using System;
using ViaVarejo.Infrastructure.CrossCutting.Utilities.Extension;

namespace ViaVarejo.Domain.Entities.Domain
{
    [SqlFilter(SequenceName = "")]
    public class HistoricoStatus : BaseDominio
    {
        public int IdPedido { get; set; }
        public int IdStatus { get; set; }
        public DateTime DataStatus { get; set; }
        public StatusPedido StatusPedido { get; set; }
        public Pedido Pedido { get; set; }
    }
}
