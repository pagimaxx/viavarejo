using System;
using System.Collections.Generic;
using ViaVarejo.Domain.Entities.Domain;

namespace ViaVarejo.Domain.Interfaces.Services
{
    public interface IHistoricoStatusService
    {
        IEnumerable<HistoricoStatus> ObterTodos();
        IEnumerable<HistoricoStatus> ObterTodosAgrupados();
        IEnumerable<HistoricoStatus> ObterPorIdPedido(int id);
        IEnumerable<HistoricoStatus> ObterPorIdStatus(int id);
        IEnumerable<HistoricoStatus> ObterPorDataStatus(DateTime dtInicial, DateTime dtFinal);
        int Cadastrar(HistoricoStatus entity);
        bool Atualizar(HistoricoStatus entity);
        bool Remover(int id);
    }
}
