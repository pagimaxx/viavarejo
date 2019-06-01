using System.Collections.Generic;
using ViaVarejo.Domain.Entities.Domain;

namespace ViaVarejo.Domain.Interfaces.Repositories
{
    public interface IProdutoRepository
    {
        Produto ObterPorId(int idProduto);
        IEnumerable<Produto> ObterTodos();
        IEnumerable<Produto> ObterPorTexto(string texto);
        int Cadastrar(Produto entity);
        bool Atualizar(Produto entity);
        bool Remover(int idProduto);
    }
}
