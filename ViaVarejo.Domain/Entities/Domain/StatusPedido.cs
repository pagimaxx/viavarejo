using System.ComponentModel.DataAnnotations;
using ViaVarejo.Infrastructure.CrossCutting.Utilities.Extension;

namespace ViaVarejo.Domain.Entities.Domain
{
    [SqlFilter(SequenceName = "")]
    public class StatusPedido : BaseDominio
    {
        [Key]
        public int IdStatus { get; set; }

        [Display(Name = "Nome")]
        [StringLength(100)]
        public string Nome { get; set; }

        [Display(Name = "Ordem")]
        public int Ordem { get; set; }

    }
}
