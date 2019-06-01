using System.ComponentModel.DataAnnotations;

namespace ViaVarejo.AppService.ViewModels.Inclusao
{
    public class ProdutoInclusaoVM
    {
        /// <summary>
        /// Nome
        /// </summary>
        [StringLength(100, ErrorMessage = "Tamanho não Permitido")]
        public string Nome { get; set; }

        /// <summary>
        /// Preço Venda
        /// </summary>
        public double PrecoVenda { get; set; }
    }
}
