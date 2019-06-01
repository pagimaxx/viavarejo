using ViaVarejo.AppService.Interfaces;
using ViaVarejo.AppService.Service;
using ViaVarejo.Domain.Interfaces.Repositories;
using ViaVarejo.Domain.Interfaces.Services;
using ViaVarejo.Domain.Services;
using ViaVarejo.Persistence.Connection;
using ViaVarejo.Persistence.Repositories;
using Microsoft.Extensions.DependencyInjection;

namespace Wevo.Infrastructure.CrossCutting.IoC
{
    public class InjectorContainer
    {
        public IServiceCollection ObterScopo(IServiceCollection interfaceService)
        {
            #region AppService

            interfaceService.AddScoped(typeof(IStatusPedidoAppService), typeof(StatusPedidoAppService));
            interfaceService.AddScoped(typeof(IProdutoAppService), typeof(ProdutoAppService));
            interfaceService.AddScoped(typeof(IPedidoAppService), typeof(PedidoAppService));
            interfaceService.AddScoped(typeof(IItemPedidoAppService), typeof(ItemPedidoAppService));
            interfaceService.AddScoped(typeof(IHistoricoStatusAppService), typeof(HistoricoStatusAppService));

            #endregion

            #region Service

            interfaceService.AddScoped(typeof(IStatusPedidoService), typeof(StatusPedidoService));
            interfaceService.AddScoped(typeof(IProdutoService), typeof(ProdutoService));
            interfaceService.AddScoped(typeof(IPedidoService), typeof(PedidoService));
            interfaceService.AddScoped(typeof(IItemPedidoService), typeof(ItemPedidoService));
            interfaceService.AddScoped(typeof(IHistoricoStatusService), typeof(HistoricoStatusService));

            #endregion

            #region Repository

            interfaceService.AddScoped(typeof(IStatusPedidoRepository), typeof(StatusPedidoRepository));
            interfaceService.AddScoped(typeof(IProdutoRepository), typeof(ProdutoRepository));
            interfaceService.AddScoped(typeof(IPedidoRepository), typeof(PedidoRepository));
            interfaceService.AddScoped(typeof(IItemPedidoRepository), typeof(ItemPedidoRepository));
            interfaceService.AddScoped(typeof(IHistoricoStatusRepository), typeof(HistoricoStatusRepository));
            interfaceService.AddScoped(typeof(IConnectionDB), typeof(ConnectionDB));

            #endregion

            return interfaceService;
        }
    }
}
