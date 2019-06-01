using System;
using System.Collections.Generic;
using System.Data;
using Dapper;
using ViaVarejo.Infrastructure.CrossCutting.Enums;

namespace ViaVarejo.Persistence.Connection
{
    public static class SqlMapperExtension
    {
        public static IEnumerable<TReturn> CommandQuery<TFirst, TSecond, TThird, TFourth, TFifth, TSixth, TSeventh, TReturn>(this IDbConnection connection, string sql, Func<TFirst, TSecond, TThird, TFourth, TFifth, TSixth, TSeventh, TReturn> map, DataBaseType dataBaseType, object param = null, IDbTransaction transaction = null, bool buffered = true, string splitOn = "Id", int? commandTimeout = null, CommandType? commandType = null) =>
            connection.Query<TFirst, TSecond, TThird, TFourth, TFifth, TSixth, TSeventh, TReturn>(Treatment(sql, dataBaseType), map, param, transaction, buffered, splitOn, commandTimeout, commandType);

        public static IEnumerable<TReturn> CommandQuery<TFirst, TSecond, TThird, TFourth, TFifth, TSixth, TReturn>(this IDbConnection connection, string sql, Func<TFirst, TSecond, TThird, TFourth, TFifth, TSixth, TReturn> map, DataBaseType dataBaseType, object param = null, IDbTransaction transaction = null, bool buffered = true, string splitOn = "Id", int? commandTimeout = null, CommandType? commandType = null) =>
            connection.Query<TFirst, TSecond, TThird, TFourth, TFifth, TSixth, TReturn>(Treatment(sql, dataBaseType), map, param, transaction, buffered, splitOn, commandTimeout, commandType);

        public static IEnumerable<TReturn> CommandQuery<TFirst, TSecond, TThird, TFourth, TFifth, TReturn>(this IDbConnection connection, string sql, Func<TFirst, TSecond, TThird, TFourth, TFifth, TReturn> map, DataBaseType dataBaseType, object param = null, IDbTransaction transaction = null, bool buffered = true, string splitOn = "Id", int? commandTimeout = null, CommandType? commandType = null) =>
            connection.Query<TFirst, TSecond, TThird, TFourth, TFifth, TReturn>(Treatment(sql, dataBaseType), map, param, transaction, buffered, splitOn, commandTimeout, commandType);

        public static IEnumerable<TReturn> CommandQuery<TFirst, TSecond, TThird, TFourth, TReturn>(this IDbConnection connection, string sql, Func<TFirst, TSecond, TThird, TFourth, TReturn> map, DataBaseType dataBaseType, object param = null, IDbTransaction transaction = null, bool buffered = true, string splitOn = "Id", int? commandTimeout = null, CommandType? commandType = null) =>
            connection.Query<TFirst, TSecond, TThird, TFourth, TReturn>(Treatment(sql, dataBaseType), map, param, transaction, buffered, splitOn, commandTimeout, commandType);

        public static IEnumerable<TReturn> CommandQuery<TFirst, TSecond, TThird, TReturn>(this IDbConnection connection, string sql, Func<TFirst, TSecond, TThird, TReturn> map, DataBaseType dataBaseType, object param = null, IDbTransaction transaction = null, bool buffered = true, string splitOn = "Id", int? commandTimeout = null, CommandType? commandType = null) =>
            connection.Query<TFirst, TSecond, TThird, TReturn>(Treatment(sql, dataBaseType), map, param, transaction, buffered, splitOn, commandTimeout, commandType);

        public static IEnumerable<TReturn> CommandQuery<TFirst, TSecond, TReturn>(this IDbConnection connection, string sql, Func<TFirst, TSecond, TReturn> map, DataBaseType dataBaseType, object param = null, IDbTransaction transaction = null, bool buffered = true, string splitOn = "Id", int? commandTimeout = null, CommandType? commandType = null) =>
            connection.Query<TFirst, TSecond, TReturn>(Treatment(sql, dataBaseType), map, param, transaction, buffered, splitOn, commandTimeout, commandType);

        public static IEnumerable<T> CommandQuery<T>(this IDbConnection connection, string sql, DataBaseType dataBaseType, object param = null, IDbTransaction transaction = null, bool buffered = true, int? commandTimeout = null, CommandType? commandType = null) =>
            connection.Query<T>(Treatment(sql, dataBaseType), param, transaction, buffered, commandTimeout, commandType);

        public static object CommandExecuteScalar(this IDbConnection connection, string sql, DataBaseType dataBaseType, object param = null, IDbTransaction transaction = null, int? commandTimeout = null, CommandType? commandType = null) =>
            connection.ExecuteScalar(Treatment(sql, dataBaseType), param, transaction, commandTimeout, commandType);

        public static object CommandInsert(this IDbConnection connection, string sql, DataBaseType dataBaseType, object param = null, IDbTransaction transaction = null, int? commandTimeout = null, CommandType? commandType = null, string sequenceName = null)
        {
            object key = null;
            
            key = connection.ExecuteScalar(Treatment(sql, dataBaseType) + ";" + GetPrimaryKey(sequenceName, dataBaseType), param);

            return key;
        }

        public static int CommandExecute(this IDbConnection connection, string sql, DataBaseType dataBaseType, object param = null, IDbTransaction transaction = null, int? commandTimeout = null, CommandType? commandType = null) =>
            connection.Execute(Treatment(sql, dataBaseType), param, transaction, commandTimeout, commandType);

        public static string Treatment(string sql, DataBaseType dataBaseType = DataBaseType.Oracle)
        {
            switch (dataBaseType)
            {
                case DataBaseType.Oracle:
                    sql = sql.Replace("@", ":");
                    break;
                case DataBaseType.SqlServer:
                    sql = sql.Replace(":", "@");
                    break;
                case DataBaseType.PostgreSql:
                    sql = sql.Replace("@", ":");
                    break;
            }

            return sql;
        }

        public static string GetPrimaryKey(string sequence = null, DataBaseType dataBaseType = DataBaseType.Oracle)
        {
            var sql = "";
            switch (dataBaseType)
            {
                case DataBaseType.Oracle:
                    sql = " SELECT " + sequence + ".currval FROM DUAL";
                    break;
                case DataBaseType.SqlServer:
                    sql = " SELECT SCOPE_IDENTITY()";
                    break;
                case DataBaseType.PostgreSql:
                    break;
            }

            return sql;
        }
    }
}
