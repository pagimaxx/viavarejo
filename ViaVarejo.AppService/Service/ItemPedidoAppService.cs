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
    public class ItemPedidoAppService : IItemPedidoAppService
    {
        private readonly IItemPedidoService _service;

        /// <summary>
        /// Construtor
        /// </summary>
        /// <param name="service"></param>
        public ItemPedidoAppService(IItemPedidoService service)
        {
            _service = service;
        }

        public string Atualizar(ItemPedidoAlteracaoVM vm, int idUsuario)
        {
            var cb = MapperUtils.Map<ItemPedidoAlteracaoVM, ItemPedido>(vm);
            cb.IdUsuarioAlteracao = 1;
            return _service.Atualizar(cb).ToString();
        }

        public string Cadastrar(ItemPedidoInclusaoVM vm, int idUsuario)
        {
            var cb = MapperUtils.Map<ItemPedidoInclusaoVM, ItemPedido>(vm);
            cb.IdUsuarioCadastro = 1;
            return _service.Cadastrar(cb).ToString();
        }

        public IEnumerable<ItemPedidoConsultaVM> ObterPorIdPedido(int id) =>
            MapperUtils.MapList<ItemPedido, ItemPedidoConsultaVM>(_service.ObterPorIdPedido(id));

        public IEnumerable<ItemPedidoConsultaVM> ObterPorIdProduto(int id) =>
            MapperUtils.MapList<ItemPedido, ItemPedidoConsultaVM>(_service.ObterPorIdProduto(id));

        public IEnumerable<ItemPedidoConsultaVM> ObterPorPrecoVenda(double valor1, double valor2) =>
            MapperUtils.MapList<ItemPedido, ItemPedidoConsultaVM>(_service.ObterPorPrecoVenda(valor1, valor2));

        public IEnumerable<ItemPedidoConsultaVM> ObterTodos() =>
            MapperUtils.MapList<ItemPedido, ItemPedidoConsultaVM>(_service.ObterTodos());

        public bool Remover(int id) =>
            _service.Remover(id);
    }
}
