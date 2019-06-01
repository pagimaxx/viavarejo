﻿using System.ComponentModel.DataAnnotations;
using ViaVarejo.Domain.Entities.Domain;

namespace ViaVarejo.AppService.ViewModels.Inclusao
{
    public class PedidoInclusaoVM
    {
        public int IdPedido { get; set; }

        /// <summary>
        /// IdStatus do Pedido
        /// </summary>
        public int IdStatus { get; set; }

        /// <summary>
        /// Valor do pedido
        /// </summary>
        [Display(Name = "Valor Pedido")]
        public double ValorPedido { get; set; }

        /// <summary>
        /// Data da previsão de entrega
        /// </summary>
        [Display(Name = "Data Previsão Entrega")]
        public System.DateTime DataPrevisaoEntrega { get; set; }

        /// <summary>
        /// Status do pedido tabela anexada
        /// </summary>
        public virtual StatusPedido StatusPedido { get; set; }

        /// <summary>
        /// Item do pedido
        /// </summary>
        public virtual ItemPedido ItemPedido { get; set; }

    }
}
