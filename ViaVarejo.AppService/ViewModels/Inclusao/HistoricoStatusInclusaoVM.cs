using System;
using System.ComponentModel.DataAnnotations;
using ViaVarejo.Domain.Entities.Domain;

namespace ViaVarejo.AppService.ViewModels.Inclusao
{
    public class HistoricoStatusInclusaoVM
    {
        /// <summary>
        /// Id Status
        /// </summary>
        [Display(Name = "Código do Status")]
        public int IdStatus { get; set; }

        /// <summary>
        /// Data do status
        /// </summary>
        [Display(Name = "Data do status")]
        public DateTime DataStatus { get; set; }

        /// <summary>
        /// IdPedido
        /// </summary>
        [Display(Name = "Código do Pedido")]
        public Pedido Pedido { get; set; }

        /// <summary>
        /// IdPedido
        /// </summary>
        [Display(Name = "Código do Pedido")]
        public StatusPedido StatusPedido { get; set; }
    }
}
