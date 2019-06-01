using System;
using System.Collections.Generic;
using System.Linq;
using System.Transactions;
using ViaVarejo.Domain.Entities.Domain;
using ViaVarejo.Domain.Interfaces.Repositories;
using ViaVarejo.Domain.Interfaces.Services;

namespace ViaVarejo.Domain.Services
{
    public class StatusPedidoService : IStatusPedidoService
    {
        private readonly IStatusPedidoRepository _statusPedidoRepository;

        public StatusPedidoService(IStatusPedidoRepository statusPedidoRepository)
        {
            _statusPedidoRepository = statusPedidoRepository;
        }

        public bool Atualizar(StatusPedido statusPedido)
        {
            using (var scope = new TransactionScope())
            {
                var lista = _statusPedidoRepository.ObterPorTexto(statusPedido.Nome);

                if (lista.Any(l => l.IdStatus == statusPedido.IdStatus))
                    return true;

                else if (lista.Any(l => l.Nome != statusPedido.Nome))
                    throw new Exception("Nome já cadastrado");
                else
                {
                    var result = false;
                    result = _statusPedidoRepository.Atualizar(statusPedido);

                    if (!result)
                        throw new Exception("Ocorreu um erro ao atualizar o status pedido");

                    scope.Complete();
                    return result;
                }
            }
        }

        public int Cadastrar(StatusPedido statusPedido)
        {
            using (var scope = new TransactionScope())
            {
                if (_statusPedidoRepository.ObterPorTexto(statusPedido.Nome).Any())
                    throw new Exception("Nome já cadastrado");
                statusPedido.DataCadastro = DateTime.Now;
                var identificador = _statusPedidoRepository.Cadastrar(statusPedido);
                scope.Complete();
                return identificador;
            }
        }

        public StatusPedido ObterPorId(int idStatus)
        {
            return _statusPedidoRepository.ObterPorId(idStatus);
        }

        public IEnumerable<StatusPedido> ObterPorTexto(string texto)
        {
            return _statusPedidoRepository.ObterPorTexto(texto);
        }

        public IEnumerable<StatusPedido> ObterTodos()
        {
            return _statusPedidoRepository.ObterTodos();
        }

        public bool Remover(int idStatus)
        {
            using (var scope = new TransactionScope())
            {
                return _statusPedidoRepository.Remover(idStatus);
            }
        }
    }
}
