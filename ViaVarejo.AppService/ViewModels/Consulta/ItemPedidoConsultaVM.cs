using System.ComponentModel.DataAnnotations;
using ViaVarejo.Domain.Entities.Domain;

namespace ViaVarejo.AppService.ViewModels.Consulta
{
    public class ItemPedidoConsultaVM
    {
        public int IdPedido { get; set; }
        public int IdProduto { get; set; }
        public double PrecoVenda { get; set; }
        public virtual Produto Produto { get; set; }
    }
}
