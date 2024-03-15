using API_POS.models;
using AutoMapper;
using Dapper;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System.Data.SqlClient;
using Z.Dapper.Plus;

namespace API_POS.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class CustomerController : ControllerBase
    {
        private readonly IMapper _mapper;
        public CustomerController(IMapper mapper) { _mapper = mapper; }
        [HttpGet]
        public async Task<IActionResult> Get(string? filter)
        {
            try
            {
                using (var connection = new SqlConnection(Common.connectionString))
                {
                    await connection.OpenAsync();
                    string query = string.IsNullOrEmpty(filter) ? @"SELECT * FROM [Customer]" : $"SELECT * FROM [Customer] WHERE Name LIKE '%{filter}%'";
                    var customers = await connection.QueryAsync<Customer>(query);
                    return Ok(new
                    {
                        success = true,
                        customers,
                    });
                }
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Error: {ex.Message}");
            }
        }

        [HttpPost]
        public async Task<IActionResult> AddCustomer([FromBody] CustomerInput customerInput)
        {
            try
            {
                using (var connection = new SqlConnection(Common.connectionString))
                {
                    await connection.OpenAsync();
                    DapperPlusManager.Entity<Customer>().Table("Customer");
                    Customer customer = _mapper.Map<Customer>(customerInput);

                    customer.Id = Common.NextId("Customer", "Id");
                    customer.CreateDate = DateTime.Now;
                    var insertedCount = connection.BulkInsert(customer).Actions.Count;

                    if (insertedCount > 0)
                    {
                        return Ok(new
                        {
                            success = true,
                            message = $"Thêm {customer.Name} thành công",
                        });
                    }
                    else
                    {
                        return Ok(new
                        {
                            success = false,
                            message = $"Thêm {customer.Name} không thành công",
                        });
                    }
                }
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Error: {ex.Message}");
            }
        }

        [HttpPut]
        public async Task<IActionResult> EditCustomer([FromBody] CustomerEdit customerEdit)
        {
            try
            {
                using (var connection = new SqlConnection(Common.connectionString))
                {
                    await connection.OpenAsync();
                    DapperPlusManager.Entity<Customer>().Table("Customer");
                    Customer customer = _mapper.Map<Customer>(customerEdit);

                    customer.UpdateDate = DateTime.Now;
                    var insertedCount = connection.BulkUpdate(customer).Actions.Count;

                    if (insertedCount > 0)
                    {
                        return Ok(new
                        {
                            success = true,
                            message = $"Sửa {customer.Name} thành công",
                        });
                    }
                    else
                    {
                        return Ok(new
                        {
                            success = false,
                            message = $"Sửa {customer.Name} không thành công",
                        });
                    }
                }
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Error: {ex.Message}");
            }
        }

        [HttpDelete]
        public async Task<IActionResult> DelCustomer(string id)
        {
            try
            {
                using (var connection = new SqlConnection(Common.connectionString))
                {
                    await connection.OpenAsync();
                    string query = $"DELETE FROM Customer WHERE Id = @Id";
                    var affectedRows = await connection.ExecuteAsync(query, new { Id = id });
                    if (affectedRows > 0)
                    {
                        return Ok(new
                        {
                            success = true,
                            message = $"Xóa CustomerId:{id} thành công",
                        });
                    }
                    else
                    {
                        return BadRequest(new
                        {
                            success = false,
                            message = $"Xóa CustomerId:{id} không thành công",
                        });
                    }
                }
            }
            catch (Exception ex)
            {

                return StatusCode(500, $"Error: {ex.Message}");
            }
        }
    }
}
