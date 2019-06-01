using System.Collections.Generic;
using ViaVarejo.Domain.Entities.Domain;

namespace ViaVarejo.Domain.Interfaces.Services
{
    public interface IProdutoService
    {
        Produto ObterPorId(int idProduto);
        IEnumerable<Produto> ObterTodos();
        IEnumerable<Produto> ObterPorTexto(string texto);
        int Cadastrar(Produto produto);
        bool Atualizar(Produto produto);
        bool Remover(int idProduto);
    }
}
