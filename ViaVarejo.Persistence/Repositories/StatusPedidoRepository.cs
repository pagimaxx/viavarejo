using Microsoft.Extensions.Options;
using Serilog;
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
    public class StatusPedidoRepository : BaseConnection, IStatusPedidoRepository
    {
        private readonly IOptions<KeysConfig> _iChaveConfiguracao;
        private DataBaseType DataBaseType;

        public StatusPedidoRepository(IConnectionDB connection, IOptions<KeysConfig> chaveConfiguracao) : base(connection)
        {
            _iChaveConfiguracao = chaveConfiguracao;
            DataBaseType = (DataBaseType)Enum.Parse(typeof(DataBaseType), _iChaveConfiguracao.Value.TypeDB, true);
        }

        public bool Atualizar(StatusPedido entity)
        {
            try
            {
                const string query =
                         @"UPDATE StatusPedido
                             SET 
                                Nome = :Nome,
                                Ordem = :Ordem
                           WHERE Id = :IdStatus";
                var parametros = new
                {
                    entity.IdStatus,
                    entity.Nome,
                    entity.Ordem
                };

                var resultado = IDbConn.CommandExecute(query, DataBaseType, parametros);

                return resultado > 0;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public int Cadastrar(StatusPedido entity)
        {
            try
            {
                const string query =
                        @"INSERT INTO StatusPedido (Nome, Ordem) 
                          VALUES (:Nome, :Ordem)";

                var parametros = new
                {
                    entity.Nome,
                    entity.Ordem
                };

                string sequenceName = null;

                if (DataBaseType == DataBaseType.Oracle)
                    sequenceName = SequenceHelper.GetSequenceName<StatusPedido>(entity);

                return Convert.ToInt32(IDbConn.CommandInsert(query, DataBaseType, parametros, sequenceName: sequenceName));
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public StatusPedido ObterPorId(int idStatus)
        {
            try
            {
                const string query = @"SELECT * FROM StatusPedido WHERE IdStatus = :idStatus ORDER BY Nome";
                return IDbConn.CommandQuery<StatusPedido>(query, DataBaseType, new { idStatus }).FirstOrDefault();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public IEnumerable<StatusPedido> ObterPorTexto(string nome)
        {
            try
            {
                const string query = @"SELECT * FROM StatusPedido WHERE Nome LIKE :nome ORDER BY Nome";
                var parametro = new { nome = "%" + nome + "%" };
                return IDbConn.CommandQuery<StatusPedido>(query, DataBaseType, parametro).ToList();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public IEnumerable<StatusPedido> ObterTodos()
        {
            try
            {
                const string query = @"SELECT * FROM StatusPedido ORDER BY Nome";
                return IDbConn.CommandQuery<StatusPedido>(query, DataBaseType).ToList();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public bool Remover(int idStatus)
        {
            try
            {
                var query = @"DELETE FROM StatusPedido
                           WHERE IdStatusPedido = :idUsuario";

                var resultado = IDbConn.CommandExecute(query, DataBaseType, new
                {
                    idStatus
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
