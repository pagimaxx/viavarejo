using System.ComponentModel;

namespace ViaVarejo.Infrastructure.CrossCutting.Enums
{
    public enum DataBaseType
    {
        [Description(nameof(Oracle))]
        Oracle = 0,
        [Description(nameof(SqlServer))]
        SqlServer = 1,
        [Description(nameof(PostgreSql))]
        PostgreSql = 2,
    }
}
