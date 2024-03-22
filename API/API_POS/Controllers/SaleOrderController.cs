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
    public class SaleOrderController : ControllerBase
    {
        private readonly IMapper _mapper;
        public SaleOrderController(IMapper mapper) { _mapper = mapper; }
        [HttpPost]
        [Route("NewSale")]
        public async Task<IActionResult> NewSale([FromBody] SOInput input)
        {
            try
            {
                using (var connection = new SqlConnection(Common.connectionString))
                {
                    await connection.OpenAsync();
                    SO so = _mapper.Map<SO>(input);

                    so.Id = Common.NextId("SO", "Id").ToString();
                    so.Date = DateTime.Now;

                    DapperPlusManager.Entity<SO>().Table("SO");
                    var insertedCount = connection.BulkInsert(so).Actions.Count;
                    var insertedCount2 = 0;

                    //Thêm các mặt hàng
                    DapperPlusManager.Entity<SOD>().Table("SOD");
                    foreach (var item in input.sods!)
                    {
                        SOD sOD = _mapper.Map<SOD>(item);
                        sOD.Soid = so.Id;
                        //sOD.OpeningStock //Hàng trong kho thực hiện trừ đi khi bán nếu null để null (Quản lý kho)
                        insertedCount2 = connection.BulkInsert(sOD).Actions.Count;
                    }
                    DapperPlusManager.Entity<Payment>().Table("Payment");
                    Payment payment = new Payment();
                    payment.Id = Common.NextId("Payment", "Id");
                    payment.ReceivedDate = so.Date;
                    payment.PaymentAmount = so.BillPaid;
                    payment.PaymentMethod = so.PaymentMethod;
                    insertedCount2 = connection.BulkInsert(payment).Actions.Count;
                    return Ok();
                }
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Error: {ex.Message}");
            }
        }

        [HttpGet]
        public async Task<IActionResult> Get(string? filter)
        {
            try
            {
                using (var connection = new SqlConnection(Common.connectionString))
                {
                    await connection.OpenAsync();
                    string query = "SELECT * FROM [SO]";
                    IEnumerable<SO> sOs = await connection.QueryAsync<SO>(query);
                    List<SO> sOsList = sOs.ToList();

                    if (sOs != null)
                    {
                        for (int i = 0; i < sOsList.Count; i++)
                        {
                            string tmp = @$"SELECT * FROM [SOD] Where SOId = '{sOsList[i].Id}'";
                            IEnumerable<SOD> sODs = await connection.QueryAsync<SOD>(query);
                            sOsList[i].sODs = sODs.ToList();
                        }
                    }

                    return Ok(new
                    {
                        success = true,
                        sOsList,
                    });
                }
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Error: {ex.Message}");
            }
        }
    }
}
