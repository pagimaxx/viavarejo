using AutoMapper;
using ViaVarejo.AppService.Interfaces;
using ViaVarejo.AppService.ViewModels.Alteracao;
using ViaVarejo.AppService.ViewModels.Consulta;
using ViaVarejo.AppService.ViewModels.Inclusao;
using ViaVarejo.Domain.Entities.Domain;
using ViaVarejo.Domain.Interfaces.Services;
using ViaVarejo.Infrastructure.CrossCutting.Mapper;
using System;
using System.Collections.Generic;
using System.Text;

namespace ViaVarejo.AppService.Service
{
    public class ProdutoAppService : IProdutoAppService
    {
        private readonly IProdutoService _produtoService;

        /// <summary>
        /// Construtor
        /// </summary>
        /// <param name="produtoService"></param>
        public ProdutoAppService(IProdutoService produtoService)
        {
            _produtoService = produtoService;
        }

        public string Atualizar(ProdutoAlteracaoVM Usuario, int idUsuario)
        {
            var cb = MapperUtils.Map<ProdutoAlteracaoVM, Produto>(Usuario);
            cb.IdUsuarioAlteracao = 1;
            return _produtoService.Atualizar(cb).ToString();
        }

        public string Cadastrar(ProdutoInclusaoVM produto, int idUsuario)
        {
            var cb = MapperUtils.Map<ProdutoInclusaoVM, Produto>(produto);
            cb.IdUsuarioCadastro = 1;
            return _produtoService.Cadastrar(cb).ToString();
        }

        public ProdutoConsultaVM ObterPorId(int idProduto) =>
            MapperUtils.Map<Produto, ProdutoConsultaVM>(_produtoService.ObterPorId(idProduto));

        public IEnumerable<ProdutoConsultaVM> ObterPorTexto(string texto) =>
            MapperUtils.MapList<Produto, ProdutoConsultaVM>(_produtoService.ObterPorTexto(texto));

        public IEnumerable<ProdutoConsultaVM> ObterTodos() =>
            MapperUtils.MapList<Produto, ProdutoConsultaVM>(_produtoService.ObterTodos());

        public bool Remover(int idProduto) =>
            _produtoService.Remover(idProduto);
    }
}
