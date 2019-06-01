using System.Collections.Generic;
using ViaVarejo.AppService.ViewModels.Alteracao;
using ViaVarejo.AppService.ViewModels.Consulta;
using ViaVarejo.AppService.ViewModels.Inclusao;

namespace ViaVarejo.AppService.Interfaces
{
    public interface IProdutoAppService
    {
        ProdutoConsultaVM ObterPorId(int idProduto);
        IEnumerable<ProdutoConsultaVM> ObterTodos();
        IEnumerable<ProdutoConsultaVM> ObterPorTexto(string texto);
        string Cadastrar(ProdutoInclusaoVM Usuario, int idProduto);
        string Atualizar(ProdutoAlteracaoVM Usuario, int idProduto);
        bool Remover(int idProduto);
    }
}
