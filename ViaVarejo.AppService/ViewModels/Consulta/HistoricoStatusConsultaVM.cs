using System;
using ViaVarejo.Domain.Entities.Domain;

namespace ViaVarejo.AppService.ViewModels.Consulta
{
    public class HistoricoStatusConsultaVM
    {
        public int IdPedido { get; set; }
        public int IdStatus { get; set; }
        public DateTime DataStatus { get; set; }
        public StatusPedido StatusPedido { get; set; }
        public Pedido Pedido { get; set; }
    }
}
