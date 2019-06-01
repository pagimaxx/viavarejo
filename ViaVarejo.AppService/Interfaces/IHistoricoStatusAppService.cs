using System.Collections.Generic;
using ViaVarejo.AppService.ViewModels.Alteracao;
using ViaVarejo.AppService.ViewModels.Consulta;
using ViaVarejo.AppService.ViewModels.Inclusao;
using System;

namespace ViaVarejo.AppService.Interfaces
{
    public interface IHistoricoStatusAppService
    {
        IEnumerable<HistoricoStatusConsultaVM> ObterTodos();
        IEnumerable<HistoricoStatusConsultaVM> ObterPorIdPedido(int id);
        IEnumerable<HistoricoStatusConsultaVM> ObterPorIdStatus(int id);
        IEnumerable<HistoricoStatusConsultaVM> ObterPorDataStatus(DateTime dtInicial, DateTime dtFinal);
        string Cadastrar(HistoricoStatusInclusaoVM vm, int idUsuario);
        string Atualizar(HistoricoStatusAlteracaoVM vm, int idUsuario);
        bool Remover(int id);
    }
}
