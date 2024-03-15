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
    public class SupplierController : ControllerBase
    {
        private readonly IMapper _mapper;
        public SupplierController(IMapper mapper) { _mapper = mapper; }
        [HttpGet]
        public async Task<IActionResult> Get(string? filter)
        {
            try
            {
                using (var connection = new SqlConnection(Common.connectionString))
                {
                    await connection.OpenAsync();
                    string query = string.IsNullOrEmpty(filter) ? @"SELECT * FROM [Supplier]" : $"SELECT * FROM [Supplier] WHERE Name LIKE '%{filter}%'";
                    var suppliers = await connection.QueryAsync<Supplier>(query);
                    return Ok(new
                    {
                        success = true,
                        suppliers,
                    });
                }
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Error: {ex.Message}");
            }
        }
        
        [HttpPost]
        public async Task<IActionResult> AddSupplier([FromBody] SupplierInput supplierInput)
        {
            try
            {
                using (var connection = new SqlConnection(Common.connectionString))
                {
                    await connection.OpenAsync();
                    Supplier supplier = _mapper.Map<Supplier>(supplierInput);
                    DapperPlusManager.Entity<Supplier>().Table("Supplier");

                    supplier.Id = Common.NextId("Supplier", "Id");
                    supplier.CreateDate = DateTime.Now;
                    var insertedCount = connection.BulkInsert(supplier).Actions.Count;

                    if (insertedCount > 0)
                    {
                        return Ok(new
                        {
                            success = true,
                            message = $"Thêm {supplier.Name} thành công",
                        });
                    }
                    else
                    {
                        return Ok(new
                        {
                            success = false,
                            message = $"Thêm {supplier.Name} không thành công",
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
        public async Task<IActionResult> EditSupplier([FromBody] SupplierEdit supplierEdit)
        {
            try
            {
                using (var connection = new SqlConnection(Common.connectionString))
                {
                    await connection.OpenAsync();
                    DapperPlusManager.Entity<Supplier>().Table("Supplier");
                    Supplier supplier = _mapper.Map<Supplier>(supplierEdit);


                    supplier.UpdateDate = DateTime.Now;
                    var insertedCount = connection.BulkUpdate(supplier).Actions.Count;

                    if (insertedCount > 0)
                    {
                        return Ok(new
                        {
                            success = true,
                            message = $"Sửa {supplier.Name} thành công",
                        });
                    }
                    else
                    {
                        return Ok(new
                        {
                            success = false,
                            message = $"Sửa {supplier.Name} không thành công",
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
        public async Task<IActionResult> DelSupplier(string id)
        {
            try
            {
                using (var connection = new SqlConnection(Common.connectionString))
                {
                    await connection.OpenAsync();
                    string query = $"DELETE FROM Supplier WHERE Id = @Id";
                    var affectedRows = await connection.ExecuteAsync(query, new { Id = id });
                    if (affectedRows > 0)
                    {
                        return Ok(new
                        {
                            success = true,
                            message = $"Xóa SupplierId:{id} thành công",
                        });
                    }
                    else
                    {
                        return BadRequest(new
                        {
                            success = false,
                            message = $"Xóa SupplierId:{id} không thành công",
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
