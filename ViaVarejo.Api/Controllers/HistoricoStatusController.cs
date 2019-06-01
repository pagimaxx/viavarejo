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
    /// API Pedidos
    /// </summary>
    [Route("historico-status")]
    [ApiController]
    public class HistoricoStatusController : ControllerBase
    {
        private readonly IHistoricoStatusAppService AppService;

        /// <summary>
        /// Construtor
        /// </summary>
        /// <param name="iAppService"></param>
        public HistoricoStatusController(IHistoricoStatusAppService iAppService)
        {
            AppService = iAppService;
        }

        #region Métodos

        /// <summary>
        /// Obtém a lista de todos registros
        /// </summary>
        /// <returns>Retorna a lista de todos registros</returns>
        [HttpGet]
        [Route("obter-todos")]
        public ResultadoPesquisa<IEnumerable<HistoricoStatusConsultaVM>> ObterTodos() =>
            new ResultadoPesquisa<IEnumerable<HistoricoStatusConsultaVM>> { Resultado = AppService.ObterTodos() };

        /// <summary>
        /// Obtém a lista de todos os registros por pedidos (busca)
        /// </summary>
        /// <returns>Retorna a lista de todos os registros pedido (busca)</returns>
        [HttpGet]
        [Route("obter-por-pedido")]
        public ResultadoPesquisa<IEnumerable<HistoricoStatusConsultaVM>> ObterPorIdPedido(int id) =>
            new ResultadoPesquisa<IEnumerable<HistoricoStatusConsultaVM>> { Resultado = AppService.ObterPorIdPedido(id) };

        /// <summary>
        /// Obtém a lista de todos os registros por preço da venda (busca)
        /// </summary>
        /// <returns>Retorna a lista de todos os registros por preço da venda (busca)</returns>
        [HttpGet]
        [Route("obter-por-status")]
        public ResultadoPesquisa<IEnumerable<HistoricoStatusConsultaVM>> ObterPorIdStatus(int id) =>
            new ResultadoPesquisa<IEnumerable<HistoricoStatusConsultaVM>> { Resultado = AppService.ObterPorIdStatus(id) };

        /// <summary>
        /// Obtém a lista de todos os registros por produto (busca)
        /// </summary>
        /// <returns>Retorna a lista de todos os registros por previsao de entrega (busca)</returns>
        [HttpGet]
        [Route("obter-por-data")]
        public ResultadoPesquisa<IEnumerable<HistoricoStatusConsultaVM>> ObterPorDataStatus(DateTime dtInicial, DateTime dtFinal) =>
            new ResultadoPesquisa<IEnumerable<HistoricoStatusConsultaVM>> { Resultado = AppService.ObterPorDataStatus(dtInicial, dtFinal) };

        /// <summary>
        /// Cadastrar Novo Registro
        /// </summary>
        /// <param name="vm"></param>
        /// <param name="idUsuario"></param>
        /// <returns>Cadastrar novo registro</returns>
        [HttpPost]
        [Route("cadastrar")]
        public ResultadoOperacao Cadastrar(HistoricoStatusInclusaoVM vm, int idUsuario) =>
            new ResultadoOperacao { Identificador = AppService.Cadastrar(vm, idUsuario).ToString(), Sucesso = true };

        /// <summary>
        /// Atualizar registro
        /// </summary>
        /// <param name="vm"></param>
        /// <param name="idUsuario"></param>
        /// <returns>Atualizar o registro</returns>
        [HttpPut]
        [Route("atualizar")]
        public ResultadoOperacao Atualizar(HistoricoStatusAlteracaoVM vm, int idUsuario)
        {
            var result = AppService.Atualizar(vm, idUsuario);
            return new ResultadoOperacao { Identificador = vm.IdPedido.ToString(), Sucesso = (result.ToLower() == "true" ? true : false) };
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