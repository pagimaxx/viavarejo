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
    [Route("item-pedido")]
    [ApiController]
    public class ItemPedidoController : ControllerBase
    {
        private readonly IItemPedidoAppService AppService;

        /// <summary>
        /// Construtor
        /// </summary>
        /// <param name="iAppService"></param>
        public ItemPedidoController(IItemPedidoAppService iAppService)
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
        public ResultadoPesquisa<IEnumerable<ItemPedidoConsultaVM>> ObterTodos() =>
            new ResultadoPesquisa<IEnumerable<ItemPedidoConsultaVM>> { Resultado = AppService.ObterTodos() };

        /// <summary>
        /// Obtém a lista de todos os registros por pedidos (busca)
        /// </summary>
        /// <returns>Retorna a lista de todos os registros pedido (busca)</returns>
        [HttpGet]
        [Route("obter-por-pedido")]
        public ResultadoPesquisa<IEnumerable<ItemPedidoConsultaVM>> ObterPorIdPedido(int id) =>
            new ResultadoPesquisa<IEnumerable<ItemPedidoConsultaVM>> { Resultado = AppService.ObterPorIdPedido(id) };

        /// <summary>
        /// Obtém a lista de todos os registros por preço da venda (busca)
        /// </summary>
        /// <returns>Retorna a lista de todos os registros por preço da venda (busca)</returns>
        [HttpGet]
        [Route("obter-por-preco-venda")]
        public ResultadoPesquisa<IEnumerable<ItemPedidoConsultaVM>> ObterPorPrecoVenda(double valor1, double valor2) =>
            new ResultadoPesquisa<IEnumerable<ItemPedidoConsultaVM>> { Resultado = AppService.ObterPorPrecoVenda(valor1, valor2) };

        /// <summary>
        /// Obtém a lista de todos os registros por produto (busca)
        /// </summary>
        /// <returns>Retorna a lista de todos os registros por previsao de entrega (busca)</returns>
        [HttpGet]
        [Route("obter-por-produto")]
        public ResultadoPesquisa<IEnumerable<ItemPedidoConsultaVM>> ObterPorIdProduto(int id) =>
            new ResultadoPesquisa<IEnumerable<ItemPedidoConsultaVM>> { Resultado = AppService.ObterPorIdProduto(id) };

        /// <summary>
        /// Cadastrar Novo Registro
        /// </summary>
        /// <param name="vm"></param>
        /// <param name="idUsuario"></param>
        /// <returns>Cadastrar novo registro</returns>
        [HttpPost]
        [Route("cadastrar")]
        public ResultadoOperacao Cadastrar(ItemPedidoInclusaoVM vm, int idUsuario) =>
            new ResultadoOperacao { Identificador = AppService.Cadastrar(vm, idUsuario).ToString(), Sucesso = true };

        /// <summary>
        /// Atualizar registro
        /// </summary>
        /// <param name="vm"></param>
        /// <param name="idUsuario"></param>
        /// <returns>Atualizar o registro</returns>
        [HttpPut]
        [Route("atualizar")]
        public ResultadoOperacao Atualizar(ItemPedidoAlteracaoVM vm, int idUsuario)
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