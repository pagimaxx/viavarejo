using System.Collections.Generic;
using ViaVarejo.AppService.ViewModels.Alteracao;
using ViaVarejo.AppService.ViewModels.Consulta;
using ViaVarejo.AppService.ViewModels.Inclusao;

namespace ViaVarejo.AppService.Interfaces
{
    public interface IStatusPedidoAppService
    {
        StatusPedidoConsultaVM ObterPorId(int idStatus);
        IEnumerable<StatusPedidoConsultaVM> ObterTodos();
        IEnumerable<StatusPedidoConsultaVM> ObterPorTexto(string texto);
        string Cadastrar(StatusPedidoInclusaoVM Usuario, int idStatus);
        string Atualizar(StatusPedidoAlteracaoVM Usuario, int idStatus);
        bool Remover(int idStatus);
    }
}
