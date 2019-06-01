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
    /// API Status Pedido
    /// </summary>
    [Route("status-pedido")]
    [ApiController]
    public class StatusPedidoController : ControllerBase
    {
        private readonly IStatusPedidoAppService AppService;

        /// <summary>
        /// Construtor
        /// </summary>
        /// <param name="iStatusPedidoAppServico"></param>
        public StatusPedidoController(IStatusPedidoAppService iStatusPedidoAppServico)
        {
            AppService = iStatusPedidoAppServico;
        }

        #region Métodos

        /// <summary>
        /// Obtém informações dos status de pedido
        /// </summary>
        /// <param name="idUsuario">Código do Tipo de Suspensão de Usuário</param>
        /// <returns>Informações do usuário</returns>
        [HttpGet]
        [Route("obter-por-id")]
        public ResultadoPesquisa<StatusPedidoConsultaVM> ObterPorId(int idUsuario) =>
            new ResultadoPesquisa<StatusPedidoConsultaVM> { Resultado = AppService.ObterPorId(idUsuario) };

        /// <summary>
        /// Obtém a lista de todos status de pedido
        /// </summary>
        /// <returns>Retorna a lista de todos os usuários</returns>
        [HttpGet]
        [Route("obter-todos")]
        public ResultadoPesquisa<IEnumerable<StatusPedidoConsultaVM>> ObterTodos() =>
            new ResultadoPesquisa<IEnumerable<StatusPedidoConsultaVM>> { Resultado = AppService.ObterTodos() };

        /// <summary>
        /// Obtém a lista de todos os status de pedido por texto (busca)
        /// </summary>
        /// <returns>Retorna a lista de todos os usuários por texto (busca)</returns>
        [HttpGet]
        [Route("obter-por-texto")]
        public ResultadoPesquisa<IEnumerable<StatusPedidoConsultaVM>> ObterPorTexto(string texto) =>
            new ResultadoPesquisa<IEnumerable<StatusPedidoConsultaVM>> { Resultado = AppService.ObterPorTexto(texto) };


        /// <summary>
        /// Cadastrar Novo status de pedido
        /// </summary>
        /// <param name="statusPedido"></param>
        /// <param name="idUsuario"></param>
        /// <returns>Cadastrar novo usuário</returns>
        [HttpPost]
        [Route("cadastrar")]
        public ResultadoOperacao Cadastrar(StatusPedidoInclusaoVM statusPedido, int idUsuario) =>
            new ResultadoOperacao { Identificador = AppService.Cadastrar(statusPedido, idUsuario).ToString(), Sucesso = true };

        /// <summary>
        /// Atualizar o status de pedido
        /// </summary>
        /// <param name="idStatus"></param>
        /// <param name="idUsuario"></param>
        /// <returns>Atualizar o usuário</returns>
        [HttpPut]
        [Route("atualizar")]
        public ResultadoOperacao Atualizar(StatusPedidoAlteracaoVM idStatus, int idUsuario)
        {
            var result = AppService.Atualizar(idStatus, idUsuario);
            return new ResultadoOperacao { Identificador = idStatus.IdStatus.ToString(), Sucesso = (result.ToLower() == "true" ? true : false) };
        }

        /// <summary>
        /// Remover o status de pedido
        /// </summary>
        /// <param name="idStatus"></param>
        /// <returns></returns>
        [HttpDelete]
        [Route("remover")]
        public ResultadoOperacao Remover(int idStatus)
        {
            var resultado = false;
            resultado = AppService.Remover(idStatus);
            return new ResultadoOperacao { Identificador = idStatus.ToString(), Sucesso = resultado };
        }

        #endregion  
    }
}