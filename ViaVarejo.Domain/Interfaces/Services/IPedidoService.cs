using System;
using System.Collections.Generic;
using ViaVarejo.Domain.Entities.Domain;

namespace ViaVarejo.Domain.Interfaces.Services
{
    public interface IPedidoService
    {
        Pedido ObterPorId(int id);
        IEnumerable<Pedido> ObterTodos();
        IEnumerable<Pedido> ObterPorStatus(int texto);
        IEnumerable<Pedido> ObterPorValorPedido(double valor1, double valor2);
        IEnumerable<Pedido> ObterPorDataPrevisaoEntrega(DateTime dataInicial, DateTime dataFinal);
        int Cadastrar(Pedido entity);
        bool Atualizar(Pedido entity);
        bool Remover(int id);
    }
}
