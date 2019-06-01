using System;
using System.Collections.Generic;
using System.Linq;
using System.Transactions;
using ViaVarejo.Domain.Entities.Domain;
using ViaVarejo.Domain.Interfaces.Repositories;
using ViaVarejo.Domain.Interfaces.Services;

namespace ViaVarejo.Domain.Services
{
    public class ProdutoService : IProdutoService
    {
        private readonly IProdutoRepository _produtoRepository;

        public ProdutoService(IProdutoRepository produtoRepository)
        {
            _produtoRepository = produtoRepository;
        }

        public bool Atualizar(Produto produto)
        {
            using (var scope = new TransactionScope())
            {
                var lista = _produtoRepository.ObterPorTexto(produto.Nome);

                if (lista.Any(l => l.IdProduto == produto.IdProduto))
                    return true;

                else if (lista.Any(l => l.Nome != produto.Nome))
                    throw new Exception("Nome já cadastrado");
                else
                {
                    var result = false;
                    result = _produtoRepository.Atualizar(produto);

                    if (!result)
                        throw new Exception("Ocorreu um erro ao atualizar o produto");

                    scope.Complete();
                    return result;
                }
            }
        }

        public int Cadastrar(Produto produto)
        {
            using (var scope = new TransactionScope())
            {
                if (_produtoRepository.ObterPorTexto(produto.Nome).Any())
                    throw new Exception("Nome já cadastrado");
                produto.DataCadastro = DateTime.Now;
                var identificador = _produtoRepository.Cadastrar(produto);
                scope.Complete();
                return identificador;
            }
        }

        public Produto ObterPorId(int idProduto) => 
            _produtoRepository.ObterPorId(idProduto);

        public IEnumerable<Produto> ObterPorTexto(string texto) =>
            _produtoRepository.ObterPorTexto(texto);

        public IEnumerable<Produto> ObterTodos() =>
            _produtoRepository.ObterTodos();

        public bool Remover(int idProduto)
        {
            using (var scope = new TransactionScope())
            {
                return _produtoRepository.Remover(idProduto);
            }
        }
    }
}
