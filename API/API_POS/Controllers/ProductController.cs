using API_POS.models;
using AutoMapper;
using Dapper;
using Microsoft.AspNetCore.Mvc;
using System.Data.SqlClient;
using Z.Dapper.Plus;

namespace API_POS.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ProductController : ControllerBase
    {
        private readonly IMapper _mapper;
        public ProductController(IMapper mapper) { _mapper = mapper; }

        [HttpGet]
        public async Task<IActionResult> Get(string? filter)
        {
            try
            {
                using (var connection = new SqlConnection(Common.connectionString))
                {
                    await connection.OpenAsync();
                    string query = string.IsNullOrEmpty(filter) ? @"SELECT * FROM [Product]" : $"SELECT * FROM [Product] WHERE Name LIKE '%{filter}%'";

                    var products = await connection.QueryAsync<Product>(query);
                    return Ok(new
                    {
                        success = true,
                        products,
                    });
                }
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Error: {ex.Message}");
            }
        }

        [HttpPost]
        public async Task<IActionResult> AddProduct([FromBody] ProductInput productInput)
        {
            try
            {
                using (var connection = new SqlConnection(Common.connectionString))
                {
                    await connection.OpenAsync();
                    DapperPlusManager.Entity<Product>().Table("Product");
                    Product product = _mapper.Map<Product>(productInput);

                    product.Id = Common.NextId("Product", "Id");
                    product.CreateDate = DateTime.Now;
                    var insertedCount = connection.BulkInsert(product).Actions.Count;

                    if (insertedCount > 0)
                    {
                        return Ok(new
                        {
                            success = true,
                            message = $"Thêm {product.Name} thành công",
                        });
                    }
                    else
                    {
                        return Ok(new
                        {
                            success = false,
                            message = $"Thêm {product.Name} không thành công",
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
        public async Task<IActionResult> EditProduct([FromBody] ProductEdit productEdit)
        {
            try
            {
                using (var connection = new SqlConnection(Common.connectionString))
                {
                    await connection.OpenAsync();
                    DapperPlusManager.Entity<Product>().Table("Product");
                    Product product = _mapper.Map<Product>(productEdit);

                    product.UpdateDate = DateTime.Now;
                    var insertedCount = connection.BulkUpdate(product).Actions.Count;

                    if (insertedCount > 0)
                    {
                        return Ok(new
                        {
                            success = true,
                            message = $"Sửa {product.Name} thành công",
                        });
                    }
                    else
                    {
                        return Ok(new
                        {
                            success = false,
                            message = $"Sửa {product.Name} không thành công",
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
        public async Task<IActionResult> DelProduct(string id)
        {
            try
            {
                using (var connection = new SqlConnection(Common.connectionString))
                {
                    await connection.OpenAsync();
                    string query = $"DELETE FROM Product WHERE Id = @Id";
                    var affectedRows = await connection.ExecuteAsync(query, new  { Id = id });
                    if (affectedRows > 0)
                    {
                        return Ok(new
                        {
                            success = true,
                            message = $"Xóa ProductId:{id} thành công",
                        });
                    }
                    else
                    {
                        return BadRequest(new
                        {
                            success = false,
                            message = $"Xóa ProductId:{id} không thành công",
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
