using System.ComponentModel.DataAnnotations;
using ViaVarejo.Infrastructure.CrossCutting.Utilities.Extension;

namespace ViaVarejo.Domain.Entities.Domain
{
    [SqlFilter(SequenceName = "")]
    public class Produto : BaseDominio
    {
        [Key]
        public int IdProduto { get; set; }

        [Display(Name = "Nome")]
        [StringLength(100)]
        public string Nome { get; set; }

        [Display(Name = "Preço Venda")]
        public double PrecoVenda { get; set; }
    }
}
