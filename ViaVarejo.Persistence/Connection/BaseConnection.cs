﻿using System;
using System.Data;

namespace ViaVarejo.Persistence.Connection
{
    public class BaseConnection : IDisposable
    {
        public IDbConnection IDbConn;

        public BaseConnection(IConnectionDB _connection)
        {
            IDbConn = _connection.OpenConnection();
        }

        public void Dispose() =>
            IDbConn.Dispose();
    }
}
