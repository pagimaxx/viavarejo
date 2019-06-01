using ViaVarejo.Infrastructure.CrossCutting.Utilities.Extension;

namespace ViaVarejo.Domain.Entities.Domain
{
    [SqlFilter(SequenceName = "")]
    public class ItemPedido : BaseDominio
    {
        public int IdPedido { get; set; }
        public int IdProduto { get; set; }
        public double PrecoVenda { get; set; }
        public virtual Produto Produto { get; set; }
    }
}
