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
    public class ProdutoRepository : BaseConnection, IProdutoRepository
    {
        private readonly IOptions<KeysConfig> _iChaveConfiguracao;
        private DataBaseType DataBaseType;

        public ProdutoRepository(IConnectionDB connection, IOptions<KeysConfig> chaveConfiguracao) : base(connection)
        {
            _iChaveConfiguracao = chaveConfiguracao;
            DataBaseType = (DataBaseType)Enum.Parse(typeof(DataBaseType), _iChaveConfiguracao.Value.TypeDB, true);
        }

        public bool Atualizar(Produto entity)
        {
            try
            {
                const string query =
                         @"UPDATE Produtos
                              SET Nome = :Nome,
                                  PrecoVenda = :PrecoVenda
                            WHERE IdProduto = :IdProduto";
                var parametros = new
                {
                    entity.IdProduto,
                    entity.Nome,
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

        public int Cadastrar(Produto entity)
        {
            try
            {
                const string query =
                        @"INSERT INTO Produtos (Nome, PrecoVenda) 
                          VALUES (:Nome, :PrecoVenda)";

                var parametros = new
                {
                    entity.Nome,
                    entity.PrecoVenda
                };

                string sequenceName = null;

                if (DataBaseType == DataBaseType.Oracle)
                    sequenceName = SequenceHelper.GetSequenceName<Produto>(entity);

                return Convert.ToInt32(IDbConn.CommandInsert(query, DataBaseType, parametros, sequenceName: sequenceName));
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public Produto ObterPorId(int idProduto)
        {
            try
            {
                const string query = @"SELECT * FROM Produtos WHERE idProduto = :idProduto ORDER BY Nome";
                return IDbConn.CommandQuery<Produto>(query, DataBaseType, new { idProduto }).FirstOrDefault();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public IEnumerable<Produto> ObterPorTexto(string nome)
        {
            try
            {
                const string query = @"SELECT * FROM Produtos WHERE Nome LIKE :nome ORDER BY Nome";
                var parametro = new { nome = "%" + nome + "%" };
                return IDbConn.CommandQuery<Produto>(query, DataBaseType, parametro).ToList();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public IEnumerable<Produto> ObterTodos()
        {
            try
            {
                const string query = @"SELECT * FROM Produtos ORDER BY Nome";
                return IDbConn.CommandQuery<Produto>(query, DataBaseType).ToList();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public bool Remover(int idProduto)
        {
            try
            {
                var query = @"DELETE FROM Produtos
                           WHERE IdProduto = :idProduto";

                var resultado = IDbConn.CommandExecute(query, DataBaseType, new
                {
                    idProduto
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
