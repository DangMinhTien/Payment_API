using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Payment_API.Application.Interface
{
    public interface ISqlService
    {
        public SqlParameter CreateOutputParameter(string name, SqlDbType type);
        public SqlParameter CreateOutputParameter(string name, SqlDbType type, int size);
        public (int, string) ExcuteNonQuery(string connectionString, string sqlObjectName,
            params SqlParameter[] parameters);
        Task<(int, string)> ExcuteNonQueryAsync(string connectionString, string sqlObjectName,
            params SqlParameter[] parameters);
        public (DataTable, string) FillDataTable(string connectionString, string sqlObjectName,
            params SqlParameter[] parameters);
        public Task<(DataTable, string)> FillDataTableAsync(string connectionString, string sqlObjectName,
            params SqlParameter[] parameters);
    }
}
