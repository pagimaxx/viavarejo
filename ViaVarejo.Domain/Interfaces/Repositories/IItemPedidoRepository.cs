using System;
using System.Collections.Generic;
using ViaVarejo.Domain.Entities.Domain;

namespace ViaVarejo.Domain.Interfaces.Repositories
{
    public interface IItemPedidoRepository
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
