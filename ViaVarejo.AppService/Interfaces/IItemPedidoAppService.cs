using System.Collections.Generic;
using ViaVarejo.AppService.ViewModels.Alteracao;
using ViaVarejo.AppService.ViewModels.Consulta;
using ViaVarejo.AppService.ViewModels.Inclusao;
using System;

namespace ViaVarejo.AppService.Interfaces
{
    public interface IItemPedidoAppService
    {
        ItemPedidoConsultaVM ObterPorId(int id);
        IEnumerable<ItemPedidoConsultaVM> ObterTodos();
        IEnumerable<ItemPedidoConsultaVM> ObterPorIdPedido(int id);
        IEnumerable<ItemPedidoConsultaVM> ObterPorIdProduto(int id);
        IEnumerable<ItemPedidoConsultaVM> ObterPorPrecoVenda(double valor1, double valor2);
        string Cadastrar(ItemPedidoInclusaoVM vm, int idUsuario);
        string Atualizar(ItemPedidoAlteracaoVM vm, int idUsuario);
        bool Remover(int id);
    }
}
