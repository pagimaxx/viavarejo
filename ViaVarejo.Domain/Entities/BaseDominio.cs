using System;

namespace ViaVarejo.Domain.Entities
{
    public class BaseDominio
    {
        public int? IdUsuarioCadastro { get; set; }
        public int? IdUsuarioAlteracao { get; set; }
        public DateTime? DataCadastro { get; set; }
        public DateTime? DataAlteracao { get; set; }
    }
}
