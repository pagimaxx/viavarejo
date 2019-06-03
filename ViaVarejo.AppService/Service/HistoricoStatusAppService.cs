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
    public class HistoricoStatusAppService : IHistoricoStatusAppService
    {
        private readonly IHistoricoStatusService _service;

        /// <summary>
        /// Construtor
        /// </summary>
        /// <param name="service"></param>
        public HistoricoStatusAppService(IHistoricoStatusService service)
        {
            _service = service;
        }

        public string Atualizar(HistoricoStatusAlteracaoVM vm, int idUsuario)
        {
            var cb = MapperUtils.Map<HistoricoStatusAlteracaoVM, HistoricoStatus>(vm);
            cb.IdUsuarioAlteracao = 1;
            return _service.Atualizar(cb).ToString();
        }

        public string Cadastrar(HistoricoStatusInclusaoVM vm, int idUsuario)
        {
            var cb = MapperUtils.Map<HistoricoStatusInclusaoVM, HistoricoStatus>(vm);
            cb.IdUsuarioCadastro = 1;
            return _service.Cadastrar(cb).ToString();
        }

        public IEnumerable<HistoricoStatusConsultaVM> ObterPorDataStatus(DateTime dtInicial, DateTime dtFinal) =>
            MapperUtils.MapList<HistoricoStatus, HistoricoStatusConsultaVM>(_service.ObterPorDataStatus(dtInicial, dtFinal));

        public IEnumerable<HistoricoStatusConsultaVM> ObterPorIdPedido(int id) =>
            MapperUtils.MapList<HistoricoStatus, HistoricoStatusConsultaVM>(_service.ObterPorIdPedido(id));

        public IEnumerable<HistoricoStatusConsultaVM> ObterPorIdStatus(int id) =>
            MapperUtils.MapList<HistoricoStatus, HistoricoStatusConsultaVM>(_service.ObterPorIdStatus(id));

        public IEnumerable<HistoricoStatusConsultaVM> ObterTodos() =>
            MapperUtils.MapList<HistoricoStatus, HistoricoStatusConsultaVM>(_service.ObterTodos());

        public IEnumerable<HistoricoStatusConsultaVM> ObterTodosAgrupados() =>
            MapperUtils.MapList<HistoricoStatus, HistoricoStatusConsultaVM>(_service.ObterTodosAgrupados());

        public bool Remover(int id) =>
            _service.Remover(id);
    }
}
