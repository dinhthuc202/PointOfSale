using API_POS.models;
using AutoMapper;
using Dapper;
using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Net;
using System.Security.Principal;
using System.Text.RegularExpressions;
using System.Xml.Linq;
using Z.Dapper.Plus;

namespace API_POS.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UserController : ControllerBase
    {
        private readonly IMapper _mapper;
        public UserController(IMapper mapper) { _mapper = mapper; }

        [HttpPost]
        [Route("Login")]
        public async Task<IActionResult> Login([FromBody] UserLogin user)
        {
            try
            {
                if (user == null || string.IsNullOrEmpty(user.UserName) || string.IsNullOrEmpty(user.Password))
                {
                    return BadRequest("Invalid data");
                }
                using (var connection = new SqlConnection(Common.connectionString))
                {
                    await connection.OpenAsync();
                    string query = @"SELECT * FROM [User] WHERE UserName = @UserName AND PassWord = @Password";

                    var result = await connection.QueryFirstOrDefaultAsync<User>(query, new { UserName = user.UserName!, Password = Encryptor.MD5Hash(user.Password) });
                    result!.Password = null;
                    if (result != null)
                    {
                        return Ok(result);
                    }
                    else
                    {
                        return Unauthorized("Invalid username or password");
                    }
                }
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Error: {ex.Message}");
            }
        }

        [HttpGet]
        [Route("GetAll")]
        public async Task<IActionResult> GetAllUser(string? filter)
        {
            try
            {
                using (var connection = new SqlConnection(Common.connectionString))
                {
                    await connection.OpenAsync();
                    //string query = string.IsNullOrEmpty(filter) ? @"SELECT * FROM [Supplier]" : $"SELECT * FROM [Supplier] WHERE Name LIKE '%{filter}%'";

                    string query = string.IsNullOrEmpty(filter) ?
                                    @"SELECT [ID]
                                  ,[UserName]
                                  ,[GroupID]
                                  ,[Name]
                                  ,[Address]
                                  ,[Email]
                                  ,[Phone]
                                  ,[ProvinceID]
                                  ,[DistrictID]
                                  ,[CreatedDate]
                                  ,[CreatedBy]
                                  ,[ModifiedDate]
                                  ,[ModifiedBy]
                                  ,[Status] FROM [User]"
                    : $"SELECT [ID],[UserName],[GroupID],[Name],[Address],[Email],[Phone],[ProvinceID],[DistrictID],[CreatedDate],[CreatedBy],[ModifiedDate],[ModifiedBy],[Status] FROM[User] WHERE Name LIKE '%{filter}%'";
                    var listUser = await connection.QueryAsync<User>(query);
                    return Ok(new
                    {
                        success = true,
                        listUser,
                    });
                }
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Error: {ex.Message}");
            }
        }

        [HttpPost]
        [Route("SignIn")]
        public async Task<IActionResult> SignIn([FromBody] UserSignIn userSignIn)
        {
            try
            {
                if (userSignIn == null || string.IsNullOrEmpty(userSignIn.UserName) || string.IsNullOrEmpty(userSignIn.Password) || !userSignIn.Status.HasValue)
                {
                    return BadRequest("Invalid data");
                }
                using (var connection = new SqlConnection(Common.connectionString))
                {
                    
                    await connection.OpenAsync();
                    DapperPlusManager.Entity<User>().Table("User");
                    User user = _mapper.Map<User>(userSignIn);

                    user.CreatedDate = DateTime.Now;
                    user.Password = Encryptor.MD5Hash(user.Password);
                    var insertedCount = connection.BulkInsert(new List<User>() { user }).Actions.Count;

                    if (insertedCount > 0)
                    {
                        return Ok(new
                        {
                            success = true,
                            message = $"Thêm user thành công",
                        });
                    }
                    else
                    {
                        return Ok(new
                        {
                            success = false,
                            message = $"Thêm user không thành công",
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
