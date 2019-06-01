using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using ViaVarejo.Infrastructure.CrossCutting.Utilities.Extension;

namespace ViaVarejo.Domain.Entities.Domain
{
    [SqlFilter(SequenceName = "")]
    public class Pedido : BaseDominio
    {
        [Key]
        public int IdPedido { get; set; }

        public int IdStatus { get; set; }

        [Display(Name = "Valor Pedido")]
        public double ValorPedido { get; set; }

        [Display(Name = "Data Previsão Entrega")]
        public DateTime DataPrevisaoEntrega { get; set; }

        public virtual StatusPedido StatusPedido { get; set; }

        public virtual IEnumerable<ItemPedido> ItemPedido { get; set; }

    }
}
