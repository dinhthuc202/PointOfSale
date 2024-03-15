using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;
using Microsoft.AspNetCore.Mvc;
using System.Data.SqlClient;
using Z.Dapper.Plus;

namespace API_POS.models
{
    public class BusinessInfo
    {
        [Required]
        [StringLength(10)]
        public string Id { get; set; } = null!;
        [Required]
        public int Serial { get; set; }
        [StringLength(64)]
        [Required]
        public string Name { get; set; } = null!;
        [StringLength(128)]
        public string? Address { get; set; }
        [StringLength(32)]
        public string? Mobile { get; set; }
        [StringLength(128)]
        public string? Email { get; set; }

        public static async Task AddBusinessAsync(BusinessInfo business)
        {
            try
            {
                using (var connection = new SqlConnection(Common.connectionString))
                {
                    await connection.OpenAsync();
                    DapperPlusManager.Entity<BusinessInfo>().Table("BusinessInfo");
                    business.Serial = Common.NextId("BusinessInfo", "Id");
                    business.Id = business.Serial.ToString();   
                    connection.BulkInsert(new List<BusinessInfo>() { business });
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
            }
        }

    }
}
