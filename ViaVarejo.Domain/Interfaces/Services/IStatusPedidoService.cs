using System.Collections.Generic;
using ViaVarejo.Domain.Entities.Domain;

namespace ViaVarejo.Domain.Interfaces.Services
{
    public interface IStatusPedidoService
    {
        StatusPedido ObterPorId(int idStatus);
        IEnumerable<StatusPedido> ObterTodos();
        IEnumerable<StatusPedido> ObterPorTexto(string texto);
        int Cadastrar(StatusPedido statusPedido);
        bool Atualizar(StatusPedido statusPedido);
        bool Remover(int idStatus);
    }
}
