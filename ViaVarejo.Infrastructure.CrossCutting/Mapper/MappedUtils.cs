using AutoMapper;
using System.Collections.Generic;
using System.Reflection;

namespace ViaVarejo.Infrastructure.CrossCutting.Mapper
{
    public class MapperUtils
    {
        #region Atributos
        public static IMapper _IMapper;
        #endregion

        #region Configuração

        public static void Initialize<TSource, TDestination>()
        {
            var config = new MapperConfiguration(x =>
            {
                x.CreateMap<TSource, TDestination>();
                x.CreateMap<TDestination, TSource>();
            });

            _IMapper = config.CreateMapper();
        }
        #endregion

        #region Métodos de Conversão

        /// <summary>
        /// Mapeamento de Entidade
        /// </summary>
        /// <typeparam name="TSource">Classe de Origem</typeparam>
        /// <typeparam name="TDestination">Classe Destino</typeparam>
        /// <param name="source">Entidade</param>
        public static TDestination Map<TSource, TDestination>(TSource source)
        {
            Initialize<TSource, TDestination>();
            var resultado = _IMapper.Map<TSource, TDestination>(source);
            return TransformToUpperCase<TDestination>(resultado);
        }

        /// <summary>
        /// Mapeamento de classe
        /// </summary>
        /// <typeparam name="TSource"></typeparam>
        /// <typeparam name="TDestination"></typeparam>
        /// <param name="source"></param>
        /// <param name="destination"></param>
        public static void Map<TSource, TDestination>(TSource source, TDestination destination)
        {
            Initialize<TSource, TDestination>();
            var resultado = _IMapper.Map<TSource, TDestination>(source, destination);
            TransformToUpperCase<TDestination>(resultado);
        }

        /// <summary>
        /// Método deve ser utilizado para mapear Listas
        /// </summary>
        /// <typeparam name="TSource">Entidade de Origem</typeparam>
        /// <typeparam name="TDestination">Entidade de Destino</typeparam>
        /// <param name="source">Lista de Objetos</param>
        public static IEnumerable<TDestination> MapList<TSource, TDestination>(IEnumerable<TSource> source)
        {
            Initialize<TSource, TDestination>();
            return _IMapper.Map<IEnumerable<TSource>, IEnumerable<TDestination>>(source);
        }

        /// <summary>
        /// Atualiza textos para caixa alta
        /// </summary>
        public static TDestination TransformToUpperCase<TDestination>(TDestination param)
        {
            if (param != null)
            {
                foreach (var item in param.GetType().GetProperties(BindingFlags.DeclaredOnly | BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic | BindingFlags.GetProperty | BindingFlags.SetProperty))
                {
                    if (item.PropertyType.Name.ToLower() == "string")
                        param.GetType().GetProperty(item.Name).SetValue(param, param.GetType().GetProperty(item.Name).GetValue(param).ToString().ToUpper());
                }
            }
            return param;
        }

        #endregion
    }
}
