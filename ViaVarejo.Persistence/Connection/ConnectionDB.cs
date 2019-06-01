using ViaVarejo.Infrastructure.CrossCutting.Enums;
using ViaVarejo.Infrastructure.CrossCutting.Utilities;
using Microsoft.Extensions.Options;
using Npgsql;
using Oracle.ManagedDataAccess.Client;
using System;
using System.Data;
using System.Data.SqlClient;

namespace ViaVarejo.Persistence.Connection
{
    public class ConnectionDB : IConnectionDB
    {
        private readonly IOptions<KeysConfig> ChaveConfiguracao;

        public IDbConnection IConn { get; private set; }

        public ConnectionDB(IOptions<KeysConfig> chaveConfiguracao)
        {
            ChaveConfiguracao = chaveConfiguracao;
        }

        private IDbConnection SelectConnection()
        {
            return new SqlConnection(ChaveConfiguracao.Value.ConnectionDB);
        }

        public IDbConnection OpenConnection()
        {
            IConn = SelectConnection();

            if (IConn != null && IConn.State != ConnectionState.Open)
            {
                IConn.Open();
            }

            return IConn;
        }

        public void CloseConnection()
        {
            if (IConn != null && IConn.State == ConnectionState.Open)
            {
                IConn.Close();
                IConn.Dispose();
            }
        }

        public void Dispose() =>
            CloseConnection();
    }
}
