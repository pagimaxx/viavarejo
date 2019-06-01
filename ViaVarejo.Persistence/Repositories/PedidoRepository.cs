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
    public class PedidoRepository : BaseConnection, IPedidoRepository
    {
        private readonly IOptions<KeysConfig> _iChaveConfiguracao;
        private DataBaseType DataBaseType;

        public PedidoRepository(IConnectionDB connection, IOptions<KeysConfig> chaveConfiguracao) : base(connection)
        {
            _iChaveConfiguracao = chaveConfiguracao;
            DataBaseType = (DataBaseType)Enum.Parse(typeof(DataBaseType), _iChaveConfiguracao.Value.TypeDB, true);
        }

        public bool Atualizar(Pedido entity)
        {
            try
            {
                const string query =
                         @"UPDATE Pedido
                              SET IdStatus = :IdStatus,
                                  ValorPedido = :ValorPedido,
                                  DataPrevisaoEntrega = :DataPrevisaoEntrega
                            WHERE IdPedido = :IdPedido";
                var parametros = new
                {
                    entity.IdPedido,
                    entity.IdStatus,
                    entity.ValorPedido,
                    entity.DataPrevisaoEntrega
                };

                var resultado = IDbConn.CommandExecute(query, DataBaseType, parametros);

                return resultado > 0;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public int Cadastrar(Pedido entity)
        {
            try
            {
                const string query =
                        @"INSERT INTO Pedido (IdStatus, ValorPedido, ValorPedido) 
                          VALUES (:PrecoVenda, :ValorPedido, :ValorPedido)";

                var parametros = new
                {
                    entity.IdStatus,
                    entity.ValorPedido,
                    entity.DataPrevisaoEntrega
                };

                string sequenceName = null;

                if (DataBaseType == DataBaseType.Oracle)
                    sequenceName = SequenceHelper.GetSequenceName<Pedido>(entity);

                return Convert.ToInt32(IDbConn.CommandInsert(query, DataBaseType, parametros, sequenceName: sequenceName));
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public Pedido ObterPorId(int idPedido)
        {
            try
            {
                const string query = @"
                    SELECT ped.IdPedido, ped.ValorPedido, 
                           ped.DataPrevisaoEntrega, status.IdStatus, status.Nome,
                           itemPed.IdPedido, itemPed.IdProduto, itemPed.PrecoVenda
                      FROM Pedido ped 
                           LEFT JOIN StatusPedido status ON status.IdStatus = ped.IdStatus
                           LEFT JOIN ItemPedido itemPed ON itemPed.IdPedido = ped.IdPedido
                     WHERE ped.IdPedido = :idPedido";
                var parametro = new { idPedido };
                return IDbConn.CommandQuery<Pedido, StatusPedido, Pedido>(query,
                    (pedidos, statusPedido) => {
                        pedidos.StatusPedido = statusPedido;
                        return pedidos;
                    }, DataBaseType, parametro, splitOn: "IdStatus").FirstOrDefault();

                
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public IEnumerable<Pedido> ObterPorStatus(int status)
        {
            try
            {
                const string query = @"
                    SELECT P.IdPedido, P.IdStatus, P.ValorPedido, 
                           P.DataPrevisaoEntrega, SP.IdStatus, SP.Nome, 
                           SP.Ordem 
                      FROM Pedido P 
                           LEFT JOIN StatusPedido SP ON SP.IdStatus = P.IdStatus
                     WHERE P.IdStatus = :status
                  ORDER BY DataPrevisaoEntrega";
                var parametro = new { status };
                return IDbConn.CommandQuery<Pedido, StatusPedido, Pedido>(query,
                    (pedidos, statusPedido) => {
                        pedidos.StatusPedido = statusPedido;
                        return pedidos;
                    }, DataBaseType, parametro, splitOn: "IdStatus").ToList();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public IEnumerable<Pedido> ObterPorValorPedido(double valor1, double valor2)
        {
            try
            {
                const string query = @"
                    SELECT P.IdPedido, P.IdStatus, P.ValorPedido, 
                           P.DataPrevisaoEntrega, SP.IdStatus, SP.Nome, 
                           SP.Ordem 
                      FROM Pedido P 
                           LEFT JOIN StatusPedido SP ON SP.IdStatus = P.IdStatus
                     WHERE P.ValorPedido BETWEEN :valor1 AND :valor2
                  ORDER BY DataPrevisaoEntrega";
                var parametro = new { valor1, valor2 };
                return IDbConn.CommandQuery<Pedido, StatusPedido, Pedido>(query,
                    (pedidos, statusPedido) => {
                        pedidos.StatusPedido = statusPedido;
                        return pedidos;
                    }, DataBaseType, parametro, splitOn: "IdStatus").ToList();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public IEnumerable<Pedido> ObterPorDataPrevisaoEntrega(DateTime dataInicial, DateTime dataFinal)
        {
            try
            {
                const string query = @"
                    SELECT P.IdPedido, P.IdStatus, P.ValorPedido, 
                           P.DataPrevisaoEntrega, SP.IdStatus, SP.Nome, 
                           SP.Ordem 
                      FROM Pedido P 
                           LEFT JOIN StatusPedido SP ON SP.IdStatus = P.IdStatus
                     WHERE P.DataPrevisaoEntrega BETWEEN :dataInicial AND :dataFinal
                  ORDER BY DataPrevisaoEntrega";
                var parametro = new { dataInicial, dataFinal };
                return IDbConn.CommandQuery<Pedido, StatusPedido, Pedido>(query, 
                    (pedidos, statusPedido) => {
                        pedidos.StatusPedido = statusPedido;
                        return pedidos;
                    }, DataBaseType, parametro, splitOn: "IdStatus").ToList();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public IEnumerable<Pedido> ObterTodos()
        {
            try
            {
                const string query = @"
                    SELECT P.IdPedido, P.IdStatus, P.ValorPedido, 
                           P.DataPrevisaoEntrega, SP.IdStatus, SP.Nome, 
                           SP.Ordem 
                      FROM Pedido P 
                           LEFT JOIN StatusPedido SP ON SP.IdStatus = P.IdStatus
                  ORDER BY DataPrevisaoEntrega";
                return IDbConn.CommandQuery<Pedido, StatusPedido, Pedido>(query, (pedidos, status) => { pedidos.StatusPedido = status; return pedidos; }, DataBaseType, splitOn: "IdStatus").ToList();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public bool Remover(int idPedido)
        {
            try
            {
                var query = @"DELETE FROM Pedidos
                           WHERE IdPedido = :idPedido";

                var resultado = IDbConn.CommandExecute(query, DataBaseType, new
                {
                    idPedido
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
