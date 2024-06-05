using Microsoft.AspNetCore.Mvc;
using Payment_API.Application.Interface;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Payment_API.Persistence.Persist
{
    public class SqlService : ISqlService
    {
        public SqlParameter CreateOutputParameter(string name, SqlDbType type)
        {
            var param = new SqlParameter(name, type);
            param.Direction = ParameterDirection.Output;
            return param;
        }

        public SqlParameter CreateOutputParameter(string name, SqlDbType type, int size)
        {
            var param = new SqlParameter(name, type, size);
            param.Direction = ParameterDirection.Output;
            return param;
        }

        public (int, string) ExcuteNonQuery(string connectionString, string sqlObjectName, params SqlParameter[] parameters)
        {
            int result = -1;
            string message = string.Empty;
            try
            {
                using(SqlConnection connection = new SqlConnection(connectionString))
                {
                    using(SqlCommand command = new SqlCommand(sqlObjectName, connection))
                    {
                        command.CommandType = CommandType.StoredProcedure;
                        command.CommandTimeout = 900;
                        command.Parameters.AddRange(parameters);
                        connection.Open();
                        result = command.ExecuteNonQuery();
                        connection.Close();
                    }
                }
            }
            catch(Exception ex)
            {
                message = ex.Message;
            }
            return (result, message);
        }

        public async Task<(int, string)> ExcuteNonQueryAsync(string connectionString, string sqlObjectName, params SqlParameter[] parameters)
        {
            int result = -1;
            string message = string.Empty;
            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    using (SqlCommand command = new SqlCommand(sqlObjectName, connection))
                    {
                        command.CommandType = CommandType.StoredProcedure;
                        command.CommandTimeout = 900;
                        command.Parameters.AddRange(parameters);
                        await connection.OpenAsync();
                        result = command.ExecuteNonQuery();
                        await connection.CloseAsync();
                    }
                }
            }
            catch (Exception ex)
            {
                message = ex.Message;
            }
            return (result, message);
        }

        public (DataTable, string) FillDataTable(string connectionString, string sqlObjectName, params SqlParameter[] parameters)
        {
            DataTable dt = new DataTable();
            string message = string.Empty;
            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    using (SqlCommand command = new SqlCommand(sqlObjectName, connection))
                    {
                        command.CommandType = CommandType.StoredProcedure;
                        command.CommandTimeout = 900;
                        command.Parameters.AddRange(parameters);
                        SqlDataAdapter adapter = new SqlDataAdapter();
                        adapter.SelectCommand = command;
                        connection.Open();
                        adapter.Fill(dt);
                        connection.Close();
                    }
                }
            }
            catch (Exception ex)
            {
                message = ex.Message;
            }
            return (dt, message);
        }

        public async Task<(DataTable, string)> FillDataTableAsync(string connectionString, string sqlObjectName, params SqlParameter[] parameters)
        {
            DataTable dt = new DataTable();
            string message = string.Empty;
            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    using (SqlCommand command = new SqlCommand(sqlObjectName, connection))
                    {
                        command.CommandType = CommandType.StoredProcedure;
                        command.CommandTimeout = 900;
                        command.Parameters.AddRange(parameters);
                        SqlDataAdapter adapter = new SqlDataAdapter();
                        adapter.SelectCommand = command;
                        await connection.OpenAsync();
                        adapter.Fill(dt);
                        await connection.CloseAsync();
                    }
                }
            }
            catch (Exception ex)
            {
                message = ex.Message;
            }
            return (dt, message);
        }
    }
}
