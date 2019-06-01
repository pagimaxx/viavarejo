using System;
using System.Collections.Generic;
using System.Linq;
using System.Transactions;
using ViaVarejo.Domain.Entities.Domain;
using ViaVarejo.Domain.Interfaces.Repositories;
using ViaVarejo.Domain.Interfaces.Services;

namespace ViaVarejo.Domain.Services
{
    public class PedidoService : IPedidoService
    {
        private readonly IPedidoRepository _repository;

        public PedidoService(IPedidoRepository repository)
        {
            _repository = repository;
        }

        public bool Atualizar(Pedido entity)
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

        public int Cadastrar(Pedido entity)
        {
            using (var scope = new TransactionScope())
            {
                entity.DataCadastro = DateTime.Now;
                var identificador = _repository.Cadastrar(entity);
                scope.Complete();
                return identificador;
            }
        }

        public Pedido ObterPorId(int id) =>
            _repository.ObterPorId(id);

        public IEnumerable<Pedido> ObterPorStatus(int status) =>
            _repository.ObterPorStatus(status);

        public IEnumerable<Pedido> ObterPorValorPedido(double valor1, double valor2) =>
            _repository.ObterPorValorPedido(valor1, valor2);

        public IEnumerable<Pedido> ObterPorDataPrevisaoEntrega(DateTime dataInicial, DateTime dataFinal) =>
            _repository.ObterPorDataPrevisaoEntrega(dataInicial, dataFinal);

        public IEnumerable<Pedido> ObterTodos() =>
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
