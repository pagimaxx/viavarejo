import DashboardLayout from "@/layout/dashboard/DashboardLayout.vue";
// GeneralViews
import NotFound from "@/pages/NotFoundPage.vue";

// Admin pages
import Dashboard from "@/pages/Dashboard.vue";
import PedidosIndex from "@/pages/Pedidos/Index.vue";
import PedidosDetail from "@/pages/Pedidos/Detail.vue";

const routes = [
  {
    path: "/",
    component: DashboardLayout,
    redirect: "/pedidos",
    children: [
      {
        path: "pedidos",
        name: "pedidos",
        component: PedidosIndex
      },
      {
        path: "pedidos-detalhes/:id?",
        name: "Detalhes do pedido",
        component: PedidosDetail
      }
    ]
  },
  { path: "*", component: NotFound }
];

/**
 * Asynchronously load view (Webpack Lazy loading compatible)
 * The specified component must be inside the Views folder
 * @param  {string} name  the filename (basename) of the view to load.
function view(name) {
   var res= require('../components/Dashboard/Views/' + name + '.vue');
   return res;
};**/

export default routes;
