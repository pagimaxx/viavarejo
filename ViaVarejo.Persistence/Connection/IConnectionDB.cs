using System;
using System.Data;

namespace ViaVarejo.Persistence.Connection
{
    public interface IConnectionDB : IDisposable
    {
        IDbConnection OpenConnection();
        void CloseConnection();
    }
}
