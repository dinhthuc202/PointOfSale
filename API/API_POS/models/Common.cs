using System.Data.SqlClient;
using Dapper;

namespace API_POS.models
{
    public class Common
    {
        public static string connectionString = "Data Source=DESKTOP-0O3810B;Initial Catalog=bPOS;User ID=sa;Password=123456";
        public static int NextId(string tableName, string colName)
        {
            using (var connection = new SqlConnection(connectionString))
            {
                connection.Open();
                string query = $"SELECT * FROM [{tableName}] ORDER BY [{colName}] DESC;";

                var result = connection.QueryFirstOrDefault<int?>(query);

                if (result.HasValue)
                {
                    return result.Value + 1;
                }
                else
                {
                    return 0;
                }
            }
        }

    }
}
