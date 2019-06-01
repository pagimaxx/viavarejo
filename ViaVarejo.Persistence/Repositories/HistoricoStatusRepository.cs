using Microsoft.Extensions.Options;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using ViaVarejo.Domain.Entities.Domain;
using ViaVarejo.Domain.Interfaces.Repositories;
using ViaVarejo.Infrastructure.CrossCutting.Enums;
using ViaVarejo.Infrastructure.CrossCutting.Utilities;
using ViaVarejo.Persistence.Connection;

namespace ViaVarejo.Persistence.Repositories
{
    public class HistoricoStatusRepository : BaseConnection, IHistoricoStatusRepository
    {
        private readonly IOptions<KeysConfig> _iChaveConfiguracao;
        private DataBaseType DataBaseType;

        public HistoricoStatusRepository(IConnectionDB connection, IOptions<KeysConfig> chaveConfiguracao) : base(connection)
        {
            _iChaveConfiguracao = chaveConfiguracao;
            DataBaseType = (DataBaseType)Enum.Parse(typeof(DataBaseType), _iChaveConfiguracao.Value.TypeDB, true);
        }

        public bool Atualizar(HistoricoStatus entity)
        {
            try
            {
                const string query =
                         @"UPDATE HistoricoStatus
                              SET IdStatus = :IdStatus,
                                  DataStatus = :DataStatus
                            WHERE IdPedido = :IdPedido";
                var parametros = new
                {
                    entity.IdPedido,
                    entity.IdStatus,
                    entity.DataStatus
                };

                var resultado = IDbConn.CommandExecute(query, DataBaseType, parametros);

                return resultado > 0;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public int Cadastrar(HistoricoStatus entity)
        {
            try
            {
                const string query =
                        @"INSERT INTO HistoricoStatus (IdPedido, IdStatus, DataStatus) 
                          VALUES (:IdPedido, :IdStatus, :DataStatus)";

                var parametros = new
                {
                    entity.IdPedido,
                    entity.IdStatus,
                    entity.DataStatus
                };

                string sequenceName = null;

                if (DataBaseType == DataBaseType.Oracle)
                    sequenceName = SequenceHelper.GetSequenceName<HistoricoStatus>(entity);

                return Convert.ToInt32(IDbConn.CommandInsert(query, DataBaseType, parametros, sequenceName: sequenceName));
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public IEnumerable<HistoricoStatus> ObterPorDataStatus(DateTime dtInicial, DateTime dtFinal)
        {
            try
            {
                const string query = @"EXEC ConsultarHistoricoPedido null, null, :dtInicial, :dtFinal";
                var parametro = new { dtInicial, dtFinal };
                return IDbConn.CommandQuery<HistoricoStatus, StatusPedido, HistoricoStatus>(query,
                    (historico, status) => {
                        historico.StatusPedido = status;
                        return historico;
                    },
                    DataBaseType, parametro, splitOn: "IdStatus").ToList();


            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public IEnumerable<HistoricoStatus> ObterPorIdPedido(int id)
        {
            const string query = @"EXEC ConsultarHistoricoPedido :id, null";
            var parametro = new { id };
            return IDbConn.CommandQuery<HistoricoStatus, StatusPedido, HistoricoStatus>(query,
                (historico, status) => {
                    historico.StatusPedido = status;
                    return historico;
                },
                DataBaseType, parametro, splitOn: "IdStatus").ToList();
        }

        public IEnumerable<HistoricoStatus> ObterPorIdStatus(int id)
        {
            const string query = @"EXEC ConsultarHistoricoPedido null, :id";
            var parametro = new { id };
            return IDbConn.CommandQuery<HistoricoStatus, StatusPedido, HistoricoStatus>(query,
                (historico, status) => {
                    historico.StatusPedido = status;
                    return historico;
                },
                DataBaseType, parametro, splitOn: "IdStatus").ToList();
        }

        public IEnumerable<HistoricoStatus> ObterTodos()
        {
            const string query = @"EXEC ConsultarHistoricoPedido null, null";
            return IDbConn.CommandQuery<HistoricoStatus, StatusPedido, HistoricoStatus>(query,
                (historico, status) => {
                    historico.StatusPedido = status;
                    return historico;
                },
                DataBaseType, splitOn: "IdStatus").ToList();
        }

        public bool Remover(int id)
        {
            try
            {
                var query = @"DELETE FROM Pedidos
                           WHERE IdPedido = :id";

                var resultado = IDbConn.CommandExecute(query, DataBaseType, new
                {
                    id
                });

                return resultado > 0;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}
