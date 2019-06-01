using System;
using System.Collections.Generic;
using System.Text;

namespace ViaVarejo.Domain.Entities
{
    public class Base
    {
        public int? IdUsuarioCadastro { get; set; }
        public int? IdUsuarioAlteracao { get; set; }
        public int? IdUsuarioExclusao { get; set; }
        public DateTime? DataCadastro { get; set; }
        public DateTime? DataAlteracao { get; set; }
        public DateTime? DataExclusao { get; set; }
    }
}
