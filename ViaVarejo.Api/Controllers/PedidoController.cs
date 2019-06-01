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
    [Route("pedido")]
    [ApiController]
    public class PedidoController : ControllerBase
    {
        private readonly IPedidoAppService AppService;

        /// <summary>
        /// Construtor
        /// </summary>
        /// <param name="iAppService"></param>
        public PedidoController(IPedidoAppService iAppService)
        {
            AppService = iAppService;
        }

        #region Métodos

        /// <summary>
        /// Obtém informações do Pedido
        /// </summary>
        /// <param name="idPedido">Código</param>
        /// <returns>Informações do registro selecionado</returns>
        [HttpGet]
        [Route("obter-por-id")]
        public ResultadoPesquisa<PedidoConsultaVM> ObterPorId(int idPedido) =>
            new ResultadoPesquisa<PedidoConsultaVM> { Resultado = AppService.ObterPorId(idPedido) };

        /// <summary>
        /// Obtém a lista de todos registros
        /// </summary>
        /// <returns>Retorna a lista de todos registros</returns>
        [HttpGet]
        [Route("obter-todos")]
        public ResultadoPesquisa<IEnumerable<PedidoConsultaVM>> ObterTodos() =>
            new ResultadoPesquisa<IEnumerable<PedidoConsultaVM>> { Resultado = AppService.ObterTodos() };

        /// <summary>
        /// Obtém a lista de todos os registros por status (busca)
        /// </summary>
        /// <returns>Retorna a lista de todos os registros por status (busca)</returns>
        [HttpGet]
        [Route("obter-por-status")]
        public ResultadoPesquisa<IEnumerable<PedidoConsultaVM>> ObterPorStatus(int status) =>
            new ResultadoPesquisa<IEnumerable<PedidoConsultaVM>> { Resultado = AppService.ObterPorStatus(status) };

        /// <summary>
        /// Obtém a lista de todos os registros por valor pedido (busca)
        /// </summary>
        /// <returns>Retorna a lista de todos os registros por valor pedido (busca)</returns>
        [HttpGet]
        [Route("obter-por-valor-pedido")]
        public ResultadoPesquisa<IEnumerable<PedidoConsultaVM>> ObterPorValorPedido(double valor1, double valor2) =>
            new ResultadoPesquisa<IEnumerable<PedidoConsultaVM>> { Resultado = AppService.ObterPorValorPedido(valor1, valor2) };

        /// <summary>
        /// Obtém a lista de todos os registros por data previsao de entrega (busca)
        /// </summary>
        /// <returns>Retorna a lista de todos os registros por previsao de entrega (busca)</returns>
        [HttpGet]
        [Route("obter-por-data-previsao-entrega")]
        public ResultadoPesquisa<IEnumerable<PedidoConsultaVM>> ObterPorDataPrevisaoEntrega(DateTime dataInicial, DateTime dataFinal) =>
            new ResultadoPesquisa<IEnumerable<PedidoConsultaVM>> { Resultado = AppService.ObterPorDataPrevisaoEntrega(dataInicial, dataFinal) };

        /// <summary>
        /// Cadastrar Novo Registro
        /// </summary>
        /// <param name="vm"></param>
        /// <param name="idUsuario"></param>
        /// <returns>Cadastrar novo registro</returns>
        [HttpPost]
        [Route("cadastrar")]
        public ResultadoOperacao Cadastrar(PedidoInclusaoVM vm, int idUsuario) =>
            new ResultadoOperacao { Identificador = AppService.Cadastrar(vm, idUsuario).ToString(), Sucesso = true };

        /// <summary>
        /// Atualizar o Pedido
        /// </summary>
        /// <param name="vm"></param>
        /// <param name="idUsuario"></param>
        /// <returns>Atualizar o registro</returns>
        [HttpPut]
        [Route("atualizar")]
        public ResultadoOperacao Atualizar(PedidoAlteracaoVM vm, int idUsuario)
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