using System.ComponentModel.DataAnnotations;

namespace ViaVarejo.AppService.ViewModels.Inclusao
{
    public class StatusPedidoInclusaoVM
    {
        /// <summary>
        /// Nome
        /// </summary>
        [StringLength(100, ErrorMessage = "Tamanho não Permitido")]
        public string Nome { get; set; }

        /// <summary>
        /// Ordem
        /// </summary>
        public int Ordem { get; set; }
    }
}
