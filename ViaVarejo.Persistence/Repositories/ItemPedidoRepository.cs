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
    public class ItemPedidoRepository : BaseConnection, IItemPedidoRepository
    {
        private readonly IOptions<KeysConfig> _iChaveConfiguracao;
        private DataBaseType DataBaseType;

        public ItemPedidoRepository(IConnectionDB connection, IOptions<KeysConfig> chaveConfiguracao) : base(connection)
        {
            _iChaveConfiguracao = chaveConfiguracao;
            DataBaseType = (DataBaseType)Enum.Parse(typeof(DataBaseType), _iChaveConfiguracao.Value.TypeDB, true);
        }

        public bool Atualizar(ItemPedido entity)
        {
            try
            {
                const string query =
                         @"UPDATE ItemPedido
                              SET IdStatus = :IdStatus,
                                  PrecoVenda = :PrecoVenda
                            WHERE IdPedido = :IdPedido";
                var parametros = new
                {
                    entity.IdPedido,
                    entity.IdProduto,
                    entity.PrecoVenda
                };

                var resultado = IDbConn.CommandExecute(query, DataBaseType, parametros);

                return resultado > 0;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public int Cadastrar(ItemPedido entity)
        {
            const string query =
                        @"INSERT INTO ItemPedido (IdPedido, IdProduto, PrecoVenda) 
                          VALUES (:IdPedido, :IdProduto, :PrecoVenda)";

            var parametros = new
            {
                entity.IdPedido,
                entity.IdProduto,
                entity.PrecoVenda
            };

            string sequenceName = null;

            if (DataBaseType == DataBaseType.Oracle)
                sequenceName = SequenceHelper.GetSequenceName<ItemPedido>(entity);

            return Convert.ToInt32(IDbConn.CommandInsert(query, DataBaseType, parametros, sequenceName: sequenceName));
        }

        public IEnumerable<ItemPedido> ObterPorIdPedido(int id)
        {
            try
            {
                const string query = @"
                    SELECT item.IdPedido, item.IdProduto, item.PrecoVenda, 
                           prod.IdProduto, prod.Nome, prod.PrecoVenda
                      FROM ItemPedido item 
                           LEFT JOIN Produtos prod ON prod.IdProduto = item.IdProduto
                     WHERE item.idPedido = :id";
                var parametro = new { id };
                return IDbConn.CommandQuery<ItemPedido, Produto, ItemPedido>(query,
                    (itemPedido, produto) => {
                        itemPedido.Produto = produto;
                        return itemPedido;
                    }, DataBaseType, parametro, splitOn: "IdPedido").ToList();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public IEnumerable<ItemPedido> ObterPorIdProduto(int id)
        {
            try
            {
                const string query = @"
                    SELECT item.IdPedido, item.IdProduto, item.PrecoVenda, 
                           prod.IdProduto, prod.Nome, prod.PrecoVenda
                      FROM ItemPedido item 
                           LEFT JOIN Produtos prod ON prod.IdProduto = item.IdProduto
                     WHERE item.idProduto = :id";
                var parametro = new { id };
                return IDbConn.CommandQuery<ItemPedido, Produto, ItemPedido>(query,
                    (itemPedido, produto) => {
                        itemPedido.Produto = produto;
                        return itemPedido;
                    }, DataBaseType, parametro, splitOn: "IdProduto").ToList();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public IEnumerable<ItemPedido> ObterPorPrecoVenda(double valor1, double valor2)
        {
            try
            {
                const string query = @"
                    SELECT item.IdPedido, item.IdProduto, item.PrecoVenda, 
                           prod.IdProduto, prod.Nome, prod.PrecoVenda
                      FROM ItemPedido item 
                           LEFT JOIN Produtos prod ON prod.IdProduto = item.IdProduto
                     WHERE item.PrecoVenda BETWEEN :valor1 AND :valor2";
                var parametro = new { valor1, valor2 };
                return IDbConn.CommandQuery<ItemPedido, Produto, ItemPedido>(query,
                    (itemPedido, produto) => {
                        itemPedido.Produto = produto;
                        return itemPedido;
                    }, DataBaseType, parametro, splitOn: "IdProduto").ToList();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public IEnumerable<ItemPedido> ObterTodos()
        {
            try
            {
                const string query = @"
                    SELECT item.IdPedido, item.IdProduto, item.PrecoVenda, 
                           prod.IdProduto, prod.Nome, prod.PrecoVenda
                      FROM ItemPedido item 
                           LEFT JOIN Produtos prod ON prod.IdProduto = item.IdProduto";
                return IDbConn.CommandQuery<ItemPedido, Produto, ItemPedido>(query,
                    (itemPedido, produto) => {
                        itemPedido.Produto = produto;
                        return itemPedido;
                    }, DataBaseType, splitOn: "IdProduto").ToList();
            }
            catch (Exception ex)
            {
                throw ex;
            }
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
