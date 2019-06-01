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
    public class PedidoAppService : IPedidoAppService
    {
        private readonly IPedidoService _service;

        /// <summary>
        /// Construtor
        /// </summary>
        /// <param name="service"></param>
        public PedidoAppService(IPedidoService service)
        {
            _service = service;
        }

        public string Atualizar(PedidoAlteracaoVM vm, int idUsuario)
        {
            var cb = MapperUtils.Map<PedidoAlteracaoVM, Pedido>(vm);
            cb.IdUsuarioAlteracao = 1;
            return _service.Atualizar(cb).ToString();
        }

        public string Cadastrar(PedidoInclusaoVM vm, int idUsuario)
        {
            var cb = MapperUtils.Map<PedidoInclusaoVM, Pedido>(vm);
            cb.IdUsuarioCadastro = 1;
            return _service.Cadastrar(cb).ToString();
        }

        public PedidoConsultaVM ObterPorId(int id) =>
            MapperUtils.Map<Pedido, PedidoConsultaVM>(_service.ObterPorId(id));
        
        public IEnumerable<PedidoConsultaVM> ObterPorStatus(int status) =>
            MapperUtils.MapList<Pedido, PedidoConsultaVM>(_service.ObterPorStatus(status));

        public IEnumerable<PedidoConsultaVM> ObterPorValorPedido(double valor1, double valor2) =>
            MapperUtils.MapList<Pedido, PedidoConsultaVM>(_service.ObterPorValorPedido(valor1, valor2));

        public IEnumerable<PedidoConsultaVM> ObterPorDataPrevisaoEntrega(DateTime dataInicial, DateTime dataFinal) =>
            MapperUtils.MapList<Pedido, PedidoConsultaVM>(_service.ObterPorDataPrevisaoEntrega(dataInicial, dataFinal));

        public IEnumerable<PedidoConsultaVM> ObterTodos() =>
            MapperUtils.MapList<Pedido, PedidoConsultaVM>(_service.ObterTodos());

        public bool Remover(int id) =>
            _service.Remover(id);
    }
}
