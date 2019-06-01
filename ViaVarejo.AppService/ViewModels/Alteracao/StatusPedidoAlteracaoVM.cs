using System;
using System.ComponentModel.DataAnnotations;

namespace ViaVarejo.AppService.ViewModels.Alteracao
{
    public class StatusPedidoAlteracaoVM
    {
        [Required]
        public int IdStatus { get; set; }

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
