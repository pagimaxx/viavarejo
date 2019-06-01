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
    public class StatusPedidoAppService : IStatusPedidoAppService
    {
        private readonly IStatusPedidoService _IStatusPedidoService;

        /// <summary>
        /// Construtor
        /// </summary>
        /// <param name="usuarioService"></param>
        public StatusPedidoAppService(IStatusPedidoService statusPedidoService)
        {
            _IStatusPedidoService = statusPedidoService;
        }

        public string Atualizar(StatusPedidoAlteracaoVM statusPedido, int idStatus)
        {
            var cb = MapperUtils.Map<StatusPedidoAlteracaoVM, StatusPedido>(statusPedido);
            cb.IdUsuarioAlteracao = 1;
            return _IStatusPedidoService.Atualizar(cb).ToString();
        }

        public string Cadastrar(StatusPedidoInclusaoVM statusPedido, int idStatus)
        {
            var cb = MapperUtils.Map<StatusPedidoInclusaoVM, StatusPedido>(statusPedido);
            cb.IdUsuarioCadastro = 1;
            return _IStatusPedidoService.Cadastrar(cb).ToString();
        }

        public StatusPedidoConsultaVM ObterPorId(int idStatus) =>
            MapperUtils.Map<StatusPedido, StatusPedidoConsultaVM>(_IStatusPedidoService.ObterPorId(idStatus));

        public IEnumerable<StatusPedidoConsultaVM> ObterPorTexto(string texto) =>
            MapperUtils.MapList<StatusPedido, StatusPedidoConsultaVM>(_IStatusPedidoService.ObterPorTexto(texto));

        public IEnumerable<StatusPedidoConsultaVM> ObterTodos() =>
            MapperUtils.MapList<StatusPedido, StatusPedidoConsultaVM>(_IStatusPedidoService.ObterTodos());

        public bool Remover(int idStatus) =>
            _IStatusPedidoService.Remover(idStatus);
    }
}
