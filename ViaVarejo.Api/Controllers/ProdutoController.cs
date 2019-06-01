using ViaVarejo.Api.Attributes;
using ViaVarejo.AppService.Interfaces;
using ViaVarejo.AppService.ViewModels.Alteracao;
using ViaVarejo.AppService.ViewModels.Consulta;
using ViaVarejo.AppService.ViewModels.Inclusao;
using ViaVarejo.Infrastructure.CrossCutting.Enums;
using ViaVarejo.Infrastructure.CrossCutting.Utilities.Results;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ViaVarejo.Api.Controllers
{
    /// <summary>
    /// API Produtos
    /// </summary>
    [Route("produto")]
    [ApiController]
    public class ProdutoController : ControllerBase
    {
        private readonly IProdutoAppService AppService;

        /// <summary>
        /// Construtor
        /// </summary>
        /// <param name="iAppService"></param>
        public ProdutoController(IProdutoAppService iAppService)
        {
            AppService = iAppService;
        }

        #region Métodos

        /// <summary>
        /// Obtém informações do produto
        /// </summary>
        /// <param name="idProduto">Código</param>
        /// <returns>Informações do registro selecionado</returns>
        [HttpGet]
        [Route("obter-por-id")]
        public ResultadoPesquisa<ProdutoConsultaVM> ObterPorId(int idProduto) =>
            new ResultadoPesquisa<ProdutoConsultaVM> { Resultado = AppService.ObterPorId(idProduto) };

        /// <summary>
        /// Obtém a lista de todos registros
        /// </summary>
        /// <returns>Retorna a lista de todos registros</returns>
        [HttpGet]
        [Route("obter-todos")]
        public ResultadoPesquisa<IEnumerable<ProdutoConsultaVM>> ObterTodos() =>
            new ResultadoPesquisa<IEnumerable<ProdutoConsultaVM>> { Resultado = AppService.ObterTodos() };

        /// <summary>
        /// Obtém a lista de todos os registros por texto (busca)
        /// </summary>
        /// <returns>Retorna a lista de todos os registros por texto (busca)</returns>
        [HttpGet]
        [Route("obter-por-texto")]
        public ResultadoPesquisa<IEnumerable<ProdutoConsultaVM>> ObterPorTexto(string texto) =>
            new ResultadoPesquisa<IEnumerable<ProdutoConsultaVM>> { Resultado = AppService.ObterPorTexto(texto) };


        /// <summary>
        /// Cadastrar Novo Registro
        /// </summary>
        /// <param name="vm"></param>
        /// <param name="idUsuario"></param>
        /// <returns>Cadastrar novo registro</returns>
        [HttpPost]
        [Route("cadastrar")]
        public ResultadoOperacao Cadastrar(ProdutoInclusaoVM vm, int idUsuario) =>
            new ResultadoOperacao { Identificador = AppService.Cadastrar(vm, idUsuario).ToString(), Sucesso = true };

        /// <summary>
        /// Atualizar o produto
        /// </summary>
        /// <param name="vm"></param>
        /// <param name="idUsuario"></param>
        /// <returns>Atualizar o registro</returns>
        [HttpPut]
        [Route("atualizar")]
        public ResultadoOperacao Atualizar(ProdutoAlteracaoVM vm, int idUsuario)
        {
            var result = AppService.Atualizar(vm, idUsuario);
            return new ResultadoOperacao { Identificador = vm.IdProduto.ToString(), Sucesso = (result.ToLower() == "true" ? true : false) };
        }

        /// <summary>
        /// Remover o registro
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [HttpDelete]
        [Route("remover")]
        public ResultadoOperacao Remover(int id)
        {
            var resultado = false;
            resultado = AppService.Remover(id);
            return new ResultadoOperacao { Identificador = id.ToString(), Sucesso = resultado };
        }

        #endregion  
    }
}