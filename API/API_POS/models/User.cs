using System.ComponentModel.DataAnnotations;

namespace API_POS.models
{
    public class User
    {
        public long? Id { get; set; }
        [Required]
        public string? UserName { get; set; }
        public string? Password { get; set; }
        public string? GroupId { get; set; }
        public string? Name { get; set; }
        public string? Address { get; set; }
        public string? Email { get; set; }
        public string? Phone { get; set; }
        public int? ProvinceId { get; set; }
        public int? DistrictId { get; set; }
        public DateTime? CreatedDate { get; set; }
        public string? CreatedBy { get; set; }
        public DateTime? ModifiedDate { get; set; }
        public string? ModifiedBy { get; set; }
        public bool? Status { get; set; }
    }

    public class UserLogin
    {
        [Required]
        public string UserName { get; set; } = string.Empty;
        [Required]
        public string Password { get; set; } = string.Empty;
    }
    public class UserSignIn
    {
        [Required]
        public string UserName { get; set; } = null!;
        [Required]
        public string Password { get; set; } = null!;
        public string? GroupId { get; set; }
        public string? Name { get; set; }
        public string? Address { get; set; }
        public string? Email { get; set; }
        public string? Phone { get; set; }
        public int? ProvinceId { get; set; }
        public int? DistrictId { get; set; }
        public string? CreatedBy { get; set; }
        public string? ModifiedBy { get; set; }
        public bool? Status { get; set; }
    }
}
