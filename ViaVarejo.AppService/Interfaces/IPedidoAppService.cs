using System.Collections.Generic;
using ViaVarejo.AppService.ViewModels.Alteracao;
using ViaVarejo.AppService.ViewModels.Consulta;
using ViaVarejo.AppService.ViewModels.Inclusao;
using System;

namespace ViaVarejo.AppService.Interfaces
{
    public interface IPedidoAppService
    {
        PedidoConsultaVM ObterPorId(int id);
        IEnumerable<PedidoConsultaVM> ObterTodos();
        IEnumerable<PedidoConsultaVM> ObterPorStatus(int status);
        IEnumerable<PedidoConsultaVM> ObterPorValorPedido(double valor1, double valor2);
        IEnumerable<PedidoConsultaVM> ObterPorDataPrevisaoEntrega(DateTime dataInicial, DateTime dataFinal);
        string Cadastrar(PedidoInclusaoVM vm, int idUsuario);
        string Atualizar(PedidoAlteracaoVM vm, int idUsuario);
        bool Remover(int id);
    }
}
