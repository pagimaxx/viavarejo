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
    public class ItemPedidoAppService : IItemPedidoService
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

        public bool Atualizar(ItemPedido vm)
        {
            var cb = MapperUtils.Map<ItemPedidoAlteracaoVM, ItemPedido>(vm);
            cb.IdUsuarioAlteracao = 1;
            return _service.Atualizar(cb).ToString();
        }

        public int Cadastrar(ItemPedido vm)
        {
            var cb = MapperUtils.Map<ItemPedidoInclusaoVM, ItemPedido>(vm);
            cb.IdUsuarioCadastro = 1;
            return _service.Cadastrar(cb).ToString();
        }

        public IEnumerable<ItemPedido> ObterPorIdPedido(int id)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<ItemPedido> ObterPorIdProduto(int id)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<ItemPedido> ObterPorPrecoVenda(double valor1, double valor2)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<ItemPedido> ObterTodos()
        {
            throw new NotImplementedException();
        }

        public bool Remover(int id)
        {
            throw new NotImplementedException();
        }
    }
}
