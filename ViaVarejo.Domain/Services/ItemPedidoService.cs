using System;
using System.Collections.Generic;
using System.Linq;
using System.Transactions;
using ViaVarejo.Domain.Entities.Domain;
using ViaVarejo.Domain.Interfaces.Repositories;
using ViaVarejo.Domain.Interfaces.Services;

namespace ViaVarejo.Domain.Services
{
    public class ItemPedidoService : IItemPedidoRepository
    {
        private readonly IItemPedidoRepository _repository;

        public ItemPedidoService(IItemPedidoRepository repository)
        {
            _repository = repository;
        }

        public bool Atualizar(ItemPedido entity)
        {
            using (var scope = new TransactionScope())
            {
                var result = false;
                result = _repository.Atualizar(entity);

                if (!result)
                    throw new Exception("Ocorreu um erro ao atualizar");

                scope.Complete();
                return result;
            }
        }

        public int Cadastrar(ItemPedido entity)
        {
            using (var scope = new TransactionScope())
            {
                entity.DataCadastro = DateTime.Now;
                var identificador = _repository.Cadastrar(entity);
                scope.Complete();
                return identificador;
            }
        }

        public IEnumerable<ItemPedido> ObterPorIdPedido(int id) =>
            _repository.ObterPorIdPedido(id);

        public IEnumerable<ItemPedido> ObterPorIdProduto(int id) => 
            _repository.ObterPorIdProduto(id);

        public IEnumerable<ItemPedido> ObterPorPrecoVenda(double valor1, double valor2) =>
            _repository.ObterPorPrecoVenda(valor1, valor2);

        public IEnumerable<ItemPedido> ObterTodos() =>
            _repository.ObterTodos();

        public bool Remover(int id)
        {
            using (var scope = new TransactionScope())
            {
                return _repository.Remover(id);
            }
        }
    }
}
