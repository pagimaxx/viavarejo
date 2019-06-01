using System;
using System.Collections.Generic;
using ViaVarejo.Domain.Entities.Domain;

namespace ViaVarejo.Domain.Interfaces.Repositories
{
    public interface IHistoricoStatusRepository
    {
        IEnumerable<HistoricoStatus> ObterTodos();
        IEnumerable<HistoricoStatus> ObterPorIdPedido(int id);
        IEnumerable<HistoricoStatus> ObterPorIdStatus(int id);
        IEnumerable<HistoricoStatus> ObterPorDataStatus(DateTime dtInicial, DateTime dtFinal);
        int Cadastrar(HistoricoStatus entity);
        bool Atualizar(HistoricoStatus entity);
        bool Remover(int id);
    }
}
