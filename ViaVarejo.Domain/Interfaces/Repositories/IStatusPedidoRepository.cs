using System.Collections.Generic;
using ViaVarejo.Domain.Entities.Domain;

namespace ViaVarejo.Domain.Interfaces.Repositories
{
    public interface IStatusPedidoRepository
    {
        StatusPedido ObterPorId(int idStatus);
        IEnumerable<StatusPedido> ObterTodos();
        IEnumerable<StatusPedido> ObterPorTexto(string texto);
        int Cadastrar(StatusPedido entity);
        bool Atualizar(StatusPedido entity);
        bool Remover(int idStatus);
    }
}
