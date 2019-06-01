using System;
using System.Collections.Generic;
using ViaVarejo.Domain.Entities.Domain;

namespace ViaVarejo.Domain.Interfaces.Services
{
    public interface IItemPedidoService
    {
        IEnumerable<ItemPedido> ObterTodos();
        IEnumerable<ItemPedido> ObterPorIdPedido(int id);
        IEnumerable<ItemPedido> ObterPorIdProduto(int id);
        IEnumerable<ItemPedido> ObterPorPrecoVenda(double valor1, double valor2);
        int Cadastrar(ItemPedido entity);
        bool Atualizar(ItemPedido entity);
        bool Remover(int id);
    }
}
