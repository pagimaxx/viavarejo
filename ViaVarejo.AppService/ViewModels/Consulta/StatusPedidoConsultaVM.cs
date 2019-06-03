using System;
using System.Collections.Generic;
using System.Text;

namespace ViaVarejo.AppService.ViewModels.Consulta
{
    public class StatusPedidoConsultaVM
    {
        public int IdStatus { get; set; }

        /// <summary>
        /// Nome
        /// </summary>
        public string Nome { get; set; }

        /// <summary>
        /// Ordem
        /// </summary>
        public int Ordem { get; set; }

        /// <summary>
        /// Data Status
        /// </summary>
        public string DataStatus { get; set; }

        /// <summary>
        /// Status atual
        /// </summary>
        public string StatusAtual { get; set; }
    }
}
