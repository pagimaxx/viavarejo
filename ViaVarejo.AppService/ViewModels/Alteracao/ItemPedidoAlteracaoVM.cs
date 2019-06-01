using System.ComponentModel.DataAnnotations;
using ViaVarejo.Domain.Entities.Domain;

namespace ViaVarejo.AppService.ViewModels.Alteracao
{
    public class ItemPedidoAlteracaoVM
    {
        /// <summary>
        /// IdPedido
        /// </summary>
        [Display(Name = "Código do Pedido")]
        public int IdPedido { get; set; }

        /// <summary>
        /// IdPedido
        /// </summary>
        [Display(Name = "Código do Pedido")]
        public int IdProduto { get; set; }

        /// <summary>
        /// Preço da Venda
        /// </summary>
        [Display(Name = "Preço da Venda")]
        public double PrecoVenda { get; set; }

    }
}
