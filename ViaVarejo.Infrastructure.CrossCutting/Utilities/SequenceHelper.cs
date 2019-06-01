using System.Linq;
using ViaVarejo.Infrastructure.CrossCutting.Utilities.Extension;

namespace ViaVarejo.Infrastructure.CrossCutting.Utilities
{
    public static class SequenceHelper
    {
        public static string GetSequenceName<T>(T entity)
        {
            return ((SqlFilter)entity.GetType().GetCustomAttributes(typeof(SqlFilter), true).First()).SequenceName;
        }
    }
}
