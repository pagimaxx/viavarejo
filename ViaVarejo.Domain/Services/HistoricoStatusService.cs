using System;
using System.Collections.Generic;
using System.Linq;
using System.Transactions;
using ViaVarejo.Domain.Entities.Domain;
using ViaVarejo.Domain.Interfaces.Repositories;
using ViaVarejo.Domain.Interfaces.Services;

namespace ViaVarejo.Domain.Services
{
    public class HistoricoStatusService : IHistoricoStatusService
    {
        private readonly IHistoricoStatusRepository _repository;

        public HistoricoStatusService(IHistoricoStatusRepository repository)
        {
            _repository = repository;
        }

        public bool Atualizar(HistoricoStatus entity)
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

        public int Cadastrar(HistoricoStatus entity)
        {
            using (var scope = new TransactionScope())
            {
                entity.DataCadastro = DateTime.Now;
                var identificador = _repository.Cadastrar(entity);
                scope.Complete();
                return identificador;
            }
        }

        public IEnumerable<HistoricoStatus> ObterPorDataStatus(DateTime dtInicial, DateTime dtFinal) =>
            _repository.ObterPorDataStatus(dtInicial, dtFinal);

        public IEnumerable<HistoricoStatus> ObterPorIdPedido(int id) =>
            _repository.ObterPorIdPedido(id);

        public IEnumerable<HistoricoStatus> ObterPorIdStatus(int id) =>
            _repository.ObterPorIdStatus(id);

        public IEnumerable<HistoricoStatus> ObterTodos() =>
            _repository.ObterTodos();

        public IEnumerable<HistoricoStatus> ObterTodosAgrupados()
        {
            return _repository.ObterTodosAgrupados();
        }

        public bool Remover(int id)
        {
            using (var scope = new TransactionScope())
            {
                return _repository.Remover(id);
            }
        }
    }
}
